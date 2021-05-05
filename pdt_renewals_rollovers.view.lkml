view: pdt_renewals_rollovers {
  derived_table: {
    sql: SELECT
        Pim.Policy_id as CurrentPolicyID,
        PIM.Policyimage_num as CurrentPolicyImage,
        PIM.policy as CurrentPolicy,
        PH1.display_name AS policyholder1_displayname,
        PH.Phone_num,
        PIMRLRO.Policy_id as RolloverPolicyID,
        PIMRLRO.policy as RolloverPolicy,
        PIM.exp_date as RenewalDate,
        CASE
          WHEN v.LOB_ID = 1 THEN 'Amigo Blue'
          WHEN v.LOB_ID = 2 THEN 'Amigo America'
          WHEN v.LOB_ID = 3 THEN 'Amigo USA'
          ELSE 'N/A' END as Lobname,
        CASE WHEN PIMRLRO.policy is NULL THEN 0 ELSE 1 END as RolloverGenerated,
        prt.process_date as Printeddate,
        PrintBatchStatus,
        CASE WHEN PIMRoll.policy_id is not NULL THEN 1 ELSE 0 END as RolledOver,
        q.Balance as PolicyBalance,
        CASE WHEN PIM.Transtype_id = 1  THEN -PIM.premium_chg_fullterm ELSE PIM.Premium_fullterm END as CurrentWrittenPremium,
        COALESCE(PIMRLRO.premium_fullterm, 0) as RenewalWrittenPremium,
        PIM.Renewal_ver as RenewalVersion,
        A.Code as AgencyCode,
        n.display_name as AgencyName,
        CASE WHEN PIM.Transtype_id = 1  THEN 1 ELSE 0 END as Cancelled,
        CASE WHEN PIM.Transtype_id = 1  THEN tr.dscr ELSE '' END as CancelledReason,
        CASE WHEN PIM.Transtype_id = 1  THEN p.cancel_date ELSE NULL END as CancelledDate,
        CASE WHEN PIMRLRO.policy is NULL and P.nonrenew = 1 THEN 1 ELSE 0 END as NonRenew,
        CASE WHEN
          CASE WHEN PIM.Transtype_id = 1  THEN -PIM.premium_chg_fullterm ELSE PIM.Premium_fullterm END
            > COALESCE(PIMRLRO.premium_fullterm, 0)
          THEN 'Decrease'
          ELSE
            CASE WHEN
              CASE WHEN PIM.Transtype_id = 1  THEN -PIM.premium_chg_fullterm ELSE PIM.Premium_fullterm END
              < COALESCE(PIMRLRO.premium_fullterm, 0) THEN 'Increase'
              ELSE
                'No Change'
            END
        END as PremiumDiff,
        CASE WHEN PIE.Policy_id is NULL then 'No' ELSE 'Yes' END as EndorsementFlag,
        PremiumChange as EndorsementPremiumChange,
    premium_fullterm_1 RolloverDownpay,
    lpay.lastpayment,
    lpay.added_date lastpaydate
      FROM ProductionBackup.dbo.Policy P
      INNER JOIN (Select Policy_id, Max(policyimage_num) policyimage_num
          FROM ProductionBackup.dbo.PolicyImage
          WHERE exp_date >= '2021-05-01'
            AND exp_date < CAST(GETDATE() as date)
            AND Policy_id > -1
            AND policystatuscode_id in (1,3)
          GROUP BY Policy_id) MPIM
            ON MPIM.Policy_id = P.Policy_id
      INNER JOIN ProductionBackup.dbo.PolicyImage PIM WITH (NOLOCK)
        ON PIM.policy_id = MPIM.policy_id
        AND PIM.policyimage_num = MPIM.policyimage_num
        AND PIM.Policy_id > -1
        AND PIM.Transtype_id <> 1
      LEFT JOIN ProductionBackup.dbo.TransReason TR on TR.transreason_id = Pim.transreason_id
      INNER JOIN ProductionBackup.dbo.Agency a ON a.agency_id = pim.agency_id
      INNER JOIN ProductionBackup.dbo.AgencyNameLink anl ON a.agency_id = anl.agency_id
      INNER JOIN ProductionBackup.dbo.Name n ON n.name_id = anl.name_id
      INNER JOIN ProductionBackup.dbo.Version v ON v.version_id = PIM.version_id
      INNER JOIN ProductionBackup.dbo.CompanyStateLOB csl ON csl.companystatelob_id = v.companystatelob_id
      INNER JOIN ProductionBackup.dbo.CompanyLOB cl ON csl.companylob_id = cl.companylob_id
          AND cl.company_id = 1 -- Clear SPrings
      INNER JOIN ProductionBackup.dbo.[PolicyImageNameLink] pnl
            ON pnl.policy_id = PIM.policy_id
      AND pnl.policyimage_num = PIM.policyimage_num
      AND pnl.nameaddresssource_id = 3
      INNER JOIN ProductionBackup.dbo.[Name] PH1 WITH (NOLOCK)
          ON PH1.name_id = pnl.name_id
      LEFT JOIN (Select policy_id, phone_num,
          ROW_Number() OVER(Partition By POlicy_id  order by policy_id, phonetype_id) as Rownbr
          FROM ProductionBackup.dbo.Phone) ph on ph.policy_id = p.policy_id
              and ph.Rownbr = 1
      JOIN (Select v.policy_id, Balance from  ProductionBackup.dbo.vBillingstatementBalance v
            JOIN (select policy_id, max(billingactivityorder) maxorder
                from ProductionBackup.dbo.vBillingstatementBalance
                group by policy_id) v1
            ON v1.policy_id = v.policy_id
            AND v1.maxorder = v.billingactivityorder) q
          ON q.policy_id = pim.policy_id
    LEFT JOIN (Select bc.Policy_id, amount as lastpayment, added_date from billingcash bc
          join (select policy_id, max(billingcash_id) maxbcid from billingcash
            where billingcashtype_id = 1
            group by policy_id) maxid
              ON maxid.maxbcid = bc.billingcash_id) lpay
          ON pim.policy_id = lpay.policy_id
      LEFT JOIN (Select Policy_id, sum(premium_chg_written) as PremiumChange from ProductionBackup.dbo.PolicyImage
                  where transtype_id = 3
                  group by Policy_id having ABS(sum(premium_chg_written)) > 50)  PIE
          ON PIE.Policy_id = p.policy_id
      LEFT JOIN ProductionBackup.dbo.Policy pp ON pp.rewrittenfrom_policy_id = p.policy_id
      LEFT JOIN (Select policy_id, Max(policyimage_num) as policyimage_num
                FROM ProductionBackup.dbo.PolicyImage
                WHERE Transtype_id in (13, 4)
                GROUP BY policy_id) maxPI
                    ON maxPI.Policy_id = pp.policy_id
      LEFT JOIN ProductionBackup.dbo.PolicyImage PIMRLRO -- Rollover Policy Renewal Offer
          ON maxPI.Policy_id = PIMRLRO.policy_id
          AND PIMRLRO.policyimage_num = maxPI.policyimage_num
    LEFT JOIN ProductionBackup.dbo.RenewalOffers RO
      ON RO.policy_id = PIMRLRO.policy_id
      AND RO.renewal_ver = PIMRLRO.renewal_ver
      LEFT JOIN ProductionBackup.dbo.PolicyImage PIMRoll  -- Rollover Policy Renewed
          ON PIMRoll.Policy_id = pp.policy_id
          AND PIMRoll.Transtype_id = 4

      LEFT JOIN (SELECT DISTINCT /*needed because of policy form*/
              PP.printprocess_id,
              PP.process_date,
              --max(PIM.eff_date),
              --count(1)
              --FV.formversion_id,
              PP.printevent_id,
              PP.printxml_id,
              PP.policy_id,
              PP.policyimage_num,
              BS.description as PrintBatchStatus,
              PIM.[policy],
              PIM.version_id,
              PIM.eff_date
            FROM ProductionBackup.dbo.PrintProcess PP
            INNER JOIN ProductionBackup.dbo.PolicyImage PIM WITH (NOLOCK)
              ON PIM.policy_id = PP.policy_id
                AND PIM.policyimage_num = PP.policyimage_num
            INNER JOIN ProductionBackup.dbo.[Version] V WITH (NOLOCK)
              ON V.version_id = PIM.version_id
            --INNER JOIN ProductionBackup.dbo.PolicyForm PF WITH (NOLOCK)
            --  ON PF.policy_id = PP.policy_id
            --    AND PF.policyimage_num = PP.policyimage_num
            --    AND PF.printxml_id = PP.printxml_id
            INNER JOIN ProductionBackup.dbo.PrintXML PX
              ON PP.policy_id = PX.policy_id
                AND PP.policyimage_num = PX.policyimage_num
                AND PP.printxml_id = PX.printxml_id
            INNER JOIN ProductionBackup.dbo.BatchStatus bs ON
                bs.batchstatus_id = PX.batchstatus_id
            --INNER JOIN ProductionBackup.dbo.FormVersion FV WITH (NOLOCK)
            --  ON FV.formversion_id = PF.formversion_id
            LEFT OUTER JOIN ProductionBackup.dbo.FutureEvents FE WITH(NOLOCK)
              ON FE.policy_id = PIM.policy_id
            LEFT OUTER JOIN ProductionBackup.dbo.TransReasonVersion TRV WITH (NOLOCK)
              ON TRV.version_id = PIM.version_id
                AND TRV.transreason_id = PIM.transreason_id
            WHERE
              PP.printevent_id = 162
              ) prt
                ON  prt.policy_id = PIMRLRO.policy_id
                  AND Pim.exp_date = prt.eff_date
        WHERE
      (pim.policystatuscode_id = 1
        OR
      (pim.policystatuscode_id = 3 and p.Cancel_date >= DATEADD(d, -1, PIM.exp_date)))

     ;;
    sql_trigger_value: Select MAX(pcadded_date) from ProductionBackup.dbo.policyimage;;
    indexes: ["CurrentPolicyID"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: current_policy_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.CurrentPolicyID ;;
  }

  dimension: current_policyimage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.CurrentPolicyImage ;;
  }


  dimension: current_policy {
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
    label: "Current Policy Number"
    type: string
    sql: ${TABLE}.CurrentPolicy ;;
  }

  dimension: policyholder1_displayname {
    label: "Policy Holder Name"
    type: string
    sql: ${TABLE}.policyholder1_displayname ;;
  }

  dimension: phone_num {
    label: "Policy Holder Phone"
    type: string
    sql: ${TABLE}.phone_num ;;
  }

  dimension: rollover_policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RolloverPolicyID ;;
  }

  dimension: rollover_policy {
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
    label: "Rollover Policy Number"
    type: string
    sql: ${TABLE}.RolloverPolicy ;;
  }

  dimension: renewal_date {
    type: date
    sql: ${TABLE}.RenewalDate ;;
  }

  dimension: lobname {
    type: string
    sql: ${TABLE}.Lobname ;;
  }

  measure: rollover_generated {
    label: "RolloverGenerated_Count"
    type: sum
    sql: ${TABLE}.RolloverGenerated ;;
  }

  dimension_group: printeddate {
    type: time
    sql: ${TABLE}.Printeddate ;;
  }

  dimension: print_batch_status {
    type: string
    sql: ${TABLE}.PrintBatchStatus ;;
  }

  dimension: rollover_downpay {
    type: number
    value_format_name: usd
    sql: ${TABLE}.rolloverdownpay ;;
  }

  dimension: lastpayment_amount {
    type: number
    value_format_name: usd
    sql: ${TABLE}.lastpayment ;;
  }

  dimension: lastpayment_date {
    type: number
    value_format_name: usd
    sql: ${TABLE}.lastpaydate ;;
  }

  measure: rolled_over {
    label: "RolledOver_Count"
    type: sum
    sql: ${TABLE}.RolledOver ;;
  }

  measure: policy_balance {
    label: "Policy Balance"
    type: sum
    sql: ${TABLE}.PolicyBalance ;;
  }

  measure: current_written_premium {
    label: "Current Written Premium"
    type: sum
    sql: ${TABLE}.CurrentWrittenPremium ;;
  }

  measure: renewal_written_premium {
    label: "Rollover Written Premium"
    type: sum
    sql: ${TABLE}.RenewalWrittenPremium ;;
  }

  dimension: renewal_version {
    label: "Renewal Version"
    type: number
    sql: ${TABLE}.RenewalVersion ;;
  }

  dimension: agency_code {
    type: string
    sql: ${TABLE}.AgencyCode ;;
  }

  dimension: agency_name {
    type: string
    sql: ${TABLE}.AgencyName ;;
  }

  dimension: premium_movement {
    label: "Rollover Premium Direction Flag"
    type: string
    sql: ${TABLE}.PremiumDiff ;;
  }

  dimension: endorsement_flag {
    label: "Endorsement Flag"
    type: string
    sql: ${TABLE}.EndorsementFlag ;;
  }

  measure: cancelled {
    label: "Cancelled_Count"
    type: sum
    sql: ${TABLE}.Cancelled ;;
  }

  dimension: cancelled_reason {
    label: "Cancelled Reason"
    type: string
    sql: ${TABLE}.CancelledReason ;;
  }

  dimension_group: cancelled_date {
    type: time
    sql: ${TABLE}.CancelledDate ;;
  }

  dimension: non_renew {
    type: number
    sql: ${TABLE}.NonRenew ;;
  }

  dimension: endorsement_premium_change {
    type: number
    hidden: yes
    sql: ${TABLE}.EndorsementPremiumChange ;;
  }
  dimension: errors {
    label: "Rollover Error"
    type: string
    sql: CASE WHEN ${TABLE}.RolloverPolicyID is NULL THEN 'No Rollover Replacement Offer or Policy Created'
              ELSE
                CASE WHEN ${TABLE}.Printeddate is NULL AND ${TABLE}.RolledOver = 0 THEN 'No Replacement Document Created'
                   ELSE
                    CASE WHEN ${TABLE}.PrintBatchStatus = 'Unprocessed' THEN 'Document Created by not Batched'
                    END
                END
          END;;
  }
  set: detail {
    fields: [
      current_policy,
      rollover_policy,
      renewal_date,
      lobname,
      rollover_generated,
      printeddate_time,
      print_batch_status,
      rolled_over,
      policy_balance,
      current_written_premium,
      renewal_written_premium,
      renewal_version,
      agency_code,
      agency_name,
      cancelled,
      cancelled_reason,
      cancelled_date_time,
      non_renew,
      dt_coverage_liab_phys.liab_phys,
      premium_movement,
      endorsement_flag,
      endorsement_premium_change
    ]
  }
}

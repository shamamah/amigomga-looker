view: dt_cash_and_fees {
    derived_table: {
      sql: SELECT
          CAST(BC.added_date as date)
          AS trans_date,
          V.company_id,
          V.State_id,
          V.Lob_id,
          LOB.Lobname,
          A.Agency_id,
          A.agencygroup_id,
          pim.policy,
          pim.policy_id,
          pim.policyimage_num,
          pim.renewal_ver,
          pim.eff_date,
          ISNULL(billingchargetypecategory_id,5) as FeeInd,
          ISNULL(BCIC.dscr, 'Other') as PaymentType,
          COALESCE(BCCT.dscr, BCDT.dscr) AS CashDetailDscr,
          ISNULL(BCIS.dscr, 'UnKnown') AS CashSource,
          U.display_name + ' - ' + U.login_name AS login_name,
          -SUM(COALESCE(BCMD.amount, BCD.amount)) AS amount,
          CASE WHEN COALESCE(BCCT.dscr, BCDT.dscr) like '%Premium%' THEN -SUM(BC.amount) ELSE 0 END as pay_amount,
          -SUM(CASE WHEN COALESCE(BCCT.dscr, BCDT.dscr) = 'Premium'
              THEN COALESCE(BCMD.amount, BCD.amount)*(ACD.amount/100) ELSE 0 END) as AgencyCommission
          FROM BillingCash BC WITH (NOLOCK)
          INNER JOIN dbo.vUsers U WITH (NOLOCK)
              ON U.users_id = BC.users_id
          INNER JOIN BillingCashDetail BCD WITH (NOLOCK)
            ON BCD.policy_id = BC.policy_id
              AND BCD.billingcash_num = BC.billingcash_num
          INNER JOIN BillingCashDetailType BCDT WITH (NOLOCK)
            ON BCDT.billingcashdetailtype_id = BCD.billingcashdetailtype_id
          INNER JOIN BillingCashType BCT WITH (NOLOCK)
            ON BC.billingcashtype_id = BCT.billingcashtype_id
          LEFT OUTER JOIN BillingCashMChgDetail BCMD WITH (NOLOCK)
            ON BCMD.policy_id = BCD.policy_id
              AND BCMD.billingcashdetail_num = BCD.billingcashdetail_num
          LEFT OUTER JOIN BillingChargeCredit BCC WITH (NOLOCK)
            ON BCC.policy_id = BCMD.policy_id
              AND BCC.billingchargecredit_num = BCMD.billingchargecredit_num
          LEFT OUTER JOIN BillingChargesCreditsType BCCT WITH (NOLOCK)
            ON BCCT.billingchargescreditstype_id = BCC.billingchargescreditstype_id
          INNER JOIN (SELECT policy_id, renewal_ver, MIN(policyimage_num) AS policyimage_num
                    FROM PolicyImage WITH (NOLOCK)
              WHERE policy_id >=-1
                    GROUP BY policy_id, renewal_ver) PIM2
            ON PIM2.policy_id = BC.policy_id
              AND PIM2.renewal_ver = BCD.renewal_ver
          INNER JOIN PolicyImage PIM WITH (NOLOCK)
            ON PIM.policy_id = PIM2.policy_id
              AND PIM.policyimage_num = PIM2.policyimage_num
              AND PIM.policy_id >=-1
          INNER JOIN Version V WITH (NOLOCK)
            ON V.version_id = PIM.version_id
          INNER JOIN LOB LOB WITH (NOLOCK)
              ON LOB.lob_id = V.lob_id
          INNER JOIN Agency A
            ON A.Agency_id = PIM.Agency_id
          LEFT OUTER JOIN AgencyCommission AC
              ON ac.agency_id = pim.agency_id
              AND ac.companystatelob_id = v.lob_id
              AND pim.eff_date between ac.start_date and CASE WHEN ac.end_date = '1800-01-01' THEN '2199-12-31' ELSE ac.end_date END
          LEFT OUTER JOIN [AgencyCommissionDetailType] acdt
              ON acdt.companystatelob_id = v.lob_id
              AND acdt.description = CASE WHEN PIM.renewal_ver = 1 THEN 'New Business' ELSE 'Renewal' END
          LEFT OUTER JOIN AgencyCommissionDetail ACD
            ON acd.AgencyCommission_id = ac.agencycommission_id
            AND acd.AgencyCommissionDetailType_id = acdt.agencycommissiondetailtype_id
          LEFT OUTER JOIN BillingCashInSource BCIS WITH (NOLOCK)
            ON BCIS.billingcashinsource_id = BC.billingcashinsource_id
          LEFT OUTER JOIN BillingCashInSourceCategory BCIC WITH (NOLOCK)
            ON BCIC.billingcashinsourcecategory_id = BCIS.billingcashinsourcecategory_id
          INNER JOIN PolicyImageNameLink PNL WITH (NOLOCK)
            ON PNL.policy_id = PIM.policy_id
              AND PNL.policyimage_num = PIM.policyimage_num
              AND PNL.nameaddresssource_id = 5
          INNER JOIN [Name] N WITH (NOLOCK)
            ON N.name_id = PNL.name_id
          WHERE PIM.Policy_id <> 286372
          group by
          pim.policy,
          CAST(BC.added_date as date),
          --CAST(LEFT(DATENAME(month, COALESCE(BCD.added_date, BC.added_date)), 3) as varchar(3)) + ' ' +
          --CAST(YEAR(COALESCE(BCD.added_date, BC.added_date)) as varchar(4)),
          V.company_id,
          V.State_id,
          V.Lob_id,
          LOB.Lobname,
          A.Agency_id,
          A.agencygroup_id,
          COALESCE(BCCT.dscr, BCDT.dscr),
          pim.policy_id,
          pim.policyimage_num,
          pim.renewal_ver,
          pim.eff_date,
          ISNULL(billingchargetypecategory_id,5),
          ISNULL(BCIC.dscr, 'Other'),
          ISNULL(BCIS.dscr, 'UnKnown'),
          U.display_name + ' - ' + U.login_name
 ;;
    }

  dimension: cash_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.trans_date, ' ', ${TABLE}.policyimage_num, ' ', ${TABLE}.CashDetailDscr, ' ', ${TABLE}.PaymentType, ' ', ${TABLE}.CashSource);;
  }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension_group: trans_date {
      type: time
      sql: ${TABLE}.trans_date ;;
    }

    dimension: company_id {
      type: number
      hidden: yes
      sql: ${TABLE}.company_id ;;
    }

    dimension: state_id {
      type: number
      hidden: yes
      sql: ${TABLE}.State_id ;;
    }

    dimension: lob_id {
      type: number
      hidden: yes
      sql: ${TABLE}.Lob_id ;;
    }

  dimension: lob_name {
    label: "LOB"
    type: string
    sql: ${TABLE}.Lobname ;;
  }
    dimension: agency_id {
      type: number
      hidden: yes
      sql: ${TABLE}.Agency_id ;;
    }

    dimension: agencygroup_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencygroup_id ;;
    }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      hidden: yes
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.renewal_ver ;;
    }

    dimension: eff_date {
      label: "Policy Eff Date"
      type: date
      hidden: yes
      sql: ${TABLE}.eff_date ;;
    }

    dimension: payment_type {
      label: "Payment Type"
      type: string
      sql: ${TABLE}.Paymenttype ;;

    }

    dimension: cash_source {
      label: "Cash Source"
      type: string
      sql: ${TABLE}.CashSource ;;

    }

  dimension: policy {
    label: "Policy Number"
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
    type: string
    hidden: yes
    sql: ${TABLE}.Policy ;;

  }

  dimension: login_name {
    label: "Login name"
    type: string
    hidden: yes
    sql: ${TABLE}.login_name ;;

  }

    dimension: cash_detail_dscr {
      type: string
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN 'Collected Premium'
                WHEN ${TABLE}.CashDetailDscr = 'Service Charge' THEN 'Installment Fee'
                ELSE ${TABLE}.CashDetailDscr END;;
    }

    dimension: fee_ind {
      label: "Fee Indicator"
      type: string
      sql: CASE WHEN ${TABLE}.CashDetailDscr like '%fee' or
        ${TABLE}.CashDetailDscr = 'Service Charge' Then 'Fee' else 'Other' END ;;
    }

    measure: cash_collected {
      label: "Collected Premium"
      type: sum
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' Then ${TABLE}.amount else 0 END ;;
    }

    measure: mga_commission {
      label: "MGA Commission"
      type: sum
      value_format: "#,##0.00"
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN ${TABLE}.amount * 0.17 ELSE 0 END ;;
    }

    measure: ulae_fee {
      label: "ULAE"
      type: sum
      value_format: "#,##0.00"
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN ${TABLE}.amount * 0.07 ELSE 0 END ;;
    }

    measure: claims_admin {
      label: "Claims Administration"
      type: sum
      value_format: "#,##0.00"
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN ${TABLE}.amount * 0.07 ELSE 0 END ;;
    }

    measure: fee_total {
      label: "Fee Income"
         type: sum

        sql: CASE WHEN ${TABLE}.CashDetailDscr like '%fee' or
          ${TABLE}.CashDetailDscr = 'Service Charge' Then ${TABLE}.amount ELSE 0 END ;;
    }

    measure: premium_tax {
      label: "Premium Tax"
      type: sum
      sql: CASE WHEN ${TABLE}.CashDetailDscr in ('Premium', 'Policy Fee') Then ${TABLE}.amount *.02 ELSE 0 END ;;
    }

    measure: outside_services {
      label: "Outside Services"
      type: sum
      value_format: "#,##0.00"
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN ${TABLE}.amount * 0.015 ELSE 0 END ;;
    }

    measure: mvr_postage {
      label: "MVR, Postage"
      type: sum
      value_format: "#,##0.00"
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN ${TABLE}.amount * 0.02 ELSE 0 END ;;
    }

    measure: epo {
      label: "BPO"
      type: sum
      value_format: "#,##0.00"
      sql: CASE WHEN ${TABLE}.CashDetailDscr = 'Premium' THEN ${TABLE}.amount * 0.038 ELSE 0 END ;;
    }

    measure: agency_commission {
      label: "Producer Commission"
      type: sum
      value_format: "#,##0.00"
      sql: ${TABLE}.AgencyCommission;;
    }
     measure: amount {
      label: " Fee and Premium Amount"
      type: sum
      sql: ${TABLE}.amount ;;
      drill_fields: [detail*]
    }

#   -- Hiding this because need to work on when there is a premium credit.  FYI Policy_id 973336
    measure: pay_amount {
      label: " Payment Amount"
      type: sum
      hidden: yes
      sql: ${TABLE}.pay_amount ;;
      drill_fields: [detail*]
    }


    set: addl_payables_detail {
      fields: [outside_services,
        epo,
        mvr_postage]

    }
    set: detail {
      fields: [
        policy,
        trans_date_time,
        lob_name,
        eff_date,
        cash_detail_dscr,
        login_name,
        amount
      ]
    }
  }

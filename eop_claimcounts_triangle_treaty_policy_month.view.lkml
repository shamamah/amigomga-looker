view: eop_claimcounts_triangle_treaty_policy_month {
  derived_table: {
    sql:  SELECT DATEDIFF(m, t.eff_date, ProcessingDate) as treaty_month,
            CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date) END as policy_month,
            DATEDIFF(m, t.eff_date, ProcessingDate)  -
            CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date) END as lag_month,
            DATEDIFF(m, '2019-05-01', ProcessingDate) as trans_month,
            company_id,
            state_id,
            z.lob_id,
            CASE WHEN z.lob_id = 1 AND coveragecode_id = 9 THEN 8 ELSE coveragecode_id END as coveragecode_id,
            CASE WHEN z.lob_id = 1 AND FeatDscr = 'UM PD' THEN 'UM/UIM BI' ELSE FeatDscr END as caption,
        --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
            CASE WHEN renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
            Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
            Sum(CASE WHEN ActionType = 'Reported' THEN 1 ELSE 0 END) as Reported,
            Sum(MonthlyClose) as Closed,
            Sum(CASE WHEN ClosedType = 'CWOP' and MonthlyClose = 1 THEN 1 ELSE 0 END) as ClosedNoPay,
            Sum(CASE WHEN ClosedType = 'CWP' and MonthlyClose = 1 THEN 1 ELSE 0 END) as ClosedPay,
            SUM(Outstanding) as Outstanding


     From (Select row_number() over (order by claim_number, claimfeature_num, Claimant_num, ProcessingDate) as id,
            ProcessingDate,
            Reported_date,
            Loss_date,
            Company_id,
            LOB_id,
            State_id,
            claim_number,
            policy_id,
            Policyimage_num,
            FeatDscr,
            coveragecode_id,
            claimfeature_num,
            Claimant_num,
            claimcontrol_id,
            ActionType,
            ClosedType,
            FirstClose,
            FirstOpen,
            monthlyClose,
            ActivityAge,
            Outstanding,
            policy,
            renewal_ver,
            eff_date,
            paid
            FROM (Select
                    CAST(cfa.Added_date as Datetime) ProcessingDate,
                    cc.Reported_Date,
                    cc.Loss_Date,
                    Company_id,
                    LOB_id,
                    State_id,
                    cc.claim_number,
                    PolImg.policy_id,
                    PolImg.Policyimage_num,
                    ClmFeat.coverage_dscr AS FeatDscr, --+ ' ' + ClmFeat.subcoverage_dscr
                    ClaimCoverage.coveragecode_id,
                    CFA.claimfeature_num,
                    CFA.Claimant_num,
                    cc.claimcontrol_id,
                    CASE WHEN CFA.claimactivitycode_id = 2  THEN 'Closed'
                            ELSE 'Open' END as ActionType,
                    CASE WHEN CFA.claimactivitycode_id = 2 THEN
                        CASE WHEN z.claimcontrol_id is NULL THEN 'CWOP'
                            ELSE 'CWP' END
                    END as ClosedType,
                    CASE WHEN CFA.claimactivitycode_id = 2 and cd.claimcontrol_id is not NULL THEN 1
                        ELSE 0 END AS FirstClose,
                    CASE WHEN CFA.claimactivitycode_id = 1 and od.claimcontrol_id is not NULL THEN 1
                        ELSE 0 END AS FirstOpen,
                    CASE WHEN CFA.claimactivitycode_id = 2 and cm.claimcontrol_id is not NULL THEN 1
                        ELSE 0 END AS monthlyClose,
                    DATEDIFF(d, cc.Reported_Date, cfa.added_date) as ActivityAge,
                    CASE WHEN CFA.claimactivitycode_id = 1 THEN 1 ELSE -1 END as Outstanding,
                    policy,
          renewal_ver,
                    PolImg.eff_date,
                    0 as paid
            FROM ClaimFeature ClmFeat WITH(NOLOCK)
      INNER JOIN ProductionBackup.dbo.ClaimCoverage WITH(NOLOCK)
          ON ClmFeat.claimcontrol_id  = ClaimCoverage.claimcontrol_id
          AND ClmFeat.claimexposure_id = ClaimCoverage.claimexposure_id
          AND ClmFeat.claimsubexposure_num = ClaimCoverage.claimsubexposure_num
          AND ClmFeat.claimcoverage_num = ClaimCoverage.claimcoverage_num
            INNER JOIN ClaimControl CC WITH(NOLOCK)
          ON ClmFeat.claimcontrol_id = CC.claimcontrol_id
            INNER JOIN ClaimFeatureActivity CFA WITH(NOLOCK)
          ON ClmFeat.claimcontrol_id = CFA.claimcontrol_id
          AND ClmFeat.claimant_num = CFA.claimant_num
          AND ClmFeat.claimfeature_num = CFA.claimfeature_num
          AND claimactivitycode_id IN (1, 2)
            LEFT OUTER JOIN
                      (Select min(added_date) added_date, claimcontrol_id, claimant_num, claimfeature_num, sum(amount) amount
                       FROM Claimtransaction
                       WHERE amount > 0
              and claimtransactioncategory_id = 2
             GROUP by claimcontrol_id, claimant_num, claimfeature_num) z
               ON z.claimcontrol_id = CFA.claimcontrol_id
                AND z.claimant_num = CFA.claimant_num
                AND z.claimfeature_num = CFA.claimfeature_num
                AND z.added_date <= cfa.Added_date
            LEFT OUTER JOIN dbo.ClaimFeatureActivity od
          ON cfa.claimcontrol_id = od.claimcontrol_id
          AND cfa.claimant_num = od.claimant_num
          AND cfa.claimfeature_num = od.claimfeature_num
          AND cfa.num = od.num
          AND od.claimactivitycode_id = 1
          AND cfa.num = (SELECT MIN(num)
                  FROM dbo.ClaimFeatureActivity CCA
                  WHERE CCA.claimcontrol_id = cfa.claimcontrol_id
                  AND cfa.claimant_num = CCA.claimant_num
                  AND cfa.claimfeature_num = CCA.claimfeature_num
                  --AND CFA.added_date = CCA.added_date
                  AND CCA.claimactivitycode_id = 1)
          AND cc.claimcontrol_id >= -1
          AND cc.policy_id >= -1
           LEFT OUTER JOIN dbo.ClaimFeatureActivity cd
          ON cfa.claimcontrol_id = cd.claimcontrol_id
          AND cfa.claimant_num = cd.claimant_num
          AND cfa.claimfeature_num = cd.claimfeature_num
          AND cfa.num = cd.num
          AND cd.claimactivitycode_id = 2
          AND cfa.num = (SELECT MIN(num)
                  FROM dbo.ClaimFeatureActivity CCA
                  WHERE CCA.claimcontrol_id = cfa.claimcontrol_id
                  AND cfa.claimant_num = CCA.claimant_num
                  AND cfa.claimfeature_num = CCA.claimfeature_num
                  --AND CFA.added_date = CCA.added_date
                  AND CCA.claimactivitycode_id = 2)
          AND cc.claimcontrol_id >= -1
          AND cc.policy_id >= -1
      LEFT OUTER JOIN (Select
          claimcontrol_id, Claimant_num, claimfeature_num,
          month(added_date) ActionMonth, year(added_date) ActionYear, MAX(Num) num
          FROM ProductionBackup.dbo.ClaimFeatureActivity
            WHERE claimactivitycode_id IN (1, 2)
          GROUP BY claimcontrol_id, Claimant_num, claimfeature_num,
          month(added_date), year(added_date)) cm
            ON cm.claimcontrol_id = cfa.claimcontrol_id
            AND cm.claimant_num = cfa.claimant_num
            AND cm.claimfeature_num = cfa.claimfeature_num
            AND cm.num = cfa.num
      INNER JOIN PolicyImage PolImg WITH(NOLOCK)
          ON CC.policy_id = PolImg.policy_id
          AND CC.policyimage_num = PolImg.policyimage_num
      INNER JOIN [Version] V WITH (NOLOCK)
          ON V.version_id = PolImg.version_id

                    UNION ALL

                    Select
                CAST(CAST(od.added_date as Date) as Datetime) ProcessingDate,
                od.added_date Reported_Date,
                cc.Loss_date,
                Company_id,
                LOB_id,
                State_id,
                cc.claim_number,
                PolImg.policy_id,
                PolImg.Policyimage_num,
                ClmFeat.coverage_dscr AS FeatDscr, --+ ' ' + ClmFeat.subcoverage_dscr
                ClaimCoverage.coveragecode_id,
                ClmFeat.claimfeature_num,
                ClmFeat.Claimant_num,
                CC.claimcontrol_id,
                'Reported' as ActionType,
                NULL,
                0,
                0,
                0,
                0,
                0 as Outstanding,
                policy,
                renewal_ver,
                PolImg.eff_date,
                0 as paid
            FROM ClaimFeature ClmFeat WITH(NOLOCK)
            INNER JOIN ProductionBackup.dbo.ClaimCoverage WITH(NOLOCK)
        ON ClmFeat.claimcontrol_id  = ClaimCoverage.claimcontrol_id
        AND ClmFeat.claimexposure_id = ClaimCoverage.claimexposure_id
        AND ClmFeat.claimsubexposure_num = ClaimCoverage.claimsubexposure_num
        AND ClmFeat.claimcoverage_num = ClaimCoverage.claimcoverage_num
            INNER JOIN ClaimControl CC WITH(NOLOCK)
                ON ClmFeat.claimcontrol_id = CC.claimcontrol_id
            INNER JOIN PolicyImage PolImg WITH(NOLOCK)
                ON CC.policy_id = PolImg.policy_id
                AND CC.policyimage_num = PolImg.policyimage_num
            INNER JOIN [Version] V WITH (NOLOCK)
                ON V.version_id = PolImg.version_id
      LEFT OUTER JOIN dbo.ClaimFeatureActivity od
        ON ClmFeat.claimcontrol_id = od.claimcontrol_id
        AND ClmFeat.claimant_num = od.claimant_num
        AND ClmFeat.claimfeature_num = od.claimfeature_num
        AND od.claimactivitycode_id = 1
        AND od.num = (SELECT MIN(num)
            FROM dbo.ClaimFeatureActivity CCA
            WHERE CCA.claimcontrol_id = ClmFeat.claimcontrol_id
            AND ClmFeat.claimant_num = CCA.claimant_num
            AND ClmFeat.claimfeature_num = CCA.claimfeature_num
            --AND CFA.added_date = CCA.added_date
            AND CCA.claimactivitycode_id = 1)
        AND cc.claimcontrol_id >= -1
        AND cc.policy_id >= -1

          UNION ALL

          Select
                    CAST(cf.added_date as Datetime) ProcessingDate,
                    cf.added_date as Reported_Date,
          loss_date,
                    Company_id,
                    LOB_id,
                    State_id,
                    ClaimControl.claim_number,
                    PolicyImage.policy_id,
                    PolicyImage.Policyimage_num,
                    ClmFeat.coverage_dscr,-- + ' ' + ClmFeat.subcoverage_dscr AS FeatDscr,
          ClaimCoverage.coveragecode_id,
                    ClmFeat.claimfeature_num,
                    ClmFeat.Claimant_num,
                    ClaimControl.claimcontrol_id,
                    'Payment' as ActionType,
                    NULL,
                    0,
                    0,
                    0,
                    0,
                    0 as Outstanding,
                    policy,
          renewal_ver,
                    PolicyImage.eff_date,
                    indemnity_paid as paid
                 FROM ProductionBackup.dbo.ClaimFeatureEOD CFE WITH(NOLOCK)
            INNER JOIN ProductionBackup.dbo.ClaimFeature ClmFeat WITH(NOLOCK)
              ON CFE.claimcontrol_id = ClmFeat.claimcontrol_id
                AND  CFE.claimant_num = ClmFeat.claimant_num
                AND CFE.claimfeature_num = ClmFeat.claimfeature_num
            INNER JOIN ProductionBackup.dbo.ClaimCoverage WITH(NOLOCK)
              ON ClmFeat.claimcontrol_id  = ClaimCoverage.claimcontrol_id
                AND ClmFeat.claimexposure_id = ClaimCoverage.claimexposure_id
                AND ClmFeat.claimsubexposure_num = ClaimCoverage.claimsubexposure_num
                AND ClmFeat.claimcoverage_num = ClaimCoverage.claimcoverage_num
            INNER JOIN ProductionBackup.dbo.ClaimControl WITH(NOLOCK)
              ON ClmFeat.claimcontrol_id = ClaimControl.claimcontrol_id
            INNER JOIN ProductionBackup.dbo.PolicyImage WITH(NOLOCK)
              ON ClaimControl.policy_id = PolicyImage.policy_id
                AND ClaimControl.policyimage_num = PolicyImage.policyimage_num
            LEFT OUTER JOIN ProductionBackup.dbo.PackagePart PP WITH (NOLOCK)
              ON ClaimControl.policy_id = PP.policy_id
                AND ClaimControl.policyimage_num = PP.policyimage_num
                AND ClaimControl.packagepart_num = PP.packagepart_num
            INNER JOIN ProductionBackup.dbo.CoverageCodeVersion WITH(NOLOCK)
              ON ClaimCoverage.coveragecode_id = CoverageCodeVersion.coveragecode_id
                AND CoverageCodeVersion.version_id = COALESCE(PP.version_id, PolicyImage.version_id)
            INNER JOIN ProductionBackup.dbo.ClaimFinancials CF WITH(NOLOCK)
              ON CFE.claimcontrol_id = CF.claimcontrol_id
              AND CFE.claimfinancials_num = CF.claimfinancials_num
            INNER JOIN ProductionBackup.dbo.[Version] V WITH(NOLOCK)
              ON V.version_id = COALESCE(PP.version_id, PolicyImage.version_id)
            WHERE CFE.claimeoplevel_id = 3
            and cf.indemnity_paid <> 0) a) z
  LEFT JOIN Customer_reports.dbo.Treaty t
    ON z.eff_date between t.eff_date and t.exp_date
    AND z.lob_id = t.lob_id
 -- WHERE z.loss_date > z.eff_date
    GROUP BY
        DATEDIFF(m, t.eff_date, ProcessingDate),
    CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date) END,
    DATEDIFF(m, t.eff_date, ProcessingDate)  -
    CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date) END,
    DATEDIFF(m, '2019-05-01', ProcessingDate),
        company_id,
        state_id,
        z.lob_id,
        CASE WHEN z.lob_id = 1 AND coveragecode_id = 9 THEN 8 ELSE coveragecode_id END,
        CASE WHEN z.lob_id = 1 AND FeatDscr = 'UM PD' THEN 'UM/UIM BI' ELSE FeatDscr END ,
    --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
        CASE WHEN renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
        Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
   ;;
  }

  dimension: unique_key  {
    type: string
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_month},'_',${trans_month},'_',${lag_month},'_',${treaty_month},'_',${coveragecode_id},'_',${new_ren},'_',${lob_id}) ;;
  }

  dimension: trans_month {
    type: number
    hidden: yes
    sql: ${TABLE}.trans_month ;;
  }

  dimension: lag_month {
    type: number
    hidden: yes
    sql: ${TABLE}.lag_month ;;
  }

  dimension: policy_month {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_month ;;
  }

  dimension: treaty_month {
    type: number
    hidden: yes
    sql: ${TABLE}.treaty_month ;;
  }

  dimension: company_id {
    type: number
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: state_id {
    type: number
    hidden: yes
    sql: ${TABLE}.state_id ;;
  }

  dimension: lob_id {
    type: number
    hidden: yes
    sql: ${TABLE}.lob_id ;;
  }

  dimension: coveragecode_id {
    type: number
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: caption {
    type: string
    hidden: yes
    sql: ${TABLE}.caption ;;
  }

  dimension: new_ren {
    type: string
    hidden: yes
    sql: ${TABLE}.NewRen ;;
  }

  dimension: treaty {
    type: string
    hidden: yes
    sql: ${TABLE}.treaty ;;
  }

  measure: reported {
    type: sum
    sql: ${TABLE}.Reported ;;
    drill_fields: [detail*]
  }

  measure: closed {
    type: sum
    sql: ${TABLE}.Closed ;;
    drill_fields: [detail*]
  }

  measure: closed_no_pay {
    type: sum
    sql: ${TABLE}.ClosedNoPay ;;
    drill_fields: [detail*]
  }

  measure: closed_pay {
    type: sum
    sql: ${TABLE}.ClosedPay ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      trans_month,
      lag_month,
      policy_month,
      company_id,
      state_id,
      lob_id,
      coveragecode_id,
      caption,
      new_ren,
      reported,
      closed,
      closed_no_pay,
      closed_pay
    ]
  }


}

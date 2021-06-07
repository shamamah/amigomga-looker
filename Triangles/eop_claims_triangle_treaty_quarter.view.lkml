view: eop_claims_triangle_treaty_quarter {
  derived_table: {
    sql: SELECT
              DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') / 3 as treaty_quarter,
              CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 END as policy_quarter,
              DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') / 3  -
              CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 END as lag_quarter,
--              DATEDIFF(m, '2019-05-01', CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') / 3 as trans_quarter,
              V.company_id,
              V.state_id,
              V.lob_id,
              CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END as coveragecode_id,
              CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END as caption,
    --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
              CASE WHEN policyimage.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
              policyimage.Renewal_ver,
              Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
    --          PolicyImage.policy_id,
    --          PolicyImage.Policyimage_num,
    --          PolicyImage.renewal_ver,
    --          ISNULL(CCV.Vehicle_num, 1) as vehicle_num,
    --          policy,
    --         PolicyImage.eff_date,
              --claim_number,
              SUM(indemnity_reserve) AS LossReserve,
              SUM(indemnity_paid) AS LossPaid,
              SUM(salvage) AS Salvage,
              SUM(subro) AS Subro,
              SUM(alae_reserve + expense_reserve) AS expense_reserve,
              SUM(alae_paid + expense_paid) AS expense_paid

            FROM ClaimFeatureEOD CFE WITH(NOLOCK)
            INNER JOIN ClaimFeature WITH(NOLOCK)
              ON CFE.claimcontrol_id = ClaimFeature.claimcontrol_id
                AND  CFE.claimant_num = ClaimFeature.claimant_num
                AND CFE.claimfeature_num = ClaimFeature.claimfeature_num
            INNER JOIN ClaimCoverage WITH(NOLOCK)
              ON ClaimFeature.claimcontrol_id  = ClaimCoverage.claimcontrol_id
                AND ClaimFeature.claimexposure_id = ClaimCoverage.claimexposure_id
                AND ClaimFeature.claimsubexposure_num = ClaimCoverage.claimsubexposure_num
                AND ClaimFeature.claimcoverage_num = ClaimCoverage.claimcoverage_num
            INNER JOIN ClaimControl WITH(NOLOCK)
              ON ClaimFeature.claimcontrol_id = ClaimControl.claimcontrol_id
            LEFT JOIN Claimfault clf ON clf.Claimfault_id = claimcontrol.claimfault_id
            LEFT JOIN ClaimControlVehicle CCV
              ON ClaimControl.ClaimControl_id = CCV.ClaimControl_id
              AND Vehicle_num <> 0
            Left JOIN PolicyImage WITH(NOLOCK)
              ON ClaimControl.policy_id = PolicyImage.policy_id
                AND ClaimControl.policyimage_num = PolicyImage.policyimage_num
            LEFT JOIN (Select c.Policy_id, pim.renewal_ver, SUM(c.premium_fullterm) as prem from PolicyImage PIM
                JOIN ProductionBackup.dbo.Coverage c
                  ON c.policy_id = pim.policy_id
                  AND pim.policystatuscode_id not in (4, 5, 7, 8, 12, 13, 14)
                JOIN ProductionBackup.dbo.coveragecode cc
                    on cc.coveragecode_id = c.coveragecode_id
                    and cc.coveragetype = 'PhysicalDamage'
                GROUP by c.Policy_id, pim.renewal_ver
                HAVING SUM(c.premium_fullterm) > 0) cc1
                  ON PolicyImage.policy_id = cc1.policy_id
                  AND PolicyImage.renewal_ver = cc1.renewal_ver
            LEFT OUTER JOIN PackagePart PP WITH (NOLOCK)
              ON ClaimControl.policy_id = PP.policy_id
                AND ClaimControl.policyimage_num = PP.policyimage_num
                AND ClaimControl.packagepart_num = PP.packagepart_num
            INNER JOIN CoverageCodeVersion WITH(NOLOCK)
              ON ClaimCoverage.coveragecode_id = CoverageCodeVersion.coveragecode_id
                AND CoverageCodeVersion.version_id = COALESCE(PP.version_id, PolicyImage.version_id)
            INNER JOIN ClaimFinancials CF WITH(NOLOCK)
              ON CFE.claimcontrol_id = CF.claimcontrol_id
              AND CFE.claimfinancials_num = CF.claimfinancials_num
            INNER JOIN [Version] V WITH(NOLOCK)
              ON V.version_id = COALESCE(PP.version_id, PolicyImage.version_id)
            INNER JOIN Customer_Reports.dbo.Treaty t
                  ON t.lob_id = v.lob_id
                  AND v.companystatelob_id = t.CompanyStateLob_ID
                  AND PolicyImage.eff_date between t.eff_date and t.exp_date
            WHERE
              CFE.claimeoplevel_id = 3
              -- Current Month
              AND CFE.year_month_key <> YEAR(GETDATE())*100+Month(GETDATE())
            GROUP BY
                DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') / 3,
                CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 END,
                DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') / 3  -
                CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) / 3 END,
 --               DATEDIFF(m, '2019-05-01', CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') / 3,
                V.company_id,
                V.state_id,
                V.lob_id,
                CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END,
                CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END,
      --          ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
                CASE WHEN policyimage.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
                policyimage.Renewal_ver,
                Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
             ;;
  }


  dimension: itd_claims_primarykey {
    primary_key: yes
    hidden: yes
    # sql: CONCAT(${TABLE}.policy, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.vehicle_num, ' ',
    #                   ${TABLE}.w_quarter)  ;;
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.policy_quarter, ' ', ${TABLE}.treaty_quarter, ' ', ${TABLE}.lag_quarter, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.Treaty, ' ', ${TABLE}.Renewal_ver);;
    # sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.w_quarter, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.Treaty);;
  }


  dimension: company_id {
    type: number
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: policy_quarter {
    label: "Accident Year_QTR"
    hidden: yes
    type:  string
    sql: ${TABLE}.policy_quarter;;
  }

  dimension: lag_year_quarter {
    label: "Lag Year_QTR"
    hidden: yes
    type: string
    sql: ${TABLE}.lag_quarter;;
  }

  dimension: treaty_quarter {
    label: "Treaty Quarter"
    hidden: yes
    type: string
    sql: ${TABLE}.treaty_quarter;;
  }

  dimension: trans_quarter {
    label: "Trans Quarter"
    hidden: yes
    type: string
    sql: ${TABLE}.trans_quarter;;
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

  dimension: renewal_ver {
    type: string
    hidden: yes
    sql: ${TABLE}.renewal_ver ;;
  }

  # dimension: liab_full {
  #   type: string
  #   hidden: yes
  #   sql: ${TABLE}.LiabOnly_Full;;

  # }

  dimension: treaty {
    label: "Treaty Name"
    hidden: yes
    type: string
    sql: ${TABLE}.treaty ;;
  }

  dimension: new_renewal {
    label: "New_Renew"
    hidden: yes
    type: string
    sql: ${TABLE}.NewRen ;;
  }


  measure: loss_reserve {
    type: sum
    sql: ${TABLE}.LossReserve ;;

  }

  measure: loss_paid {
    type: sum
    sql: ${TABLE}.LossPaid ;;

  }

  measure: salvage {
    type: sum
    sql: ${TABLE}.Salvage ;;

  }

  measure: subro {
    type: sum
    sql: ${TABLE}.Subro ;;

  }

  measure: expense_reserve {
    type: sum
    sql: ${TABLE}.expense_reserve ;;
  }

  measure: expense_paid {
    type: sum
    sql: ${TABLE}.expense_paid ;;

  }

  measure: incurred_with_expense_ss {
    label: "INC Paid+Expenses+Reserves-SS"
    type: sum
    sql: ${TABLE}.LossPaid + ${TABLE}.LossReserve + ${TABLE}.expense_paid + ${TABLE}.expense_reserve - ${TABLE}.Subro - ${TABLE}.Salvage;;

  }

  measure: incurred_gross_pd {
    label: "INC Paid+Reserves"
    type: sum
    sql: ${TABLE}.LossPaid + ${TABLE}.LossReserve;;

  }

  measure: incurred_net_pd_ss {
    label: "INC Paid+Reserves-SS"
    type: sum
    sql: ${TABLE}.LossPaid + ${TABLE}.LossReserve - ${TABLE}.Subro - ${TABLE}.Salvage;;

  }


  set: ALL_FIELDS {
    fields: [
      incurred_with_expense_ss,
      incurred_gross_pd,
      incurred_net_pd_ss,
      loss_reserve,
      loss_paid,
      expense_paid,
      salvage,
      subro
    ]
  }

}

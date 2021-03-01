view: eop_claims_triangle_treaty_policy_month {
  derived_table: {
    sql:SELECT
              DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') as treaty_month,
              CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) END as policy_month,
              DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01')  -
              CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) END as lag_month,
              DATEDIFF(m, '2019-05-01', CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01') as trans_month,
              --clf.dscr as at_fault,
              V.company_id,
              V.state_id,
              V.lob_id,
              LOBNAME,
              CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END as coveragecode_id,
              CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END as caption,
    --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
              CASE WHEN policyimage.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
              Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
              SUM(indemnity_reserve) AS LossReserve,
              SUM(indemnity_paid) AS LossPaid,
              SUM(salvage) AS Salvage,
              SUM(subro) AS Subro,
              SUM(alae_reserve + expense_reserve) AS expense_reserve,
              SUM(alae_paid + expense_paid) AS expense_paid,
              SUM(indemnity_reserve) +
              SUM(indemnity_paid) -
              SUM(salvage) -
              SUM(subro) +
              SUM(alae_reserve + expense_reserve) +
              SUM(alae_paid + expense_paid) AS ILOSS

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
            INNER JOIN LOB l on l.lob_id = v.lob_id
          INNER JOIN Customer_Reports.dbo.Treaty t
                ON t.lob_id = v.lob_id
                AND PolicyImage.eff_date between t.eff_date and t.exp_date
      WHERE
      CFE.claimeoplevel_id = 3
      AND CFE.year_month_key < YEAR(DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0))*100+MONTH(DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0))
      GROUP BY
        DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01'),
        CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) END,
        DATEDIFF(m, t.eff_date, CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01')  -
        CASE WHEN DATEDIFF(m, t.eff_date, PolicyImage.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, PolicyImage.eff_date) END,
        DATEDIFF(m, '2019-05-01', CAST(CFE.year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(CFE.month as varchar(2)), 2) as varchar(2)) + '-01'),
          V.company_id,
          V.state_id,
          V.lob_id,
          LOBNAME,
          CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END,
          CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END,
      --          ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
          CASE WHEN policyimage.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
          Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
    ;;

    }

    dimension: itd_claims_primarykey {
      primary_key: yes
      hidden: yes
      sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.trans_month, ' ', ${TABLE}.lag_month, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.Treaty, ' ', ${TABLE}.policy_month, ' ', ${TABLE}.treaty_month);;
      # sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.w_quarter, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.Treaty);;
    }


    dimension: company_id {
      type: number
      hidden: yes
      sql: ${TABLE}.company_id ;;
    }

    dimension: treaty_month {
      label: "Treaty Month"
      hidden: yes
      type:  number
      sql: ${TABLE}.treaty_month;;
    }
    dimension: trans_month {
      label: "Trans Month"
      hidden: yes
      type:  number
      sql: ${TABLE}.trans_month;;
    }

    dimension: policy_month {
      label: "Policy Month"
      hidden: yes
      type:  number
      sql: ${TABLE}.policy_month;;
    }

    dimension: lag_month {
      label: "Lag Month"
      hidden: yes
      type: number
      sql: ${TABLE}.lag_month;;
    }

    # dimension: trans_year_quarter {
    #   label: "Trans Year_QTR (YYYYQ)"
    #   hidden: yes
    #   type: string
    #   sql: ${TABLE}.w_quarter ;;
    # }

    # dimension: year {
    #   type: number
    #   hidden: yes
    #   sql: ${TABLE}.year ;;
    # }

    # dimension: month {
    #   type: number
    #   hidden: yes
    #   sql: ${TABLE}.month ;;
    # }

    # dimension: yr_mnth {
    #   type: number
    #   sql: ${year} * 100 + ${month};;
    # }

    dimension: state_id {
      type: number
      hidden: yes
      sql: ${TABLE}.state_id ;;
    }

    dimension: lobname {
      label: "Program Name"
      type: string
      hidden: yes
      sql: ${TABLE}.lobname ;;
    }

    dimension: caption {
      label: "Coverage"
      hidden: yes
      type: string
      sql: ${TABLE}.caption ;;
    }

    dimension: lob_id {
      type: number
      hidden: yes
      sql: ${TABLE}.lob_id ;;
    }

    # dimension: vehicle_num {
    #   type: number
    #   hidden: yes
    #   sql: ${TABLE}.vehicle_num ;;
    # }

    dimension: coveragecode_id {
      type: number
      hidden: yes
      sql: ${TABLE}.coveragecode_id ;;
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

    # dimension: policy_id {
    #   type: number
    #   hidden: yes
    #   sql: ${TABLE}.policy_id ;;
    # }

    # dimension: renewal_ver {
    #   type: number
    #   hidden: yes
    #   sql: ${TABLE}.renewal_ver ;;
    # }

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

    # dimension: policy {
    #   type: string
    #   hidden: yes
    #   sql: ${TABLE}.policy ;;
    # }

    # dimension: eff_date {
    #   type: string
    #   hidden: yes
    #   sql: ${TABLE}.eff_date ;;
    # }

    # dimension: claim_fault {
    #   label: "At-Fault"
    #   type: string
    #   sql: ${TABLE}.at_fault ;;
    # }


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

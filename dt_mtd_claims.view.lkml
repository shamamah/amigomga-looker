view: dt_mtd_claims {
  derived_table: {
      sql: SELECT V.company_id,
          V.state_id,
          V.lob_id,
          CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END as coveragecode_id,
          CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END as caption,
          PolicyImage.policy_id,
--          PolicyImage.Policyimage_num,
          PolicyImage.renewal_ver,
          ISNULL(CCV.Vehicle_num, 1) as vehicle_num,
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
        LEFT JOIN ClaimControlVehicle CCV
          ON ClaimControl.ClaimControl_id = CCV.ClaimControl_id
          AND Vehicle_num <> 0
        Left JOIN PolicyImage WITH(NOLOCK)
          ON ClaimControl.policy_id = PolicyImage.policy_id
            AND ClaimControl.policyimage_num = PolicyImage.policyimage_num
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
        WHERE
          CFE.claimeoplevel_id = 3
          AND CFE.Year = YEAR(GETDATE()-1)
          AND CFE.Month = MONTH(GETDATE()-1)
        GROUP BY V.company_id,
          V.state_id,
          V.lob_id,
          CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END,
          CASE WHEN V.lob_id = 1 AND overageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END,
          PolicyImage.policy_id,
--          PolicyImage.Policyimage_num,
          PolicyImage.renewal_ver,
          ISNULL(CCV.Vehicle_num, 1)
       ;;
    }

    dimension: itd_claims_primarykey {
      primary_key: yes
      hidden: yes
      sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.vehicle_num);;
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

    dimension: vehicle_num {
      type: number
      hidden: yes
      sql: ${TABLE}.vehicle_num ;;
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

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.renewal_ver ;;
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

  }

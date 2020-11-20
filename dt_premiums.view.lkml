view: dt_premiums {

  derived_table: {
    sql: SELECT
        COALESCE(xx.year, z.year) year,
        COALESCE(xx.month, z.month) month,
        COALESCE(xx.company_id, z.company_id) company_id,
        COALESCE(xx.state_id, z.state_id) state_id,
        COALESCE(xx.lob_id, z.lob_id) lob_id,
        COALESCE(xx.coveragecode_id, z.coveragecode_id) coveragecode_id,
        COALESCE(xx.caption, z.caption) caption,
        COALESCE(xx.policy_id, z.policy_id) policy_id,
 --       Policyimage_num,
        COALESCE(xx.renewal_ver, z.renewal_ver) renewal_ver,
        COALESCE(xx.unit_num, z.vehicle_num) unit_num,
        COALESCE(xx.policy, z.policy) policy,
        COALESCE(xx.eff_date, z.eff_date) eff_date,
        COALESCE(SUM(xx.TotalEarnedPremium), 0) as TotalEarnedPremium,
        COALESCE(SUM(xx.TotalWrittenPremium), 0) as TotalWrittenPremium
        FROM (SELECT
                EMP.YEAR,
                EMP.Month,
                V.company_id,
                V.state_id,
                V.lob_id,
                EMP.coveragecode_id,
                CCV.caption,
                policy_id,
--                Policyimage_num,
                renewal_ver,
                unit_num,
                policy,
                emp.eff_date,
                SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
                SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPMonthlyPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY
            EMP.year,
            EMP.month,
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
--            Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            emp.eff_date


          UNION ALL

          SELECT
            YEAR(GETDATE()-1) as year,
            MONTH(GETDATE()-1) as month,
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
 --           Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            emp.eff_date,
            SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
            SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN .CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
  --          Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            emp.eff_date) xx
  RIGHT JOIN (SELECT
          CFE.Year,
          CFE.Month,
          clf.dscr as at_fault,
          V.company_id,
            V.state_id,
            V.lob_id,
            CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END as coveragecode_id,
            CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END as caption,
            PolicyImage.policy_id,
      --          PolicyImage.Policyimage_num,
            PolicyImage.renewal_ver,
            ISNULL(CCV.Vehicle_num, 1) as vehicle_num,
            policy,
            PolicyImage.eff_date,
            claim_number,
            loss_date,
            cfs.dscr as Claimstatus,
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
          INNER JOIN Claimfault clf ON clf.Claimfault_id = claimcontrol.claimfault_id
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
          LEFT JOIN claimfeaturestatus cfs ON cfs.claimfeaturestatus_id =
              ClaimFeature.claimfeaturestatus_id
          WHERE
            CFE.claimeoplevel_id = 3
          GROUP BY
            CFE.Year,
            CFE.Month,
            clf.dscr,
            V.company_id,
            V.state_id,
            V.lob_id,
            CASE WHEN V.lob_id = 1 AND ClaimCoverage.coveragecode_id = 9 THEN 8 ELSE ClaimCoverage.coveragecode_id END,
            CASE WHEN V.lob_id = 1 AND CoverageCodeVersion.caption = 'UM PD' THEN 'UM/UIM BI' ELSE CoverageCodeVersion.caption END,
            PolicyImage.policy_id,
      --          PolicyImage.Policyimage_num,
            PolicyImage.renewal_ver,
            ISNULL(CCV.Vehicle_num, 1),
            policy,
            PolicyImage.eff_date,
            claim_number,
            loss_date,
            cfs.dscr) z
            ON xx.policy_id = z.policy_id
              AND xx.renewal_ver = z.renewal_ver
              AND xx.unit_num = z.vehicle_num
              AND xx.coveragecode_id = z.coveragecode_id
              AND xx.year = z.year
      Group by
    COALESCE(xx.year, z.year),
        COALESCE(xx.month, z.month),
        COALESCE(xx.company_id, z.company_id),
        COALESCE(xx.state_id, z.state_id),
        COALESCE(xx.lob_id, z.lob_id),
        COALESCE(xx.coveragecode_id, z.coveragecode_id),
        COALESCE(xx.caption, z.caption),
        COALESCE(xx.policy_id, z.policy_id),
 --       Policyimage_num,
        COALESCE(xx.renewal_ver, z.renewal_ver),
        COALESCE(xx.unit_num, z.vehicle_num),
        COALESCE(xx.policy, z.policy),
        COALESCE(xx.eff_date, z.eff_date)
 ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.unit_num, ' ', ${TABLE}.year, ' ', ${TABLE}.month) ;;
  }

  measure: total_earned_premium {
    label: "Total Earned Premium"
    type: sum
    sql: ${TABLE}.totalearnedpremium ;;
    drill_fields: [detail*]
  }

  measure: total_written_premium {
    label: "Total Written Premium"
    type: sum
    sql: ${TABLE}.totalwrittenpremium ;;
    drill_fields: [detail*]
  }


  measure: avgEarned {
    label: "Avg Earned"
    type: average
    value_format: "0.##"
    sql: ${TABLE}.totalearnedpremium ;;
  }

  measure: avgWritten {
    label: "Avg Written"
    type: average
    value_format: "0.##"
    sql: ${TABLE}.totalwrittenpremium ;;
  }


  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension_group: first_of_month {
    label: "First of Month"
    type: time
    sql: cast(cast(${TABLE}.year as varchar(4))+'-'+RIGHT(CAST('00' + ${TABLE}.month as varchar(4)),2)+'-01' as datetime) ;;
    timeframes: [month]
  }

  dimension: new_renewal {
    label: "New vs. Renewal"
    type: string
    sql: CASE WHEN ${TABLE}.renewal_ver=1 THEN 'New' ELSE 'Renewal' END ;;
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

  dimension: unit_num {
    type: number
    hidden: yes
    sql: ${TABLE}.unit_num ;;
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

  dimension: policy {
    type: string
    hidden: yes
    sql: ${TABLE}.policy ;;
  }

  dimension: eff_date {
    type: string
    hidden: yes
    sql: ${TABLE}.eff_date ;;
  }

  set: detail {
    fields: [
      policy,
      eff_date,
      total_earned_premium,
      total_written_premium
    ]
  }

}

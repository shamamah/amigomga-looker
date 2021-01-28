view: pdt_claims_frequency_triangle {
  derived_table: {
      sql: SELECT
              CN.commercial_name1,
              lob.lobname,
              s.state,
              ClaimFeatureEOD.Year * 100 + ClaimFeatureEOD.Month as TransMonth,
              PolicyImage.policy,
              PolicyImage.renewal_ver,
              PolicyImage.eff_date,
              YEAR(PolicyImage.eff_date) * 100 + MONTH(PolicyImage.eff_date) as EffMonth,
              'M' + RIGHT('00' + CAST(DATEDIFF(m, PolicyImage.eff_date, Cast(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(2)), 2) as MonthlyLag,
              CASE ISNULL(CoverageLimit.is_stacked, 0)
              WHEN 1 THEN CoverageCodeVersion.caption + ' Stacked'
              ELSE CoverageCodeVersion.caption
              END AS CoverageDetail,
              cc.Coveragecode as Coverage,
              COUNT(ClaimFeature.claimfeature_num) AS FeatureCount,
              SUM(indemnity_paid) AS Paid,
              SUM(indemnity_reserve) AS ReserveChange,
              SUM(salvage) AS Salvage,
              SUM(subro) AS Subro,
              SUM(alae_paid) AS ALAEPaid,
              SUM(expense_paid) AS ULAEPaid,
              SUM(indemnity_paid) + SUM(indemnity_reserve) + SUM(alae_paid) + SUM(expense_paid) - SUM(salvage) - SUM(subro) as INC_Paid_EXP_SUBRSALV
              FROM dbo.ClaimFeatureEOD ClaimFeatureEOD WITH(NOLOCK)
              INNER JOIN dbo.ClaimFinancials ClaimFinancials WITH(NOLOCK)
              ON ClaimFeatureEOD.claimcontrol_id = ClaimFinancials.claimcontrol_id
              AND ClaimFeatureEOD.claimfinancials_num = ClaimFinancials.claimfinancials_num
              INNER JOIN dbo.ClaimFeature ClaimFeature WITH(NOLOCK)
              ON ClaimFeatureEOD.claimcontrol_id = ClaimFeature.claimcontrol_id
              AND ClaimFeatureEOD.claimant_num = ClaimFeature.claimant_num
              AND ClaimFeatureEOD.claimfeature_num = ClaimFeature.claimfeature_num
              INNER JOIN dbo.ClaimCoverage ClaimCoverage WITH(NOLOCK)
              ON ClaimFeature.claimcontrol_id = ClaimCoverage.claimcontrol_id
              AND ClaimFeature.claimexposure_id = ClaimCoverage.claimexposure_id
              AND ClaimFeature.claimsubexposure_num = ClaimCoverage.claimsubexposure_num
              AND ClaimFeature.claimcoverage_num = ClaimCoverage.claimcoverage_num
              INNER JOIN dbo.ClaimControl ClaimControl WITH(NOLOCK)
              ON ClaimFeatureEOD.claimcontrol_id = ClaimControl.claimcontrol_id
              INNER JOIN dbo.PolicyImage PolicyImage WITH(NOLOCK)
              ON ClaimControl.policy_id = PolicyImage.policy_id
              AND ClaimControl.policyimage_num = PolicyImage.policyimage_num
              INNER JOIN dbo.CoverageCodeVersion CoverageCodeVersion WITH(NOLOCK)
              ON CoverageCodeVersion.coveragecode_id = ClaimCoverage.coveragecode_id
              AND CoverageCodeVersion.version_id = PolicyImage.version_id
              INNER JOIN dbo.CoverageCode cc WITH(NOLOCK)
              ON cc.coveragecode_id = ClaimCoverage.coveragecode_id
              LEFT OUTER JOIN dbo.Coverage Coverage WITH (NOLOCK)
              ON Coverage.policy_id = ClaimControl.policy_id
              AND Coverage.policyimage_num = ClaimControl.policyimage_num
              AND Coverage.coverage_num = ClaimCoverage.coverage_num
              LEFT OUTER JOIN dbo.CoverageLimit WITH (NOLOCK)
              ON CoverageLimit.coveragelimit_id = Coverage.coveragelimit_id
              INNER JOIN dbo.[Version] V WITH (NOLOCK)
                    ON V.version_id = PolicyImage.version_id
              INNER JOIN dbo.CompanyStateLOB CSL WITH (NOLOCK)
                    ON CSL.companystatelob_id = V.companystatelob_id
              INNER JOIN dbo.CompanyState CS WITH (NOLOCK)
                    ON CS.companystate_id = CSL.companystate_id
              INNER JOIN dbo.CompanyLOB CL WITH (NOLOCK)
                    ON CL.companylob_id = CSL.companylob_id
              INNER JOIN dbo.Company C WITH (NOLOCK)
                    ON C.company_id = CS.company_id
              INNER JOIN CompanyNameLink CNL WITH (NOLOCK)
                ON C.company_id = CNL.company_id
              INNER JOIN [Name] CN WITH (NOLOCK)
                ON CNL.name_id = CN.name_id
                  AND CNL.nameaddresssource_id = 7
              INNER JOIN dbo.LOB LOB WITH (NOLOCK)
                    ON LOB.lob_id = CL.lob_id
              INNER JOIN dbo.[State] S WITH (NOLOCK)
                    ON S.state_id = CS.state_id
              --WHERE PolicyImage.policy = 'GAA10006212'
              GROUP BY CN.commercial_name1,
              lob.lobname,
              s.state,
              CASE ISNULL(CoverageLimit.is_stacked, 0)
              WHEN 1 THEN CoverageCodeVersion.caption + ' Stacked'
              ELSE CoverageCodeVersion.caption
              END,
              cc.Coveragecode,
              ClaimFeatureEOD.Year * 100 + ClaimFeatureEOD.Month,
              PolicyImage.policy,
              PolicyImage.renewal_ver,
              PolicyImage.eff_date,
              YEAR(PolicyImage.eff_date) * 100 + MONTH(PolicyImage.eff_date),
              'M' + RIGHT('00' + CAST(DATEDIFF(m, PolicyImage.eff_date, Cast(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(2)), 2),
              ClaimFeatureEOD.claimeoplevel_id
              HAVING ((ClaimFeatureEOD.[year] * 100) + ClaimFeatureEOD.[month]) < (CAST(YEAR(GETDATE()) as INT) * 100) + CAST(MONTH(GETDATE()) as INT)
              AND
              ClaimFeatureEOD.claimeoplevel_id = 1 -- monthly totals
               ;;
    }

    measure: count {
      type: count
      hidden: yes
      drill_fields: [detail*]
    }

    dimension: commercial_name1 {
      type: string
      hidden: yes
      sql: ${TABLE}.commercial_name1 ;;
    }

    dimension: primay_key {
      type: string
      hidden: yes
      sql: CONCAT(${TABLE}.policy, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coverage, ' ', ${TABLE}.transmonth) ;;
    }

    dimension: lobname {
      type: string
      hidden: yes
      sql: ${TABLE}.lobname ;;
    }

    dimension: state {
      type: string
      hidden: yes
      sql: ${TABLE}.state ;;
    }

    dimension: trans_month {
      type: number
      hidden: yes
      sql: ${TABLE}.TransMonth ;;
    }

    dimension: policy {
      type: string
      hidden: yes
      sql: ${TABLE}.policy ;;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.renewal_ver ;;
    }

    dimension: eff_date {
      type: date
      hidden: yes
      sql: ${TABLE}.eff_date ;;
    }

    dimension: eff_month {
      type: number
      hidden: yes
      sql: ${TABLE}.EffMonth ;;
    }

    dimension: monthly_lag {
      type: string
      hidden: yes
      sql: ${TABLE}.MonthlyLag ;;
    }

    dimension: coverage_detail {
      type: string
      hidden: yes
      sql: ${TABLE}.CoverageDetail ;;
    }

    dimension: coverage {
      type: string
      hidden: yes
      sql: ${TABLE}.Coverage ;;
    }

    measure: feature_count {
      label: "Reported Count"
      type: sum
      sql: ${TABLE}.FeatureCount ;;
    }

    dimension: paid {
      type: string
      hidden: yes
      sql: ${TABLE}.Paid ;;
    }

    dimension: reserve_change {
      type: string
      hidden: yes
      sql: ${TABLE}.ReserveChange ;;
    }

    dimension: salvage {
      type: string
      hidden: yes
      sql: ${TABLE}.Salvage ;;
    }

    dimension: subro {
      type: string
      hidden: yes
      sql: ${TABLE}.Subro ;;
    }

    dimension: alaepaid {
      type: string
      hidden: yes
      sql: ${TABLE}.ALAEPaid ;;
    }

    dimension: ulaepaid {
      type: string
      hidden: yes
      sql: ${TABLE}.ULAEPaid ;;
    }

    dimension: inc_paid_exp_subrsalv {
      type: string
      hidden: yes
      sql: ${TABLE}.INC_Paid_EXP_SUBRSALV ;;
    }

    set: detail {
      fields: [
        commercial_name1,
        lobname,
        state,
        trans_month,
        policy,
        renewal_ver,
        eff_date,
        eff_month,
        monthly_lag,
        coverage_detail,
        coverage,
        feature_count,
        paid,
        reserve_change,
        salvage,
        subro,
        alaepaid,
        ulaepaid,
        inc_paid_exp_subrsalv
      ]
    }
  }

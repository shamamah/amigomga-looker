view: eop_premium_triangle_policy_quarter {
  derived_table: {
    sql:  SELECT
          CASE WHEN DATEDIFF(q, '2019-05-01', xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(q, '2019-05-01', xx.eff_date) END as policy_quarter,
          CASE WHEN DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') < 0 THEN 0 ELSE DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') END
          --CASE WHEN DATEDIFF(m, '2019-05-01', z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, '2019-05-01', z.eff_date) END
              as lag_quarter,
          DATEDIFF(q, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') as trans_quarter,
          --YEAR(xx.eff_date)*100+MONTH(xx.eff_date) as EffMonth,
            company_id,
            state_id,
            xx.lob_id,
            lobname,
            coveragecode_id,
            caption,
     --       CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
            CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
            Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
            SUM(TotalEarnedPremium) as EarnedPremium,
            SUM(TotalWrittenPremium) as WrittenPremium,
            SUM(TotalUnearnedPremium) as UnearnedPremium
        FROM  Customer_Reports.dbo.Treaty t
            LEFT JOIN (SELECT
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
                    SUM(EMP.premium_written_mtd) AS TotalWrittenPremium,
                    SUM(EMP.premium_unearned) AS TotalUnearnedPremium
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
                SUM(EMP.premium_written_mtd) AS TotalWrittenPremium,
          SUM(EMP.premium_unearned) AS TotalUnearnedPremium
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
         ON t.lob_id = xx.lob_id
            AND xx.eff_date between t.eff_date and t.exp_date
         INNER JOIN LOB l
                ON l.lob_id = xx.lob_id
          LEFT JOIN (Select c.Policy_id, pim.renewal_ver, SUM(c.premium_fullterm) as prem from PolicyImage PIM
          JOIN ProductionBackup.dbo.Coverage c
            ON c.policy_id = pim.policy_id
            AND pim.policystatuscode_id not in (4, 5, 7, 8, 12, 13, 14)
          JOIN ProductionBackup.dbo.coveragecode cc
            on cc.coveragecode_id = c.coveragecode_id
            and cc.coveragetype = 'PhysicalDamage'
                GROUP by c.Policy_id, pim.renewal_ver
                HAVING SUM(c.premium_fullterm) > 0) cc1
                  ON xx.policy_id = cc1.policy_id
                  AND xx.renewal_ver = cc1.renewal_ver
          Group by
      CASE WHEN DATEDIFF(q, '2019-05-01', xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(q, '2019-05-01', xx.eff_date) END,
      CASE WHEN DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') < 0 THEN 0 ELSE DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') END
      --CASE WHEN DATEDIFF(m, '2019-05-01', z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, '2019-05-01', z.eff_date) END
      ,
      DATEDIFF(q, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01'),
      --YEAR(xx.eff_date)*100+MONTH(xx.eff_date),
      company_id,
      state_id,
      xx.lob_id,
      lobname,
      coveragecode_id,
      caption,
    --        ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
      CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
      Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')';;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.trans_quarter, ' ', ${TABLE}.lag_quarter, ' ', ${TABLE}.policy_quarter, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.treaty)       ;;
#  sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.w_quarter, ' ', ${TABLE}.quarterID, ' ', ${TABLE}.treaty, ' ', ${TABLE}.NewRen)

  }

  measure: total_earned_premium {
    label: "Earned Premium"
    type: sum
    sql: ${TABLE}.earnedpremium ;;

  }

  measure: total_written_premium {
    label: "Written Premium"
    type: sum
    sql: ${TABLE}.writtenpremium ;;
  }

  measure: total_unearned_premium {
    label: "Unearned Premium"
    type: sum
    sql: ${TABLE}.unearnedpremium ;;
  }


  # dimension: new_renewal {
  #   label: "New vs. Renewal"
  #   type: string
  #   sql: ${TABLE}.NewRen;;
  # }

  # dimension: policy_year_quarter {
  #   label: "_Accident Treaty QTR"
  #   type:  string
  #   sql: ${TABLE}.Policy_Quarter;;
  # }

  dimension: lag_year_quarter {
    label: "Lag Policy Quarter"
    type: number
    sql: ${TABLE}.lag_quarter;;
  }

  dimension: trans_quarter {
    label: "Trans Quarter"
    type: number
    full_suggestions: yes
    sql: ${TABLE}.trans_quarter ;;
  }

  dimension: policy_quarter {
    label: "Policy Quarter"
    type: number
    sql: ${TABLE}.policy_quarter ;;
  }

  # dimension: liab_full {
  #   type: string
  #   sql: ${TABLE}.LiabOnly_Full;;

  # }

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

  dimension: lobname {
    label: "Program Name (LOB)"
    type: string
    sql: ${TABLE}.lobname ;;
  }

  dimension: treaty {
    label: "Treaty Name"
    type: string
    sql: ${TABLE}.Treaty ;;
  }

  dimension: new_renewal {
    label: "New_Renew"
    type: string
    sql: ${TABLE}.NewRen ;;
  }
  dimension: coveragecode_id {
    type: number
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: caption {
    label: "Coverage"
    type: string
    sql: ${TABLE}.caption ;;
  }

}

view: eop_premium_triangle_treaty_quarter {
  derived_table: {
    sql:  SELECT
            DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') / 3 as treaty_quarter,
            CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) / 3 END as policy_quarter,
            DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') / 3 -
            CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) / 3 END as Lag_quarter,
            DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') / 3 as trans_quarter,
            company_id,
            state_id,
            xx.lob_id,
            lobname,
            coveragecode_id,
            caption,
     --       CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
            CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
            xx.Renewal_ver,
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

/*
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
            emp.eff_date
*/
                UNION ALL

              SELECT
                  2021,
                  1,
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
                  0,
                  0,
                  0
              FROM EOPMonthlyPremiums EMP WITH(NOLOCK)
              INNER JOIN [Version] V WITH(NOLOCK)
                ON V.version_id = EMP.version_id
              INNER JOIN CoverageCodeVersion CCV WITH(NOLOCK)
                ON EMP.coveragecode_id = CCV.coveragecode_id
                AND V.version_id = CCV.version_id

              WHERE
              EMP.year_month_key = '202012'
              GROUP BY
                  EMP.year,
                  EMP.month,
                  V.company_id,
                  V.state_id,
                  V.lob_id,
                  EMP.coveragecode_id,
                  CCV.caption,
                  policy_id,
                  renewal_ver,
                  unit_num,
                  policy,
                  emp.eff_date

    UNION ALL

              SELECT
                  2021,
                  2,
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
                  0,
                  0,
                  0
              FROM EOPMonthlyPremiums EMP WITH(NOLOCK)
              INNER JOIN [Version] V WITH(NOLOCK)
                ON V.version_id = EMP.version_id
              INNER JOIN CoverageCodeVersion CCV WITH(NOLOCK)
                ON EMP.coveragecode_id = CCV.coveragecode_id
                AND V.version_id = CCV.version_id
              WHERE
              EMP.year_month_key = '202012'
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

                  ) xx
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
           GROUP BY
              DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') / 3,
              CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) / 3 END,
              DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') / 3 -
              CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) / 3 < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) / 3 END,
              DATEDIFF(m, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') / 3,
              company_id,
              state_id,
              xx.lob_id,
              lobname,
              coveragecode_id,
              caption,
  --            ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
              CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
              xx.renewal_ver,
              Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
 ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.policy_quarter, ' ', ${TABLE}.treaty_quarter, ' ', ${TABLE}.lag_quarter, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.Renewal_ver)       ;;
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
    label: "_Lag Year_QTR"
    type: string
    sql: ${TABLE}.lag_quarter;;
  }

  dimension: trans_year_quarter {
    label: "_Trans Year_QTR (YYYYQ)"
    type: string
    sql: ${TABLE}.trans_quarter ;;
  }

  dimension: policy_quarter {
    label: "Policy Quarter"
    type: string
    sql: ${TABLE}.policy_quarter;;
  }

  dimension: treaty_quarter {
    label: "Treaty Quarter"
    type: string
    sql: ${TABLE}.treaty_quarter ;;
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

  dimension: renewal_ver {
    label: "RenewalVersion"
    type: string
    sql: ${TABLE}.renewal_ver ;;
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

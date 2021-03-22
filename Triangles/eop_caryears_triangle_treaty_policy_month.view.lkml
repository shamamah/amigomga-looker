view: eop_caryears_triangle_treaty_policy_month {
  derived_table: {
    sql: SELECT
            DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') as treaty_month,
            CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) END as policy_month,
            DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') -
            CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) END as Lag_month,
            DATEDIFF(m, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') as trans_month,
            company_id,
            state_id,
            xx.lob_id,
            lobname,
            coveragecode_id,
            caption,
     --       CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
            CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
            Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
            Sum(eDays) as edays,
            Sum(wDays) as wDays,
            Round(SUM(ECY), 4) as EarnedCarYear,
            Round(SUM(WCY), 4) as WrittenCarYear
        --SUM(TotalUnearnedPremium) as UnearnedPremium
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
                      CAST(SUM(exposure_earned_days_mtd) as float) as eDays,
                      CAST(SUM(exposure_written_days_mtd) as float) as wDays,
                      ROUND(CAST(CAST(SUM(exposure_earned_days_mtd) as float)/(CAST(datediff(d, emp.eff_date, emp.exp_date)*2 as float)) as float), 4)  AS ECY,
                      ROUND(CAST(CAST(SUM(exposure_written_days_mtd) as float)/(CAST(datediff(d, emp.eff_date, emp.exp_date)*2 as float)) as float), 4) as WCY
          --SUM(EMP.premium_unearned) AS TotalUnearnedPremium
              FROM EOPMonthlyExposuresCoverage EMP WITH(NOLOCK)
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
                emp.eff_date,
                emp.exp_date
                ) xx
                  ON t.lob_id = xx.lob_id
                  AND xx.eff_date between t.eff_date and t.exp_date
--                  AND xx.caption in ('Property Damage', 'Collision')
    INNER JOIN LOB l
            ON l.lob_id = xx.lob_id
    LEFT JOIN (Select c.Policy_id, pim.renewal_ver, SUM(c.premium_fullterm) as prem
                FROM PolicyImage PIM
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
    DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01'),
    CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) END,
    DATEDIFF(m, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') -
    CASE WHEN DATEDIFF(m, t.eff_date, xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, xx.eff_date) END,
    DATEDIFF(m, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01'),
    company_id,
    state_id,
    xx.lob_id,
    lobname,
    coveragecode_id,
    caption,
--        ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
    CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
    Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
     ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.trans_month, ' ', ${TABLE}.policy_month, ' ', ${TABLE}.treaty_month, ' ', ${TABLE}.lag_month, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.treaty)       ;;
#  sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.w_quarter, ' ', ${TABLE}.quarterID, ' ', ${TABLE}.treaty, ' ', ${TABLE}.NewRen)

  }

  measure: total_earned_caryear {
    label: "Earned Caryear"
    type: sum
    value_format: "0.####"
    sql: ${TABLE}.EarnedCarYear ;;

  }

  measure: total_written_caryear {
    label: "Written Caryear"
    type: sum
    value_format: "0.####"
    sql: ${TABLE}.WrittenCarYear ;;
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

  dimension: lag_month {
    label: "Lag Policy Month"
    type: number
    sql: ${TABLE}.lag_month;;
  }

  dimension: policy_month {
    label: "Policy Month"
    type: number
    sql: ${TABLE}.policy_month;;
  }
  dimension: trans_year_month {
    label: "Trans Month"
    type: number
    sql: ${TABLE}.trans_month ;;
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

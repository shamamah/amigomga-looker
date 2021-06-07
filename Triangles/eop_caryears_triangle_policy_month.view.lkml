view: eop_caryears_triangle_policy_month {
  derived_table: {
    sql: SELECT
            DATEDIFF(m, '2019-05-01', xx.eff_date) as policy_month,
            DATEDIFF(m, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') as Lag_month,
            DATEDIFF(m, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') as trans_month,
            company_id,
            state_id,
            xx.lob_id,
            lobname,
            coveragecode_id,
            caption,
     --       CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
            CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
            Sum(eDays) as edays,
            Sum(wDays) as wDays,
            Round(SUM(ECY), 4) as EarnedCarYear,
            Round(SUM(WCY), 4) as WrittenCarYear
        --SUM(TotalUnearnedPremium) as UnearnedPremium
        FROM (SELECT
                  YEAR,
                  Month,
                  company_id,
                  companystatelob_id,
                  state_id,
                  lob_id,
                  coveragecode_id,
                  caption,
                  policy_id,
                  renewal_ver,
                  unit_num,
                  policy,
                  eff_date,
                  eDays,
                  wDays,
                  ECY,
                  WCY
              FROM Customer_Reports.dbo.PolicyExposure
              WHERE year_month_key < YEAR(GETDATE()-1)*100+MONTH(GETDATE()-1)
               ) xx
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
      WHERE xx.caption in ('Property Damage', 'Collision')
        GROUP BY
        DATEDIFF(m, '2019-05-01', xx.eff_date),
        DATEDIFF(m, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01'),
        DATEDIFF(m, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01'),
        company_id,
        state_id,
        xx.lob_id,
        lobname,
        coveragecode_id,
        caption,
    --        ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
        CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END
       ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.trans_month, ' ', ${TABLE}.policy_month, ' ', ${TABLE}.lag_month, ' ', ${TABLE}.NewRen)       ;;
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

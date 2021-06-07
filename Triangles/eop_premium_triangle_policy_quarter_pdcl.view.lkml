view: eop_premium_triangle_policy_quarter_pdcl {
  derived_table: {
    sql:  SELECT
          CASE WHEN DATEDIFF(q, t.eff_date, xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(q, t.eff_date, xx.eff_date) END as policy_quarter,
          CASE WHEN DATEDIFF(q, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') < 0 THEN 0 ELSE DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') END
          --CASE WHEN DATEDIFF(m, '2019-05-01', z.eff_date) < 0 THEN 0 ELSE DATEDIFF(m, '2019-05-01', z.eff_date) END
              as lag_quarter,
          DATEDIFF(q, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') as trans_quarter,
          --YEAR(xx.eff_date)*100+MONTH(xx.eff_date) as EffMonth,
            company_id,
            state_id,
            xx.lob_id,
            lobname,
      CoverageType,
            CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
            Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
            renewal_ver,
            SUM(TotalEarnedPremium) as EarnedPremium,
            SUM(TotalWrittenPremium) as WrittenPremium,
            SUM(TotalUnearnedPremium) as UnearnedPremium
        FROM  Customer_Reports.dbo.Treaty t
        LEFT JOIN (SELECT
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
                      TotalEarnedPremium,
                      TotalWrittenPremium,
                      TotalUnearnedPremium
                      FROM Customer_Reports.dbo.PolicyPremium
                      WHERE year_month_key < YEAR(GETDATE()-1)*100+MONTH(GETDATE()-1)
                      ) xx
          ON t.lob_id = xx.lob_id
          AND xx.eff_date between t.eff_date and t.exp_date
          AND xx.companystatelob_id = t.companystatelob_id
      INNER JOIN LOB l
                ON l.lob_id = xx.lob_id
      GROUP BY
      CASE WHEN DATEDIFF(q, t.eff_date, xx.eff_date) < 0 THEN 0 ELSE DATEDIFF(q, t.eff_date, xx.eff_date) END,
      CASE WHEN DATEDIFF(q, t.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') < 0 THEN 0 ELSE DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') END
            ,
          DATEDIFF(q, '2019-05-01', CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01'),
      company_id,
      state_id,
      xx.lob_id,
      lobname,
      coveragetype,
      CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
      Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')',
      renewal_ver;;
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

  dimension: renewal_ver {
    label: "Renewal Version"
    type: string
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: coveragetype {
    label: "Coverage"
    type: string
    sql: ${TABLE}.coveragetype;;
  }


}

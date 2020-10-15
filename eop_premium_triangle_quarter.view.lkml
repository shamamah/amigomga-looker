view: eop_premium_triangle_quarter {
  sql_table_name: EOPMonthlyPremiums  ;;


  dimension: eop_primary {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.unit_num, ' ',
                        ${year}, ' ', ${month})  ;;

  }

  dimension: policy_year_quarter {
    label: "Policy Year_QTR"
    type:  string
    sql: CONCAT(YEAR(${eff_date}), CASE WHEN MONTH(${eff_date}) in (1,2,3) THEN '1'
                                        WHEN MONTH(${eff_date}) in (4,5,6) THEN '2'
                                        WHEN MONTH(${eff_date}) in (7,8,9) THEN '3'
                                        WHEN MONTH(${eff_date}) in (10,11,12) THEN '4'
                                        END) ;;
  }

  dimension: trans_year_quarter {
    label: "Trans Year_QTR"
    type: string
    hidden: yes
    sql: CONCAT(${year}, CASE WHEN ${month} in (1,2,3) THEN '1'
                                        WHEN ${month} in (4,5,6) THEN '2'
                                        WHEN ${month} in (7,8,9) THEN '3'
                                        WHEN ${month} in (10,11,12) THEN '4'
                                        END) ;;
  }

  dimension: lag_year_quarter {
    label: "Lag Year_QTR"
    type: string
    sql: CONCAT('Q', CAST(DATEDIFF(q, ${eff_date}, CAST(${year} as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(${month} as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(2)));;
  }

  dimension: year {
    hidden: yes
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    hidden: yes
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: coverage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.coverage_num ;;
  }

  dimension: coveragecode_id {
    type: number
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: liab_phys {
    type: string
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: version_id {
    type: number
    hidden: yes
    sql: ${TABLE}.version_id ;;
  }

  dimension: policy {
    type: string
    hidden: yes
    sql: ${TABLE}.policy ;;
  }

  dimension: new_renewal {
    label: "New vs. Renewal"
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.renewal_ver=1 THEN 'New' ELSE 'Renewal' END ;;
  }

  dimension: renewal_ver {
    type: number
    hidden: yes
    sql: ${TABLE}.renewal_ver ;;
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

  dimension: eff_date {
    type: date
    hidden: yes
    sql: ${TABLE}.eff_date ;;
  }

  dimension: exp_date {
    type: date
    hidden: yes
    sql: ${TABLE}.exp_date ;;
  }

  dimension: teff_date {
    type: date
    hidden: yes
    sql: ${TABLE}.teff_date ;;
  }

  dimension: texp_date {
    type: date
    hidden: yes
    sql: ${TABLE}.texp_date ;;
  }

  dimension_group: accounting_date {
    type: time
    hidden: yes
    sql: ${TABLE}.accounting_date ;;
  }

  dimension: agency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.agency_id ;;
  }

  dimension: majorperil_id {
    type: number
    hidden: yes
    sql: ${TABLE}.majorperil_id ;;
  }

  dimension: asl_id {
    type: number
    hidden: yes
    sql: ${TABLE}.asl_id ;;
  }

  dimension: typebureau_id {
    type: number
    hidden: yes
    sql: ${TABLE}.typebureau_id ;;
  }

  dimension: unit_num {
    type: number
    hidden: yes
    sql: ${TABLE}.unit_num ;;
  }

  dimension: num_days {
    type: number
    hidden: yes
    sql: ${TABLE}.num_days ;;
  }

  dimension: earn_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.earn_rate ;;
  }

  measure: premium_fullterm {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_fullterm ;;
  }

  measure: premium_chg_fullterm {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_chg_fullterm ;;
  }

  measure: premium_written_mtd {
    label: "Written Premium"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_written_mtd ;;
  }

  measure: premium_written_ytd {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_written_ytd ;;
  }

  measure: premium_earned_mtd {
    label: "Earned Premium"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_earned_mtd
      ;;
  }

  measure: premium_earned_ytd {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_earned_ytd ;;
  }

  measure: premium_unearned {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_unearned ;;
  }

  measure: premium_unearned_mtd {
    label: "Unearned Premium"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_priormonth - ${TABLE}.premium_unearned ;;
  }

  measure: premium_unearned_ytd {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_prioryear - ${TABLE}.premium_unearned ;;
  }

  measure: premium_unearned_priormonth {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_priormonth ;;
  }

  measure: premium_unearned_prioryear {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_prioryear ;;
  }

  measure: premium_fullyearned {
    type: sum
    hidden: yes
    value_format_name: usd
    sql: ${TABLE}.premium_fullyearned ;;
  }

  dimension: added_date {
    type: date
    hidden: yes
    sql: ${TABLE}.added_date ;;
  }

  dimension_group: pcadded_date {
    type: time
    hidden: yes
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension_group: last_modified_date {
    type: time
    hidden: yes
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension: year_month_key {
    type: number
    hidden: yes
    sql: ${TABLE}.year_month_key ;;
  }


}

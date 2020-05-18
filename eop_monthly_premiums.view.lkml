view: eop_monthly_premiums {
  sql_table_name: EOPMonthlyPremiums  ;;


  dimension: eop_primary {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.year, ' ', ${TABLE}.month, ' ', ${TABLE}.policy_id, ' ', ${TABLE}.policyimage_num, ' ', ${TABLE}.coverage_num) ;;
  }


  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
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
    sql: ${TABLE}.eff_date ;;
  }

  dimension: exp_date {
    type: date
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
    value_format_name: usd
    sql: ${TABLE}.premium_fullterm ;;
  }

  measure: premium_chg_fullterm {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_chg_fullterm ;;
  }

  measure: premium_written_mtd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_written_mtd ;;
  }

  measure: premium_written_ytd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_written_ytd ;;
  }

  measure: premium_earned_mtd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_earned_mtd
    ;; drill_fields: [detail*]
  }

  measure: premium_earned_ytd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_earned_ytd ;;
  }

  measure: premium_unearned {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_unearned ;;
  }

  measure: premium_unearned_mtd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_priormonth - ${TABLE}.premium_unearned ;;
  }

  measure: premium_unearned_ytd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_prioryear - ${TABLE}.premium_unearned ;;
  }

  measure: premium_unearned_priormonth {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_priormonth ;;
  }

  measure: premium_unearned_prioryear {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.premium_unearned_prioryear ;;
  }

  measure: premium_fullyearned {
    type: sum
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

  set: detail {
    fields: [
      year,
      month,
      policy,
      renewal_ver,
      company_id,
      state_id,
      lob_id,
      eff_date,
      exp_date,
      teff_date,
      texp_date,
      accounting_date_time,
      agency_id,
      majorperil_id,
      asl_id,
      typebureau_id,
      unit_num,
      num_days,
      earn_rate,
      premium_fullterm,
      premium_chg_fullterm,
      premium_written_mtd,
      premium_written_ytd,
      premium_earned_mtd,
      premium_earned_ytd,
      premium_unearned,
      premium_unearned_priormonth,
      premium_unearned_prioryear,
      premium_fullyearned,
      added_date,
      pcadded_date_time,
      last_modified_date_time,
      year_month_key
    ]
  }
}

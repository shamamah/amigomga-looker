view: policy_image {
  sql_table_name: dbo.PolicyImage ;;
  view_label: "Policy"

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_id}, '  ', ${policyimage_num}) ;;
  }

  dimension: agency_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agency_id ;;
  }

  dimension: agencyproducer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.agencyproducer_id ;;
  }

  dimension: current_payplan_id {
    hidden: yes
    type: number
    sql: ${TABLE}.current_payplan_id ;;
  }

  dimension: policy {
    hidden: yes
    type: string
    sql: ${TABLE}.policy ;;
  }

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policystatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policystatuscode_id ;;
  }

  dimension_group: trans {
    label: "Transaction"
    type: time
    timeframes: [time, date, week, month, quarter, year]
    sql: ${TABLE}.trans_date ;;
  }

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.added_date ;;
  }

#   dimension: days_from_offer_generation_to_policy_issue {
#     hidden: yes
#     type: number
#     sql: DATEDIFF(day,${added_raw}, ${trans_raw}) ;;
#   }
#
#   dimension: days_from_offer_generation_to_policy_issue_tier {
#     hidden: yes
#     type: tier
#     tiers: [0, 30, 60, 90]
#     sql: ${days_from_offer_generation_to_policy_issue} ;;
#   }

  dimension: transreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transreason_id ;;
  }

  dimension: transtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transtype_id ;;
  }

  dimension: version_id {
    hidden: yes
    type: number
    sql: ${TABLE}.version_id ;;
  }

  dimension: trans_users_id {
    hidden: yes
    type: number
    sql: ${TABLE}.trans_users_id ;;
  }

  dimension: policyimage_num {
    label: "Image Number"
    type: string
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: pure_newbusiness {
    hidden: yes
    label: "Pure New Business"
    type: yesno
    sql: ${TABLE}.pure_newbusiness ;;
  }

  dimension: renewal_ver {
    label: "Renewal Term"
    type: string
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension_group: eff {
    label: "Term Effective"
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.eff_date ;;
  }

  dimension_group: exp {
    label: "Term Expiration"
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.exp_date ;;
  }

  dimension_group: teff {
    label: "Transaction Effective"
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.teff_date ;;
  }

  dimension_group: texp {
    label: "Transaction Expiration"
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.texp_date ;;
  }

  dimension_group: trans_date {
    hidden: yes
    label: "Transaction"
    type: time
    timeframes: [date, week]
    sql: ${TABLE}.trans_date ;;
  }

  dimension: trans_remark {
    hidden: yes
    label: "Transaction Remark"
    type: string
    sql: ${TABLE}.trans_remark ;;
  }

  dimension: premium_written {
    label: "Prem-Written"
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_written ;;
  }

  dimension: premium_fullterm {
    label: "Prem-Full Term"
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_fullterm ;;
  }

  dimension: premium_chg_written {
    label: "Prem-Change in Written"
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_chg_written ;;
  }

  dimension: premium_chg_fullterm {
    label: "Prem-Change in Full Term"
    type: number
    value_format_name: usd
    sql: ${TABLE}.premium_chg_fullterm ;;
  }

  dimension_group: received {
    label: "Received"
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.received_date ;;
  }

  measure: count {
    label: "Count"
    type: count
    drill_fields: [policyimage_drill*]
  }


  set: policyimage_drill {
    fields: [
      policy,
      policyimage_num,
      eff_date,
      exp_date,
      teff_date,
      texp_date,
      trans_type.dscr,
      trans_reason.dscr,
      trans_date_date
    ]
  }
}

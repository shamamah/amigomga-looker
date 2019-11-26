view: v_claim_detail_feature {
  sql_table_name: dbo.vClaimDetail_Feature ;;
  view_label: "Claimant Coverage"

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},${claimant_num},${claimfeature_num}) ;;
  }

  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    label: "Claimant Number"
    hidden: yes
    type: number
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    label: "Claim Feature Number"
    hidden:  yes
    type: number
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: exposure_dscr {
    label: "Exposure Description"
    type: string
    sql: ${TABLE}.exposure_dscr ;;
  }

  dimension: subexposure_dscr {
    label: "Subexposure Description"
    type: string
    sql: ${TABLE}.subexposure_dscr ;;
  }

  dimension: coverage_dscr {
    label: "Coverage"
    type: string
    sql: ${TABLE}.coverage_dscr ;;
  }

  dimension: status_dscr {
    type: string
    label: "Status (Claimant/Coverage)"
    sql: ${TABLE}.status_dscr ;;
  }

  dimension: initial_indemnity_reserve {
    hidden: yes
    type: number
    label: "Indemnity: Initial Reserve"
    sql: ${TABLE}.initial_indemnity_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: indemnity_reserve {
    hidden: yes
    type: number
    label: "Indemnity: Reserve"
    sql: ${TABLE}.indemnity_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: indemnity_paid {
    hidden: yes
    type: number
    label: "Indemnity: Paid"
    sql: ${TABLE}.indemnity_paid ;;
    value_format: "$#,##0.00"
  }

  dimension: initial_expense_reserve {
    hidden: yes
    type: number
    label: "Indemnity: Initial Expense"
    sql: ${TABLE}.initial_expense_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: expense_reserve {
    hidden: yes
    type: number
    label: "Expense: Reserve"
    sql: ${TABLE}.expense_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: expense_paid {
    hidden: yes
    type: number
    label: "Indemnity: Paid"
    sql: ${TABLE}.expense_paid ;;
    value_format: "$#,##0.00"
  }

  dimension: alae_reserve {
    hidden: yes
    type: number
    label: "ALAE: Reserve"
    sql: ${TABLE}.alae_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: alae_paid {
    hidden: yes
    type: number
    label: "ALAE: Paid"
    sql: ${TABLE}.alae_paid ;;
    value_format: "$#,##0.00"
  }

  dimension: expense_recovery {
    hidden: yes
    type: number
    label: "Expense Recovery"
    sql: ${TABLE}.expense_recovery ;;
    value_format: "$#,##0.00"
  }

  dimension: salvage {
    type: number
    sql: ${TABLE}.salvage ;;
    value_format: "$#,##0.00"
  }

  dimension: subro {
    type: number
    sql: ${TABLE}.subro ;;
    value_format: "$#,##0.00"
  }

  dimension: coveragecode_id {
    view_label: "Claimant Coverage"
    label: "CoverageCode ID"
    type: number
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: coveragecode {
    view_label: "Checks & Transactions"
    type: string
    hidden: no
    label: "Coverage Code"
    sql: case when ${TABLE}.coveragecode='UM' then 'UMBI' else ${TABLE}.coveragecode end ;;
  }

  dimension: claimcoverage_num {
    label: "Claim Coverage Number"
    type: number
    hidden: yes
    sql: ${TABLE}.claimcoverage_num ;;
  }

  measure: count {
    type: count
    label: "Count"
    drill_fields: [feature_stats*]
  }

  measure:  sum_indemnity_paid {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Loss Paid"
    sql: ${indemnity_paid} ;;
    value_format_name: usd
  }

  measure:  ave_indemnity_paid {
    view_label: "Claim Financials (Current)"
    type: average
    label: "Average Loss Paid"
    sql: ${indemnity_paid} ;;
    value_format_name: usd
    drill_fields: [percent_indemnity_paid*]
    filters: {
      field: indemnity_paid
      value: ">0.00"
    }
  }

  measure:  percent_indemnity_paid {
    view_label: "Claim Financials (Current)"
    type: percent_of_total
    label: "% Loss Paid"
    direction: "column"
    sql: ${sum_indemnity_paid} ;;
    value_format_name: decimal_1
    drill_fields: [percent_indemnity_paid*]
  }

  measure:  sum_indemnity_reserve {
    view_label: "Claim Financials (Current)"
    type:  sum
    label: "Loss Reserve"
    sql:  ${indemnity_reserve} ;;
    value_format_name: usd
  }

  measure: sum_total_indemnity_incurred{
    view_label: "Claim Financials (Current)"
    type: number
    label: "Loss Incurred"
    sql: ${sum_indemnity_paid} + ${sum_indemnity_reserve};;
    value_format_name: usd
  }

  measure: ave_total_indemnity_incurred{
    view_label: "Claim Financials (Current)"
    type: average
    label: "Loss Average Incurred"
    sql: ${indemnity_reserve} + ${indemnity_paid}  ;;
    value_format_name: usd
  }

  measure:  sum_expense_paid {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "AO Paid"
    sql: ${expense_paid} ;;
    value_format_name: usd
  }

  measure:  sum_expense_reserve {
    view_label: "Claim Financials (Current)"
    type:  sum
    label: "AO Reserve"
    sql:  ${expense_reserve} ;;
    value_format_name: usd
  }

  measure:  sum_expense_recovery {
    view_label: "Claim Financials (Current)"
    type:  sum
    label: "AO Recovery"
    sql:  ${expense_recovery} ;;
    value_format_name: usd
  }

  measure:  sum_alae_paid {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "DCC Paid"
    sql: ${alae_paid} ;;
    value_format_name: usd
  }

  measure:  sum_alae_reserve {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "DCC Reserve"
    sql: ${alae_reserve} ;;
    value_format_name: usd
  }

  measure: sum_initial_indemnity_reserve {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Loss Initial Reserve"
    sql: ${initial_indemnity_reserve} ;;
    value_format_name: usd
  }

  measure: sum_initial_expense_reserve {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "AO Initial Reserve"
    sql: ${initial_expense_reserve} ;;
    value_format_name: usd
  }

  measure: sum_salvage {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Salvage"
    sql: ${salvage} ;;
    value_format_name: usd
  }

  measure: sum_subro {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Subro"
    sql: ${subro} ;;
    value_format_name: usd
  }

  set: feature_stats {
    fields: [
      exposure_dscr,
      coveragecode,
      coverage_dscr,
      indemnity_reserve,
      indemnity_paid,
      expense_reserve,
      expense_paid
    ]
  }

  set: percent_indemnity_paid {
    fields: [
      claim_control.claim_number,
      claim_control.dscr,
      claim_loss_type.dscr,
      claim_type.dscr,
      claim_severity.dscr,
      claim_control.loss_date_date,
      claim_control.reported_date_date,
      status_dscr,
      coveragecode,
      coverage_dscr,
      indemnity_paid,
      expense_paid,
      alae_paid
    ]
  }
}

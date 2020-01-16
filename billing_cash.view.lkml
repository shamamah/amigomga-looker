view: billing_cash {
  sql_table_name: dbo.BillingCash ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${billingcash_id}, '  ', ${billingcash_num}) ;;
  }

  dimension: accountingbatch_id {
    hidden: yes
    type: number
    sql: ${TABLE}.accountingbatch_id ;;
  }

  dimension: accountingpayqueue_id {
    hidden: yes
    type: number
    sql: ${TABLE}.accountingpayqueue_id ;;
  }

  dimension: accountingsuspendedcash_id {
    hidden: yes
    type: number
    sql: ${TABLE}.accountingsuspendedcash_id ;;
  }

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: adjust_num {
    #May link to another view
    label: "Adjustment Number"
    type: number
    sql: ${TABLE}.adjust_num ;;
  }

  dimension: dim_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.amount ;;
  }

  measure: amount {
    label: "Cash Amount"
    type: sum
    value_format_name: usd
    sql: ${dim_amount} ;;
  }

  dimension: billingaccount_payment {
    hidden: yes
    type: string
    sql: ${TABLE}.billingaccount_payment ;;
  }

  dimension: billingaccountcash_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billingaccountcash_id ;;
  }

  dimension: billingaccountinvoice_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billingaccountinvoice_id ;;
  }

  dimension: billingaccountinvoice_num {
    hidden: yes
    type: number
    sql: ${TABLE}.billingaccountinvoice_num ;;
  }

  dimension: billingactivityorder {
    #Verify if needed
    label: "Activity Order"
    type: number
    sql: ${TABLE}.billingactivityorder ;;
  }

  dimension: billingcash_id {
    #unique identifier
    hidden: yes
    type: number
    sql: ${TABLE}.billingcash_id ;;
  }

  dimension: billingcash_num {
    #unique identifier
    hidden: yes
    type: number
    sql: ${TABLE}.billingcash_num ;;
  }

  dimension: billingcashinsource_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billingcashinsource_id ;;
  }

  dimension: billingcashtype_id {
    #Link to lookup view
    hidden: yes
    type: number
    sql: ${TABLE}.billingcashtype_id ;;
  }

  dimension: billinggrouping_num {
    hidden: yes
    type: number
    sql: ${TABLE}.billinggrouping_num ;;
  }

  dimension: billinggroupingreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billinggroupingreason_id ;;
  }

  dimension: billinglocation_id {
    hidden:yes
    type: number
    sql: ${TABLE}.billinglocation_id ;;
  }

  dimension: billingreason_id {
    #Link to lookup view
    hidden: yes
    type: number
    sql: ${TABLE}.billingreason_id ;;
  }

  dimension_group: check {
    label: "Check"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.check_date ;;
  }

  dimension: check_num {
    label: "Check Number"
    type: string
    sql: ${TABLE}.check_num ;;
  }

  dimension: checkitem_id {
    #Verify if needed
    label: "Check Item ID"
    type: number
    sql: ${TABLE}.checkitem_id ;;
  }

  dimension: checkpayeetype_id {
    #Verify if needed
    label: "Payee Type ID"
    type: number
    sql: ${TABLE}.checkpayeetype_id ;;
  }

  dimension: eftaccount_id {
    #Verify if needed
    label: "EFT Account ID"
    type: number
    sql: ${TABLE}.eftaccount_id ;;
  }

  dimension_group: export {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.export_date ;;
  }

  dimension: exportstatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.exportstatus_id ;;
  }

  dimension: external_batch_number {
    hidden: yes
    type: string
    sql: ${TABLE}.external_batch_number ;;
  }

  dimension_group: external_deposit {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.external_deposit_date ;;
  }

  dimension: external_deposit_number {
    hidden: yes
    type: number
    sql: ${TABLE}.external_deposit_number ;;
  }

  dimension_group: last_modified {
    hidden: yes
    label: "Last Modified"
    type: time
    timeframes: [date]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: pcadded {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: peoplesoftstatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.peoplesoftstatus_id ;;
  }

  dimension: policy_id {
    #Link to policy view
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: printprocess_id {
    hidden: yes
    type: number
    sql: ${TABLE}.printprocess_id ;;
  }

  dimension_group: prior_cancel {
    label: "Last Cancel"
    view_label: "Policy"
    type: time
    timeframes: [date]
    sql: ${TABLE}.prior_cancel_date ;;
  }

  dimension_group: prior_legal {
    label: "Last Legal Notice"
    view_label: "Policy"
    type: time
    timeframes: [date]
    sql: ${TABLE}.prior_legal_date ;;
  }

  dimension: receiptprintprocess_id {
    hidden: yes
    type: number
    sql: ${TABLE}.receiptprintprocess_id ;;
  }

  dimension: dim_tax_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.tax_amount ;;
  }

  measure: tax_amount {
    #No tax amount data available at time of development
    hidden: yes
    label: "Tax Amount"
    type: sum
    value_format_name: usd
    sql: ${dim_tax_amount} ;;
  }

  dimension: tax_version {
    hidden: yes
    type: number
    sql: ${TABLE}.tax_version ;;
  }

  dimension: transfer_from_policy {
    label: "Transfer from Policy"
    type: string
    sql: ${TABLE}.transfer_from_policy ;;
  }

  dimension: transfer_from_policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transfer_from_policy_id ;;
  }

  dimension: transfer_from_suspenseaccount_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transfer_from_suspenseaccount_id ;;
  }

  dimension: transfer_num {
    hidden: yes
    type: number
    sql: ${TABLE}.transfer_num ;;
  }

  dimension: transfer_to_policy {
    label: "Transfer to Policy"
    type: string
    sql: ${TABLE}.transfer_to_policy ;;
  }

  dimension: transfer_to_policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transfer_to_policy_id ;;
  }

  dimension: dim_unapplied_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.unapplied_amount ;;
  }

  measure: unapplied_amount {
    label: "Unapplied Amount"
    type: sum
    value_format_name: usd
    sql: ${dim_unapplied_amount} ;;
  }

  dimension: dim_unapplied_premcredit {
    hidden: yes
    type: number
    sql: ${TABLE}.unapplied_premcredit ;;
  }

  measure: unapplied_premcredit {
    label: "Unapplied Premium Credit"
    type: sum
    value_format_name: usd
    sql: ${dim_unapplied_premcredit} ;;
  }

  dimension: users_id {
    hidden: yes
    type: number
    sql: ${TABLE}.users_id ;;
  }

  measure: count {
    type: count
    drill_fields: [
      added_date,
      check_num,
      check_date,
      v_users.display_name,
      dim_amount,
      dim_unapplied_amount,
      unapplied_premcredit
    ]
  }
}

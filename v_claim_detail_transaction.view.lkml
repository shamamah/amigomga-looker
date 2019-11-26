view: v_claim_detail_transaction {
  sql_table_name: dbo.vClaimDetail_Transaction ;;
  view_label: "Claim Transactions"

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},${claimant_num},${claimfeature_num},${claimtransaction_num}) ;;
  }

  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: claimtransaction_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimtransaction_num ;;
  }

  dimension: cat_dscr {
    label: "Catastrophe Description"
    hidden: yes
    type: string
    sql: ${TABLE}.cat_dscr ;;
  }

  dimension: claimtransactioncategory_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactioncategory_id ;;
  }

  dimension: claimtransactiontype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactiontype_id ;;
  }

  dimension: type_dscr {
    label: "Trans Type Detail"
    type: string
    sql: ${TABLE}.type_dscr ;;
  }

  dimension_group: eff {
    hidden: yes
    label: "Date &"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.eff_date ;;
  }

  dimension: dim_amount {
    label: "Check Amount"
    type: number
    hidden: no
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }

  dimension: reserve {
    hidden: yes
    type: number
    sql: ${TABLE}.reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: remark {
    label: "Remark"
    type: string
    sql: ${TABLE}.remark ;;
  }

  dimension: status {
    label: "Status"
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: pay_type {
    #using claim_pay_type dscr value
    hidden: yes
    label: "Payment Type"
    type: string
    sql: ${TABLE}.pay_type ;;
  }

  dimension_group: reconcile_date {
    label: "Reconcile"
    hidden: yes
    type: time
    timeframes: [date]
    sql: ${TABLE}.reconcile_date ;;
  }

  dimension: claimtransactionsplit_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactionsplit_num ;;
  }

  dimension: bulk_check {
    label: "Is Bulk Check"
    type: string
    sql: case when ${TABLE}.bulk_check=1 then 'Yes' else 'No' end ;;
  }

  dimension: checkstatus_id {
    type: number
    hidden: yes
    sql: ${TABLE}.checkstatus_id ;;
  }

  dimension: pay_to_the_order_of {
    #hidden: yes
    label: "Pay To"
    type: string
    sql: ${TABLE}.pay_to_the_order_of ;;
  }

  dimension: reissued {
    hidden: yes
    type: string
    sql: case when ${TABLE}.reissued=1 then 'Yes' else 'No' end ;;
  }

  dimension: check_number {
    label: "Check Number"
    type: number
    sql: (case when (${TABLE}.check_number between 1 and 99999999) then ${TABLE}.check_number else null end) ;;
    value_format_name: id
  }

  dimension_group: check_date {
    label: "Check"
    type: time
    timeframes: [date]
    sql: case when (${TABLE}.check_date > '1900-01-01') then ${TABLE}.check_date else NULL end  ;;
  }

  measure: count {
    type: count
    drill_fields: [check_number, check_date_date, dim_amount, claim_control.claim_number, type_dscr, remark, pay_to_the_order_of, reissued, status, pay_type, bulk_check]
  }

  measure: amount {
    label: "Check Amount"
    type: number
    hidden: yes
    sql: ${dim_amount} ;;
    value_format_name: usd
  }
}

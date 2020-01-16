view: billing_invoice_image {
  sql_table_name: dbo.BillingInvoiceImage ;;

  dimension_group: added {
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

  dimension: current_outstanding_amount {
    type: string
    sql: ${TABLE}.current_outstanding_amount ;;
  }

  dimension_group: due {
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
    sql: ${TABLE}.due_date ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: pcadded {
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

  dimension: policy_id {
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: printed {
    type: string
    sql: ${TABLE}.printed ;;
  }

  dimension: printprocess_id {
    type: number
    sql: ${TABLE}.printprocess_id ;;
  }

  dimension: prior_outstanding_amount {
    type: string
    sql: ${TABLE}.prior_outstanding_amount ;;
  }

  dimension: tax_amount {
    type: string
    sql: ${TABLE}.tax_amount ;;
  }

  dimension: tax_rate {
    type: string
    sql: ${TABLE}.tax_rate ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: billing_invoice {
  sql_table_name: dbo.BillingInvoice ;;

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

  dimension: agencybill_current_outstanding {
    type: string
    sql: ${TABLE}.agencybill_current_outstanding ;;
  }

  dimension_group: agencybill_due {
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
    sql: ${TABLE}.agencybill_due_date ;;
  }

  dimension: billinginvoice_num {
    type: number
    sql: ${TABLE}.billinginvoice_num ;;
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

  dimension: printed {
    type: string
    sql: ${TABLE}.printed ;;
  }

  dimension: prior_outstanding_amount {
    type: string
    sql: ${TABLE}.prior_outstanding_amount ;;
  }

  dimension: scanline {
    type: string
    sql: ${TABLE}.scanline ;;
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

view: billing_history {
  sql_table_name: dbo.BillingHistory ;;

  dimension: amount {
    type: string
    sql: ${TABLE}.amount ;;
  }

  dimension: billingaccount_id {
    type: number
    sql: ${TABLE}.billingaccount_id ;;
  }

  dimension: billingcashinsource_id {
    type: number
    sql: ${TABLE}.billingcashinsource_id ;;
  }

  dimension: billinghistory_num {
    type: number
    sql: ${TABLE}.billinghistory_num ;;
  }

  dimension: billinghistorysubtype_id {
    type: number
    sql: ${TABLE}.billinghistorysubtype_id ;;
  }

  dimension: billinghistorytype_id {
    type: number
    sql: ${TABLE}.billinghistorytype_id ;;
  }

  dimension: check_num {
    type: string
    sql: ${TABLE}.check_num ;;
  }

  dimension: dscr {
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension_group: due {
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
    sql: ${TABLE}.due_date ;;
  }

  dimension_group: effective {
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
    sql: ${TABLE}.effective_date ;;
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

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
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

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.users_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: billing_future_cash {
  sql_table_name: dbo.BillingFutureCash ;;

  dimension: accountingbatch_id {
    type: number
    sql: ${TABLE}.accountingbatch_id ;;
  }

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

  dimension: amount {
    type: string
    sql: ${TABLE}.amount ;;
  }

  dimension: billingcashinsource_id {
    type: number
    sql: ${TABLE}.billingcashinsource_id ;;
  }

  dimension: billingcashtype_id {
    type: number
    sql: ${TABLE}.billingcashtype_id ;;
  }

  dimension: billingfuturecash_num {
    type: number
    sql: ${TABLE}.billingfuturecash_num ;;
  }

  dimension_group: check {
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
    type: string
    sql: ${TABLE}.check_num ;;
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

  dimension: printprocess_id {
    type: number
    sql: ${TABLE}.printprocess_id ;;
  }

  dimension: statuscode_id {
    type: number
    sql: ${TABLE}.statuscode_id ;;
  }

  dimension: transfer_from_policy {
    type: string
    sql: ${TABLE}.transfer_from_policy ;;
  }

  dimension: unapplied_amount {
    type: string
    sql: ${TABLE}.unapplied_amount ;;
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

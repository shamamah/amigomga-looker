view: billing_cash_detail {
  sql_table_name: dbo.BillingCashDetail ;;

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

  dimension: agencyactivity_id {
    type: number
    sql: ${TABLE}.agencyactivity_id ;;
  }

  dimension: amount {
    type: string
    sql: ${TABLE}.amount ;;
  }

  dimension: billingcash_num {
    type: number
    sql: ${TABLE}.billingcash_num ;;
  }

  dimension: billingcashdetail_num {
    type: number
    sql: ${TABLE}.billingcashdetail_num ;;
  }

  dimension: billingcashdetailtype_id {
    type: number
    sql: ${TABLE}.billingcashdetailtype_id ;;
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

  dimension: reappliedfromdetail_num {
    type: number
    sql: ${TABLE}.reappliedfromdetail_num ;;
  }

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

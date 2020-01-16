view: billing_cash_mchg_detail {
  sql_table_name: dbo.BillingCashMChgDetail ;;

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

  dimension: billingcashdetail_num {
    type: number
    sql: ${TABLE}.billingcashdetail_num ;;
  }

  dimension: billingchargecredit_num {
    type: number
    sql: ${TABLE}.billingchargecredit_num ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}

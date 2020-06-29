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

  dimension: bcd_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.billingcashdetail_num) ;;
  }

  dimension: agencyactivity_id {
    type: number
    hidden: yes
    sql: ${TABLE}.agencyactivity_id ;;
  }

  measure: amount {
    type: sum
    sql: -${TABLE}.amount ;;
    }

  dimension: billingcash_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billingcash_num ;;
  }

  dimension: billingcashdetail_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billingcashdetail_num ;;
  }

  dimension: billingcashdetailtype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billingcashdetailtype_id ;;
  }

  dimension_group: last_modified {
    type: time
    hidden: yes
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
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.policy_id ;;
  }

  dimension: reappliedfromdetail_num {
    type: number
    hidden: yes
    sql: ${TABLE}.reappliedfromdetail_num ;;
  }

  dimension: renewal_ver {
    type: number
    hidden: yes
    sql: ${TABLE}.renewal_ver ;;
  }

}

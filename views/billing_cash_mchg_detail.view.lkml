view: billing_cash_mchg_detail {
  sql_table_name: dbo.BillingCashMChgDetail ;;

  dimension_group: added {
    type: time
    hidden: yes
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

  measure: amount {
    label: "Mchg Amount"
    type: sum
    sql: ${TABLE}.amount ;;
  }

  dimension: bcmd_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.billingcashdetail_num, ' ', ${TABLE}.billingchargecredit_num) ;;
  }

  dimension: billingcashdetail_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billingcashdetail_num ;;
  }

  dimension: billingchargecredit_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billingchargecredit_num ;;
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

}

view: billing_cash_credit_card {
  sql_table_name: dbo.BillingCashCreditCard ;;

  dimension: account_num {
    type: string
    sql: ${TABLE}.account_num ;;
  }

  dimension: address_id {
    type: number
    sql: ${TABLE}.address_id ;;
  }

  dimension: approval_code {
    type: string
    sql: ${TABLE}.approval_code ;;
  }

  dimension: authresponse_code {
    type: string
    sql: ${TABLE}.authresponse_code ;;
  }

  dimension: authresponse_msg {
    type: string
    sql: ${TABLE}.authresponse_msg ;;
  }

  dimension: billingcash_num {
    type: number
    sql: ${TABLE}.billingcash_num ;;
  }

  dimension: creditcardtype_id {
    type: number
    sql: ${TABLE}.creditcardtype_id ;;
  }

  dimension: deduction_day {
    type: number
    sql: ${TABLE}.deduction_day ;;
  }

  dimension: expiration_date {
    type: string
    sql: ${TABLE}.expiration_date ;;
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

  dimension: name_id {
    type: number
    sql: ${TABLE}.name_id ;;
  }

  dimension: paylinxtype_id {
    type: number
    sql: ${TABLE}.paylinxtype_id ;;
  }

  dimension: paymentprocessor_id {
    type: number
    sql: ${TABLE}.paymentprocessor_id ;;
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

  dimension: sequence_number {
    type: string
    sql: ${TABLE}.sequence_number ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

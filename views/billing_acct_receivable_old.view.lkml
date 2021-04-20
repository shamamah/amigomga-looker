view: billing_acct_receivable_old {
  sql_table_name: dbo.BillingAcctReceivable ;;

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

  dimension: amount_to_renew {
    type: string
    sql: ${TABLE}.amount_to_renew ;;
  }

  dimension: current_mchg_outstanding {
    type: string
    sql: ${TABLE}.current_mchg_outstanding ;;
  }

  dimension: current_mchg_paid {
    type: string
    sql: ${TABLE}.current_mchg_paid ;;
  }

  dimension: current_premium_outstanding {
    type: string
    sql: ${TABLE}.current_premium_outstanding ;;
  }

  dimension: current_premium_paid {
    type: string
    sql: ${TABLE}.current_premium_paid ;;
  }

  dimension: current_schg_outstanding {
    type: string
    sql: ${TABLE}.current_schg_outstanding ;;
  }

  dimension: current_schg_paid {
    type: string
    sql: ${TABLE}.current_schg_paid ;;
  }

  dimension: future_mchg_outstanding {
    type: string
    sql: ${TABLE}.future_mchg_outstanding ;;
  }

  dimension: future_premium_outstanding {
    type: string
    sql: ${TABLE}.future_premium_outstanding ;;
  }

  dimension: future_premium_waived {
    type: string
    sql: ${TABLE}.future_premium_waived ;;
  }

  dimension: future_schg_outstanding {
    type: string
    sql: ${TABLE}.future_schg_outstanding ;;
  }

  dimension: is_renewal_cancellation_valid {
    type: string
    sql: ${TABLE}.is_renewal_cancellation_valid ;;
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

  dimension: premium_future_written {
    type: string
    sql: ${TABLE}.premium_future_written ;;
  }

  dimension: premium_written {
    type: string
    sql: ${TABLE}.premium_written ;;
  }

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: total_mchg_waived {
    type: string
    sql: ${TABLE}.total_mchg_waived ;;
  }

  dimension: total_outstanding {
    type: string
    sql: ${TABLE}.total_outstanding ;;
  }

  dimension: total_premium_billed {
    type: string
    sql: ${TABLE}.total_premium_billed ;;
  }

  dimension: total_premium_waived {
    type: string
    sql: ${TABLE}.total_premium_waived ;;
  }

  dimension: total_schg_waived {
    type: string
    sql: ${TABLE}.total_schg_waived ;;
  }

  dimension: totalcash {
    type: string
    sql: ${TABLE}.totalcash ;;
  }

  dimension: unapplied_cash {
    type: string
    sql: ${TABLE}.unapplied_cash ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: billing_acct_receivable {
  sql_table_name: dbo.BillingAcctReceivable;;


  measure: count {
    type: count
  }

  dimension: policy_id {
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: primary_k{
    type:  string
    primary_key: yes
    sql: CONCAT(${TABLE}.policy_id + '_' + ${TABLE}.renewal_ver);;

  }

  dimension: premium_written {
    type: string
    sql: ${TABLE}.premium_written ;;
  }

  dimension: premium_future_written {
    type: string
    sql: ${TABLE}.premium_future_written ;;
  }

  dimension: totalcash {
    type: string
    sql: ${TABLE}.totalcash ;;
  }

  dimension: unapplied_cash {
    type: string
    sql: ${TABLE}.unapplied_cash ;;
  }

  dimension: total_outstanding {
    type: string
    sql: ${TABLE}.total_outstanding ;;
  }

  dimension: total_premium_billed {
    type: string
    sql: ${TABLE}.total_premium_billed ;;
  }

  dimension: current_premium_outstanding {
    type: string
    sql: ${TABLE}.current_premium_outstanding ;;
  }

  dimension: current_premium_paid {
    type: string
    sql: ${TABLE}.current_premium_paid ;;
  }

  dimension: future_premium_outstanding {
    type: string
    sql: ${TABLE}.future_premium_outstanding ;;
  }

  dimension: current_schg_outstanding {
    type: string
    sql: ${TABLE}.current_schg_outstanding ;;
  }

  dimension: current_schg_paid {
    type: string
    sql: ${TABLE}.current_schg_paid ;;
  }

  dimension: future_schg_outstanding {
    type: string
    sql: ${TABLE}.future_schg_outstanding ;;
  }

  dimension: current_mchg_outstanding {
    type: string
    sql: ${TABLE}.current_mchg_outstanding ;;
  }

  dimension: current_mchg_paid {
    type: string
    sql: ${TABLE}.current_mchg_paid ;;
  }

  dimension: future_mchg_outstanding {
    type: string
    sql: ${TABLE}.future_mchg_outstanding ;;
  }

  dimension: added_date {
    type: date
    sql: ${TABLE}.added_date ;;
  }

  dimension_group: pcadded_date {
    type: time
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: total_mchg_waived {
    type: string
    sql: ${TABLE}.total_mchg_waived ;;
  }

  dimension: total_schg_waived {
    type: string
    sql: ${TABLE}.total_schg_waived ;;
  }

  dimension: total_premium_waived {
    type: string
    sql: ${TABLE}.total_premium_waived ;;
  }

  dimension: future_premium_waived {
    type: string
    sql: ${TABLE}.future_premium_waived ;;
  }

  dimension_group: last_modified_date {
    type: time
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension: is_renewal_cancellation_valid {
    type: string
    sql: ${TABLE}.is_renewal_cancellation_valid ;;
  }

  dimension: amount_to_renew {
    type: string
    sql: ${TABLE}.amount_to_renew ;;
  }
}

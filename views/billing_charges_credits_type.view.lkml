view: billing_charges_credits_type {
  sql_table_name: dbo.BillingChargesCreditsType ;;

  dimension: billingchargescreditstype_id {
    type: number
    sql: ${TABLE}.billingchargescreditstype_id ;;
  }

  dimension: billingchargetypecategory_id {
    type: number
    sql: ${TABLE}.billingchargetypecategory_id ;;
  }

  dimension: dscr {
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: endorsementchargescreditstype_id {
    type: number
    sql: ${TABLE}.endorsementchargescreditstype_id ;;
  }

  dimension: flat_cancel_waive {
    type: string
    sql: ${TABLE}.flat_cancel_waive ;;
  }

  dimension: is_flat_fee {
    type: string
    sql: ${TABLE}.is_flat_fee ;;
  }

  dimension: is_initial_installment_fee {
    type: string
    sql: ${TABLE}.is_initial_installment_fee ;;
  }

  dimension: is_per_installment_fee {
    type: string
    sql: ${TABLE}.is_per_installment_fee ;;
  }

  dimension: is_percent_of_premium_fee {
    type: string
    sql: ${TABLE}.is_percent_of_premium_fee ;;
  }

  dimension: is_static_fee {
    type: string
    sql: ${TABLE}.is_static_fee ;;
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

  dimension: loadfield {
    type: string
    sql: ${TABLE}.loadfield ;;
  }

  dimension: payment_order {
    type: number
    sql: ${TABLE}.payment_order ;;
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

  dimension: premium_audit_billingchargescreditstype_id {
    type: number
    sql: ${TABLE}.premium_audit_billingchargescreditstype_id ;;
  }

  dimension: print_description {
    type: string
    sql: ${TABLE}.print_description ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

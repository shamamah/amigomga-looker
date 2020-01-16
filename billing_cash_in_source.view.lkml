view: billing_cash_in_source {
  sql_table_name: dbo.BillingCashInSource ;;

  dimension: billingcashinsource_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.billingcashinsource_id ;;
  }

  dimension: billingcashinsourcecategory_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billingcashinsourcecategory_id ;;
  }

  dimension: check_date_max_days_future {
    hidden: yes
    type: number
    sql: ${TABLE}.check_date_max_days_future ;;
  }

  dimension: check_date_max_days_past {
    hidden: yes
    type: number
    sql: ${TABLE}.check_date_max_days_past ;;
  }

  dimension: dscr {
    label: "Source"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension_group: last_modified {
    hidden: yes
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
    hidden: yes
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

  dimension: requirenum {
    hidden: yes
    type: string
    sql: ${TABLE}.requirenum ;;
  }

  dimension: set_lapse_date_to_check_date_plus1 {
    hidden: yes
    type: string
    sql: ${TABLE}.set_lapse_date_to_check_date_plus1 ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

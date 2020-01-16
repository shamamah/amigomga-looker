view: billing_cash_in_source_category {
  sql_table_name: dbo.BillingCashInSourceCategory ;;

  dimension: billingcashinsourcecategory_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.billingcashinsourcecategory_id ;;
  }

  dimension: dscr {
    label: "Source Category"
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

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

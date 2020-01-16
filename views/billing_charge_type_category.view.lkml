view: billing_charge_type_category {
  sql_table_name: dbo.BillingChargeTypeCategory ;;

  dimension: billingchargetypecategory_id {
    type: number
    sql: ${TABLE}.billingchargetypecategory_id ;;
  }

  dimension: category_order {
    type: number
    sql: ${TABLE}.category_order ;;
  }

  dimension: dscr {
    type: string
    sql: ${TABLE}.dscr ;;
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

  measure: count {
    type: count
    drill_fields: []
  }
}

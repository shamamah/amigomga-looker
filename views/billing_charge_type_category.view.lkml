view: billing_charge_type_category {
  sql_table_name: dbo.BillingChargeTypeCategory ;;

  dimension: billingchargetypecategory_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billingchargetypecategory_id ;;
  }

  dimension: category_order {
    type: number
    hidden: yes
    sql: ${TABLE}.category_order ;;
  }

  dimension: dscr {
    label: "Charge Category"
    type: string
    sql: ${TABLE}.dscr ;;
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

}

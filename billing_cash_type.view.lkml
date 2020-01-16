view: billing_cash_type {
  sql_table_name: dbo.BillingCashType ;;

  dimension: billingcashtype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.billingcashtype_id ;;
  }

  dimension: dscr {
    label: "Cash Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: iscashin {
    label: "Credit/Debit"
    type: string
    sql: case when ${TABLE}.iscashin='true' then 'Credit' else 'Debit' end ;;
  }

  dimension_group: last_modified {
    hidden:yes
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

  dimension: print_description {
    hidden: yes
    type: string
    sql: ${TABLE}.print_description ;;
  }

  dimension: useadjustmentrules {
    label: "Use Adjustment Rules (Y/N)"
    type: string
    sql: case when ${TABLE}.useadjustmentrules='true' then 'Yes' else 'No' end ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

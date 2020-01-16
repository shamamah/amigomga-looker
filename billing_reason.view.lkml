view: billing_reason {
  sql_table_name: dbo.BillingReason ;;

  dimension: billingadjustment_id {
    hidden: yes
    type: number
    sql: ${TABLE}.billingadjustment_id ;;
  }

  dimension: billingreason_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.billingreason_id ;;
  }

  dimension: dscr {
    label: "Reason"
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

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

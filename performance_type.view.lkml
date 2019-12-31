view: performance_type {
  sql_table_name: dbo.PerformanceType ;;

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: dscr {
    label: "Performance Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: interfacecode {
    hidden: yes
    type: string
    sql: ${TABLE}.interfacecode ;;
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

  dimension: performancetype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.performancetype_id ;;
  }

  dimension: upload_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.upload_dscr ;;
  }

  dimension: xmlinterfacecode {
    hidden: yes
    type: string
    sql: ${TABLE}.xmlinterfacecode ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

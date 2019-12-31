view: license_status {
  sql_table_name: dbo.LicenseStatus ;;

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: dscr {
    label: "License Status"
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

  dimension: licensestatus_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.licensestatus_id ;;
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

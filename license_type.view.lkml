view: license_type {
  sql_table_name: dbo.LicenseType ;;

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: dscr {
    label: "License Type"
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

  dimension: licensetype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.licensetype_id ;;
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

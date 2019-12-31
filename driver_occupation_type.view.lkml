view: driver_occupation_type {
  sql_table_name: dbo.DriverOccupationType ;;

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: driveroccupationtype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.driveroccupationtype_id ;;
  }

  dimension: dscr {
    label: "Occupation Type"
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

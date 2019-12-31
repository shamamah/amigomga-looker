view: coverage_exposure {
  sql_table_name: dbo.CoverageExposure ;;

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: coverageexposure_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.coverageexposure_id ;;
  }

  dimension: dscr {
    label: "Exposure"
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

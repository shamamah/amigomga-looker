view: driver_exclude_type {
  sql_table_name: dbo.DriverExcludeType ;;

  dimension: claim_record_only {
    hidden: yes
    type: string
    sql: ${TABLE}.claim_record_only ;;
  }

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display_as_excluded {
    hidden: yes
    type: string
    sql: ${TABLE}.display_as_excluded ;;
  }

  dimension: driverexcludetype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.driverexcludetype_id ;;
  }

  dimension: dscr {
    label: "Exclusion Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: is_rated {
    hidden: yes
    type: string
    sql: ${TABLE}.is_rated ;;
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

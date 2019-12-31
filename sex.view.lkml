view: sex {
  sql_table_name: dbo.Sex ;;

  dimension: sex_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.sex_id ;;
  }

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: dscr {
    label: "Gender"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: iso_bureaucode {
    hidden: yes
    type: number
    sql: ${TABLE}.iso_bureaucode ;;
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

  dimension: naii_bureaucode {
    hidden: yes
    type: number
    sql: ${TABLE}.naii_bureaucode ;;
  }

  dimension: niss_bureaucode {
    hidden: yes
    type: number
    sql: ${TABLE}.niss_bureaucode ;;
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

  dimension: sexcategory_id {
    hidden: yes
    type: number
    sql: ${TABLE}.sexcategory_id ;;
  }

  dimension: tableorder {
    hidden: yes
    type: number
    sql: ${TABLE}.tableorder ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [sex_id]
  }
}

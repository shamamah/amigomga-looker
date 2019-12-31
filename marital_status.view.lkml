view: marital_status {
  sql_table_name: dbo.MaritalStatus ;;

  dimension: acord_code {
    hidden: yes
    type: string
    sql: ${TABLE}.acord_code ;;
  }

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: coverageverifiermaritalstatustype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coverageverifiermaritalstatustype_id ;;
  }

  dimension: dscr {
    label: "Marital Status"
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

  dimension: maritalstatus_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.maritalstatus_id ;;
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

  dimension: tableorder {
    hidden: yes
    type: number
    sql: ${TABLE}.tableorder ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

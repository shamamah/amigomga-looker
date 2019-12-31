view: restraint_type {
  sql_table_name: dbo.RestraintType ;;

  dimension: aais_bureaucode {
    hidden: yes
    type: string
    sql: ${TABLE}.aais_bureaucode ;;
  }

  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: dscr {
    label: "Restraint Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: interfacecode {
    hidden: yes
    type: string
    sql: ${TABLE}.interfacecode ;;
  }

  dimension: iso_bureaucode {
    hidden: yes
    type: string
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
    type: string
    sql: ${TABLE}.naii_bureaucode ;;
  }

  dimension: niss_bureaucode {
    hidden: yes
    type: string
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

  dimension: restrainttype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.restrainttype_id ;;
  }

  dimension: upload_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.upload_dscr ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

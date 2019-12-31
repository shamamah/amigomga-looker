view: body_type {
  sql_table_name: dbo.BodyType ;;

  dimension: aais_classcode {
    hidden: yes
    type: string
    sql: ${TABLE}.aais_classcode ;;
  }

  dimension: bodytype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.bodytype_id ;;
  }

  dimension: dscr {
    label: "Body Type"
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

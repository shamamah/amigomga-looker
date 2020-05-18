view: version {
  sql_table_name: dbo.vVersion ;;

  dimension: companystatelob_id {
    hidden: yes
    type: number
    sql: ${TABLE}.companystatelob_id ;;
  }

  dimension: version_id {
    hidden: yes
    type: number
    sql: ${TABLE}.version_id ;;
  }

  dimension: lob_name {
    label: "LOB"
    type: string
    sql: ${TABLE}.lobname ;;
    drill_fields: [state]
  }

  dimension: state {
    label: "State"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: commercial_name1 {
    label: "Company"
    type: string
    sql: ${TABLE}.commercial_name1 ;;
    drill_fields: [lob_name]
  }
}

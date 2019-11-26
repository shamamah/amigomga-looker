view: check_status {
  sql_table_name: dbo.CheckStatus ;;

  dimension: checkstatus_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.checkstatus_id ;;
  }

  dimension: description {
    label: "Check Status"
    type: string
    sql: ${TABLE}.description ;;
  }
}

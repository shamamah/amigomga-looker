view: policy_current_status {
  sql_table_name: dbo.PolicyCurrentStatus ;;

  dimension: policycurrentstatus_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.policycurrentstatus_id ;;
  }

  dimension: description {
    label: "Policy Status"
    type: string
    sql: ${TABLE}.description ;;
  }
}

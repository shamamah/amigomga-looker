view: policy {
  sql_table_name: dbo.Policy ;;

  dimension: policy_id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policycurrentstatus_id {
    hidden: yes
    type: string
    sql: ${TABLE}.policycurrentstatus_id ;;
  }

  dimension_group: cancel_date {
    hidden: yes
    label: "Cancellation"
    type: time
    timeframes: [date]
    sql: ${TABLE}.cancel_date ;;
  }

  dimension_group: legalcancel_date {
    hidden: yes
    label: "Legal Cancellation"
    type: time
    timeframes: [date]
    sql: ${TABLE}.legalcancel_date ;;
  }

  dimension: current_policy {
    type: string
    label: "Number"
    sql: ${TABLE}.current_policy ;;
  }

  dimension: activeimage_num {
    hidden: yes
    label: "Active Image Number"
    type: string
    sql: ${TABLE}.activeimage_num ;;
  }

  dimension: external_policy_source {
    label: "Form Type"
    type: string
    sql: ${TABLE}.external_policy_source ;;
  }
}

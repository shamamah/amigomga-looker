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
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
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

  dimension: nonrenewreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nonrenewreason_id ;;
  }

  dimension: rewrittenfrom_policy_id {
    hidden: no
    type: number
    sql: ${TABLE}.rewrittenfrom_policy_id ;;
  }

  dimension: quotesource_id {
    hidden: yes
    type: number
    sql: ${TABLE}.quotesource_id ;;
  }

  dimension_group: first_eff_date {
    label: "First Effective Date"
    type: time
    timeframes: [date, week, month, quarter, year, day_of_week]
    sql: ${TABLE}.first_eff_date ;;
  }

  dimension_group: firstwritten_date {
    label: "First Written Date"
    type: time
    timeframes: [date, week, month, quarter, year, day_of_week]
    sql: ${TABLE}.firstwritten_date ;;
  }

  measure: count_distinct_policy {
    type: count_distinct
    sql:  ${TABLE}.policy_id ;;
#    drill_fields: [policy_drill*]
#     link: {
#       label: "Sort by Policy"
#       url: "{{ link }}&sorts=policy.current_policy"
#     }
  }


  set: policy_drill {
    fields: [
      current_policy,
      policy_current_status.description,
      first_eff_date_date
    ]
  }
}

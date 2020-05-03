view: v_agency {
  sql_table_name: vagency;;
  label: "Agency"

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: agency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.agency_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: commercial_name1 {
    type: string
    label: "Agency Name"
    sql: ${TABLE}.commercial_name1 ;;
  }

  dimension: Agency_Name_Code{
    type: string
    label: "Agency Name and Code"
    sql: concat(${TABLE}.commercial_name1,' (', ${TABLE}.code, ')');;
  }
  dimension: commercial_name2 {
    type: string
    hidden: yes
    sql: ${TABLE}.commercial_name2 ;;
  }

  dimension: code {
    type: string
    label: "Agency Number"
    sql: ${TABLE}.code ;;
  }

  dimension_group: close_date {
    type: time
    hidden: yes
    sql: ${TABLE}.close_date ;;
  }

  dimension: nameaddresssource_id {
    type: number
    hidden: yes
    sql: ${TABLE}.nameaddresssource_id ;;
  }

  dimension: agencygroup_id {
    type: number
    hidden: yes
    sql: ${TABLE}.agencygroup_id ;;
  }

  dimension: agencygroupname {
    type: string
    hidden: yes
    sql: ${TABLE}.agencygroupname ;;
  }

  dimension: printertypedscr {
    type: string
    hidden: yes
    sql: ${TABLE}.printertypedscr ;;
  }

  dimension: asr_users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.asr_users_id ;;
  }

  dimension_group: suspend_date {
    type: time
    hidden: yes
    sql: ${TABLE}.suspend_date ;;
  }

  set: detail {
    fields: [
      agency_id,
      status,
      commercial_name1,
      commercial_name2,
      code,
      close_date_time,
      nameaddresssource_id,
      agencygroup_id,
      agencygroupname,
      printertypedscr,
      asr_users_id,
      suspend_date_time
    ]
  }
}

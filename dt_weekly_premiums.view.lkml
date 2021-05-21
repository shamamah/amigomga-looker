view: dt_weekly_premiums {
  sql_table_name: customer_reports.dbo.tbl_weekly_premiums;;

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    hidden: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: week_date {
    type: date
    sql: ${TABLE}.week_date ;;
  }

  dimension: policy {
    type: string
    hidden: yes
    sql: ${TABLE}.policy ;;
  }

  dimension: policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_id ;;
  }

  dimension: coveragecode_id {
    type: number
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: version_id {
    type: number
    sql: ${TABLE}.version_id ;;
  }

  dimension: eff_date {
    type: date
    sql: ${TABLE}.eff_date ;;
  }

  measure: totalearnedpremium {
    type: sum
    sql: ${TABLE}.totalearnedpremium ;;
  }

  measure: totalwrittenpremium {
    type: sum
    sql: ${TABLE}.totalwrittenpremium ;;
  }

  dimension: added_date {
    type: date
    hidden: yes
    sql: ${TABLE}.added_date ;;
  }

  set: detail {
    fields: [
      id,
      week_date,
      policy,
      policy_id,
      coveragecode_id,
      renewal_ver,
      version_id,
      eff_date,
      totalearnedpremium,
      totalwrittenpremium,
      added_date
    ]
  }
}

view: claim_feature_eod {
  sql_table_name: ClaimFeatureEOD;;


  dimension: claim_feature_primary {
    primary_key: yes
    sql: CONCAT(${TABLE}.claimcontrol_id, ' ', ${TABLE}.claimant_num, ' ', ${TABLE}.claimfeature_num, ' ', ${TABLE}.year, ' ', ${TABLE}.month, ' ', ${TABLE}.claimeoplevel_id) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: claimeoplevel_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimeoplevel_id ;;
  }

  dimension: claimfinancials_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfinancials_num ;;
  }

  dimension: added_date {
    type: date
    hidden: yes
    sql: ${TABLE}.added_date ;;
  }

  dimension_group: pcadded_date {
    type: time
    hidden: yes
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension_group: last_modified_date {
    type: time
    hidden: yes
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension: year_month_key {
    type: number
    hidden: yes
    sql: ${TABLE}.year_month_key ;;
  }

  set: detail {
    fields: [
      claimcontrol_id,
      claimant_num,
      claimfeature_num,
      year,
      month,
      claimeoplevel_id,
      claimfinancials_num,
      added_date,
      pcadded_date_time,
      last_modified_date_time,
      year_month_key
    ]
  }
}

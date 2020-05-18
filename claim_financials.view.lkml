view: claim_financials {
  sql_table_name: claimfinancials;;

  dimension: claim_financials_primary {
    primary_key: yes
    sql: CONCAT(${TABLE}.claimcontrol_id, ' ', ${TABLE}.claimfinancials_num) ;;
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

  dimension: claimfinancials_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfinancials_num ;;
  }

  dimension: claimfinanciallevel_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfinanciallevel_id ;;
  }

  dimension: initial_indemnity_reserve {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_indemnity_reserve ;;
  }

  measure: indemnity_reserve {
    label: "Reserve Change"
    type: sum
    sql: ${TABLE}.indemnity_reserve ;;
  }

  measure: indemnity_paid {
    label: "Paid"
    type: sum
    sql: ${TABLE}.indemnity_paid ;;
  }

  dimension: initial_alae_reserve {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_alae_reserve ;;
  }

  measure: alae_reserve {
    label: "ALAE Reserve Change"
    type: sum
    sql: ${TABLE}.alae_reserve ;;
  }

  measure: alae_paid {
    label: "ALAE Paid"
    type: sum
    sql: ${TABLE}.alae_paid ;;
  }

  dimension: initial_expense_reserve {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_expense_reserve ;;
  }

  measure: expense_reserve {
    label: "Expense Reserve Change"
    type: sum
    hidden: yes
    sql: ${TABLE}.expense_reserve ;;
  }

  measure: expense_paid {
    label: "ULAE Paid"
    type: sum
    sql: ${TABLE}.expense_paid ;;
  }

  dimension: initial_anticipated_expense_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_anticipated_expense_recovery ;;
  }

  dimension: anticipated_expense_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.anticipated_expense_recovery ;;
  }

  dimension: expense_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.expense_recovery ;;
  }

  dimension: initial_anticipated_salvage {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_anticipated_salvage ;;
  }

  measure: anticipated_salvage {
    label: "Anticipated Salvage"
    type: sum
    sql: ${TABLE}.anticipated_salvage ;;
  }

  measure: salvage {
    label: "Salvage"
    type: sum
    sql: ${TABLE}.salvage ;;
  }

  dimension: initial_anticipated_subro {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_anticipated_subro ;;
  }

  measure: anticipated_subro {
    label: "Anticipated Subro"
    type: sum
    sql: ${TABLE}.anticipated_subro ;;
  }

  measure: subro {
    label: "Subro"
    type: sum
    sql: ${TABLE}.subro ;;
  }

  dimension: initial_anticipated_other_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.initial_anticipated_other_recovery ;;
  }

  dimension: anticipated_other_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.anticipated_other_recovery ;;
  }

  dimension: other_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.other_recovery ;;
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

  set: detail {
    fields: [
      indemnity_reserve,
      indemnity_paid,
      alae_reserve,
      alae_paid,
      expense_reserve,
      expense_paid,
      expense_recovery,
      anticipated_salvage,
      salvage,
      anticipated_subro,
      subro
    ]
  }
}

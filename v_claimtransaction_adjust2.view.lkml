view: v_claimtransaction_adjust2 {
  sql_table_name: vClaimTransaction_Adjust2;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: compound_primary_key {
      type: string
      primary_key: yes
      hidden: yes
      sql: CONCAT(${claimcontrol_id},${claimant_num},${claimfeature_num},${claimtransaction_num}) ;;
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: claimcontrol_id {
      type: number
      sql: ${TABLE}.claimcontrol_id ;;
    }

    dimension: claimant_num {
      type: number
      sql: ${TABLE}.claimant_num ;;
    }

    dimension: claimfeature_num {
      type: number
      sql: ${TABLE}.claimfeature_num ;;
    }

    dimension: claimtransaction_num {
      type: number
      sql: ${TABLE}.claimtransaction_num ;;
    }

    dimension: claimtransactiontype_id {
      type: number
      sql: ${TABLE}.claimtransactiontype_id ;;
    }

    dimension: claimtransactionstatus_id {
      type: number
      sql: ${TABLE}.claimtransactionstatus_id ;;
    }

    dimension: calc {
      type: string
      sql: ${TABLE}.calc ;;
    }

    dimension: amount {
      type: string
      sql: ${TABLE}.amount ;;
    }

    dimension: users_id {
      type: number
      sql: ${TABLE}.users_id ;;
    }

    dimension: adjust_indemnity_reserve {
      type: number
      sql: ${TABLE}.adjust_indemnity_reserve ;;
    }

    dimension: adjust_indemnity_paid {
      type: number
      sql: ${TABLE}.adjust_indemnity_paid ;;
    }

    dimension: adjust_expense_reserve {
      type: number
      sql: ${TABLE}.adjust_expense_reserve ;;
    }

    dimension: adjust_expense_paid {
      type: number
      sql: ${TABLE}.adjust_expense_paid ;;
    }

    dimension: adjust_alae_reserve {
      type: number
      sql: ${TABLE}.adjust_alae_reserve ;;
    }

    dimension: adjust_alae_paid {
      type: number
      sql: ${TABLE}.adjust_alae_paid ;;
    }

    dimension: adjust_expense_recovery {
      type: number
      sql: ${TABLE}.adjust_expense_recovery ;;
    }

    dimension: adjust_ant_expense_recovery {
      type: number
      sql: ${TABLE}.adjust_ant_expense_recovery ;;
    }

    dimension: adjust_ant_salvage {
      type: number
      sql: ${TABLE}.adjust_ant_salvage ;;
    }

    dimension: adjust_salvage {
      type: number
      sql: ${TABLE}.adjust_salvage ;;
    }

    dimension: adjust_ant_subro {
      type: number
      sql: ${TABLE}.adjust_ant_subro ;;
    }

    dimension: adjust_subro {
      type: number
      sql: ${TABLE}.adjust_subro ;;
    }

    dimension: adjust_ant_other_recovery {
      type: number
      sql: ${TABLE}.adjust_ant_other_recovery ;;
    }

    dimension: adjust_other_recovery {
      type: number
      sql: ${TABLE}.adjust_other_recovery ;;
    }

    measure: indemnity_reserve {
      type: sum
      sql: ${TABLE}.indemnity_reserve;;
      value_format_name: usd
    }

    measure: indemnity_paid {
      type: sum
      sql: ${TABLE}.indemnity_paid ;;
      value_format_name: usd
    }

    measure: expense_reserve {
      type: sum
      sql: ${TABLE}.expense_reserve ;;
      value_format_name: usd
    }

    measure: expense_paid {
      type: string
      sql: ${TABLE}.expense_paid ;;
      value_format_name: usd
    }

    measure: alae_reserve {
      type: sum
      sql: ${TABLE}.alae_reserve ;;
      value_format_name: usd
    }

    measure: alae_paid {
      type: sum
      sql: ${TABLE}.alae_paid ;;
      value_format_name: usd
    }

    measure: expense_recovery {
      type: sum
      sql: ${TABLE}.expense_recovery ;;
      value_format_name: usd
    }

    dimension: ant_expense_recovery {
      type: string
      sql: ${TABLE}.ant_expense_recovery ;;
    }

    dimension: ant_salvage {
      type: string
      sql: ${TABLE}.ant_salvage ;;
    }

    measure: salvage {
      type: sum
      sql: ${TABLE}.salvage ;;
      value_format_name: usd
    }

    dimension: ant_subro {
      type: string
      sql: ${TABLE}.ant_subro ;;
    }

    measure: subro {
      type: sum
      sql: ${TABLE}.subro ;;
      value_format_name: usd
    }

    dimension: ant_other_recovery {
      type: string
      sql: ${TABLE}.ant_other_recovery ;;
    }

    measure: other_recovery {
      type: sum
      sql: ${TABLE}.other_recovery ;;
      value_format_name: usd
    }

    dimension: old_reserve {
      type: string
      sql: ${TABLE}.old_reserve ;;
    }

    dimension_group: eff_date {
      type: time
      sql: ${TABLE}.eff_date ;;
    }

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension: report_payment {
      type: string
      sql: ${TABLE}.report_payment ;;
    }

    dimension: report_cash {
      type: string
      sql: ${TABLE}.report_cash ;;
    }

    dimension: claimscheduledpaymentcycle_id {
      type: number
      sql: ${TABLE}.claimscheduledpaymentcycle_id ;;
    }

    set: detail {
      fields: [
        policy_id,
        policyimage_num,
        claimcontrol_id,
        claimant_num,
        claimfeature_num,
        claimtransaction_num,
        claimtransactiontype_id,
        claimtransactionstatus_id,
        calc,
        amount,
        users_id,
        adjust_indemnity_reserve,
        adjust_indemnity_paid,
        adjust_expense_reserve,
        adjust_expense_paid,
        adjust_alae_reserve,
        adjust_alae_paid,
        adjust_expense_recovery,
        adjust_ant_expense_recovery,
        adjust_ant_salvage,
        adjust_salvage,
        adjust_ant_subro,
        adjust_subro,
        adjust_ant_other_recovery,
        adjust_other_recovery,
        indemnity_reserve,
        indemnity_paid,
        expense_reserve,
        expense_paid,
        alae_reserve,
        alae_paid,
        expense_recovery,
        ant_expense_recovery,
        ant_salvage,
        salvage,
        ant_subro,
        subro,
        ant_other_recovery,
        other_recovery,
        old_reserve,
        eff_date_time,
        added_date,
        pcadded_date_time,
        report_payment,
        report_cash,
        claimscheduledpaymentcycle_id
      ]
    }
  }

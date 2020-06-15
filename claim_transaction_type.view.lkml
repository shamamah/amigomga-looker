view: claim_transaction_type {
 sql_table_name:claimtransactiontype;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }


    dimension: claimtransactiontype_id {
      type: number
      primary_key: yes
      sql: ${TABLE}.claimtransactiontype_id ;;
    }

    dimension: claimtransactioncategory_id {
      type: number
      sql: ${TABLE}.claimtransactioncategory_id ;;
    }

    dimension: dscr {
      type: string
      sql: ${TABLE}.dscr ;;
    }

    dimension: dscr2 {
      type: string
      sql: ${TABLE}.dscr2 ;;
    }

    dimension: does_payment_type_apply {
      type: string
      sql: ${TABLE}.does_payment_type_apply ;;
    }

    dimension: does_recovery_type_apply {
      type: string
      sql: ${TABLE}.does_recovery_type_apply ;;
    }

    dimension: claimtransactionpayeerequired_id {
      type: number
      sql: ${TABLE}.claimtransactionpayeerequired_id ;;
    }

    dimension: show_target {
      type: string
      sql: ${TABLE}.show_target ;;
    }

    dimension: show_deduct {
      type: string
      sql: ${TABLE}.show_deduct ;;
    }

    dimension: claimtransactionpttoorequired_id {
      type: number
      sql: ${TABLE}.claimtransactionpttoorequired_id ;;
    }

    dimension: is_payment {
      type: string
      sql: ${TABLE}.is_payment ;;
    }

    dimension: allow_record_only {
      type: string
      sql: ${TABLE}.allow_record_only ;;
    }

    dimension: adjust_indemnity_reserve {
      type: number
      sql: ${TABLE}.adjust_indemnity_reserve ;;
    }

    dimension: adjust_indemnity_paid {
      type: number
      sql: ${TABLE}.adjust_indemnity_paid ;;
    }

    dimension: adjust_alae_reserve {
      type: number
      sql: ${TABLE}.adjust_alae_reserve ;;
    }

    dimension: adjust_alae_paid {
      type: number
      sql: ${TABLE}.adjust_alae_paid ;;
    }

    dimension: adjust_expense_reserve {
      type: number
      sql: ${TABLE}.adjust_expense_reserve ;;
    }

    dimension: adjust_expense_paid {
      type: number
      sql: ${TABLE}.adjust_expense_paid ;;
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

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension: view_only {
      type: string
      sql: ${TABLE}.view_only ;;
    }

    dimension: adjust_deductible {
      type: number
      sql: ${TABLE}.adjust_deductible ;;
    }

    dimension: deduct_reimbursement {
      type: string
      sql: ${TABLE}.deduct_reimbursement ;;
    }

    dimension: allow_auto_assigned_payee {
      type: string
      sql: ${TABLE}.allow_auto_assigned_payee ;;
    }

    dimension: statsclaimtransactiontype_id {
      type: number
      sql: ${TABLE}.statsclaimtransactiontype_id ;;
    }

    dimension: require_manual {
      type: string
      sql: ${TABLE}.require_manual ;;
    }

    dimension: exclude_from_limit_validation {
      type: string
      sql: ${TABLE}.exclude_from_limit_validation ;;
    }

    dimension: adjust_financials {
      type: string
      sql: ${TABLE}.adjust_financials ;;
    }

    dimension: report_payment {
      type: string
      sql: ${TABLE}.report_payment ;;
    }

    dimension: report_cash {
      type: string
      sql: ${TABLE}.report_cash ;;
    }

    dimension_group: last_modified_date {
      type: time
      sql: ${TABLE}.last_modified_date ;;
    }

    dimension: disable_manual {
      type: string
      sql: ${TABLE}.disable_manual ;;
    }

    dimension: allow_deny {
      type: string
      sql: ${TABLE}.allow_deny ;;
    }

    dimension: show_coinsurance {
      type: string
      sql: ${TABLE}.show_coinsurance ;;
    }

    dimension: show_mailing_instructions {
      type: string
      sql: ${TABLE}.show_mailing_instructions ;;
    }

    dimension: void_offset_indicator {
      type: string
      sql: ${TABLE}.void_offset_indicator ;;
    }

    set: detail {
      fields: [
        claimtransactiontype_id,
        claimtransactioncategory_id,
        dscr,
        dscr2,
        does_payment_type_apply,
        does_recovery_type_apply,
        claimtransactionpayeerequired_id,
        show_target,
        show_deduct,
        claimtransactionpttoorequired_id,
        is_payment,
        allow_record_only,
        adjust_indemnity_reserve,
        adjust_indemnity_paid,
        adjust_alae_reserve,
        adjust_alae_paid,
        adjust_expense_reserve,
        adjust_expense_paid,
        adjust_expense_recovery,
        adjust_ant_expense_recovery,
        adjust_ant_salvage,
        adjust_salvage,
        adjust_ant_subro,
        adjust_subro,
        adjust_ant_other_recovery,
        adjust_other_recovery,
        added_date,
        pcadded_date_time,
        view_only,
        adjust_deductible,
        deduct_reimbursement,
        allow_auto_assigned_payee,
        statsclaimtransactiontype_id,
        require_manual,
        exclude_from_limit_validation,
        adjust_financials,
        report_payment,
        report_cash,
        last_modified_date_time,
        disable_manual,
        allow_deny,
        show_coinsurance,
        show_mailing_instructions,
        void_offset_indicator
      ]
    }
  }

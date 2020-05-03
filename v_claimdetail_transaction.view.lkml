view: v_claimdetail_transaction {
  sql_table_name: vclaimdetail_transaction;;


    measure: count {
      type: count
      drill_fields: [detail*]
    }

    measure: feature_amount {
      type:  sum
      sql: CASE WHEN ${TABLE}.cat_dscr <> 'Loss Reserve Change'
          AND ${TABLE}.is_offset_payment = 1 THEN -${TABLE}.Amount
            ELSE ${TABLE}.Amount END;;
      value_format_name: usd
    }

    #Need to calculate this separately to SUBTRACT for true Loss Reserve
    measure: loss_payment_amount {
      type:  sum
      hidden: yes
      sql: CASE WHEN ${TABLE}.cat_dscr = 'Loss Payment' AND
        ${TABLE}.is_offset_payment = 1 THEN -${TABLE}.Amount
        ELSE ${TABLE}.Amount END;;
      value_format_name: usd
    }

    dimension: compound_primary_key {
      type: string
      primary_key: yes
      hidden: yes
      sql: CONCAT(${claimcontrol_id},${claimant_num},${claimfeature_num}) ;;
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

    dimension: cat_dscr {
      type: string
      sql: ${TABLE}.cat_dscr ;;
    }

    dimension: claimtransactioncategory_id {
      type: number
      sql: ${TABLE}.claimtransactioncategory_id ;;
    }

    dimension: claimtransactiontype_id {
      type: number
      sql: ${TABLE}.claimtransactiontype_id ;;
    }

    dimension: type_dscr {
      type: string
      sql: ${TABLE}.type_dscr ;;
    }

    dimension_group: eff_date {
      type: time
      sql: ${TABLE}.eff_date ;;
    }

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
    }

    dimension: amount {
      type: string
      sql: ${TABLE}.amount ;;
    }

    dimension: reserve {
      type: string
      sql: ${TABLE}.reserve ;;
    }

    dimension: remark {
      type: string
      sql: ${TABLE}.remark ;;
    }

    dimension: user_name {
      type: string
      sql: ${TABLE}.user_name ;;
    }

    dimension: approvedby_user_name {
      type: string
      sql: ${TABLE}.approvedby_user_name ;;
    }

    dimension: claimtransactionstatus_id {
      type: number
      sql: ${TABLE}.claimtransactionstatus_id ;;
    }

    dimension: status {
      type: string
      sql: ${TABLE}.status ;;
    }

    dimension: pay_type {
      type: string
      sql: ${TABLE}.pay_type ;;
    }


    dimension: claimstoppmt_id {
      type: number
      sql: ${TABLE}.claimstoppmt_id ;;
    }

    dimension_group: reconcile_date {
      type: time
      sql: ${TABLE}.reconcile_date ;;
    }

    dimension: claimtransactionsplit_num {
      type: number
      sql: ${TABLE}.claimtransactionsplit_num ;;
    }

    dimension: bulk_check {
      type: string
      sql: ${TABLE}.bulk_check ;;
    }

    dimension: checkstatus_id {
      type: number
      sql: ${TABLE}.checkstatus_id ;;
    }

    dimension: view_only {
      type: string
      sql: ${TABLE}.view_only ;;
    }

    dimension: pay_to_the_order_of {
      type: string
      sql: ${TABLE}.pay_to_the_order_of ;;
    }

    dimension: user_code {
      type: string
      sql: ${TABLE}.user_code ;;
    }

    dimension_group: clearedbank_date {
      type: time
      sql: ${TABLE}.clearedbank_date ;;
    }

    dimension: claimscheduledpaymentcycle_id {
      type: number
      sql: ${TABLE}.claimscheduledpaymentcycle_id ;;
    }

    dimension: reissued {
      type: string
      sql: ${TABLE}.reissued ;;
    }

    dimension: check_number {
      type: string
      sql: ${TABLE}.check_number ;;
    }

    dimension_group: check_date {
      type: time
      sql: ${TABLE}.check_date ;;
    }

    dimension: is_offset_payment {
      type: number
      sql: ${TABLE}.is_offset_payment ;;
    }

    dimension_group: print_date {
      type: time
      sql: ${TABLE}.print_date ;;
    }

    dimension_group: export_date {
      type: time
      sql: ${TABLE}.export_date ;;
    }

    dimension: claimstoppmtstatus_id {
      type: number
      sql: ${TABLE}.claimstoppmtstatus_id ;;
    }

    set: detail {
      fields: [
        claimcontrol_id,
        claimant_num,
        claimfeature_num,
        claimtransaction_num,
        cat_dscr,
        claimtransactioncategory_id,
        claimtransactiontype_id,
        type_dscr,
        eff_date_time,
        added_date,
        amount,
        reserve,
        remark,
        user_name,
        approvedby_user_name,
        claimtransactionstatus_id,
        status,
        pay_type,
        claimstoppmt_id,
        reconcile_date_time,
        claimtransactionsplit_num,
        bulk_check,
        checkstatus_id,
        view_only,
        pay_to_the_order_of,
        user_code,
        clearedbank_date_time,
        claimscheduledpaymentcycle_id,
        reissued,
        check_number,
        check_date_time,
        is_offset_payment,
        print_date_time,
        export_date_time,
        claimstoppmtstatus_id
      ]
    }
  }

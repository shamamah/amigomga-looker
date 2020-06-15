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

    dimension: claimtransaction_num {
      type: number
      hidden: yes
      sql: ${TABLE}.claimtransaction_num ;;
    }

    dimension: cat_dscr {
      type: string
      hidden: yes
      sql: ${TABLE}.cat_dscr ;;
    }

    dimension: claimtransactioncategory_id {
      type: number
      hidden: yes
      sql: ${TABLE}.claimtransactioncategory_id ;;
    }

    dimension: claimtransactiontype_id {
      type: number
      hidden: yes
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
      hidden: yes
      sql: ${TABLE}.added_date ;;
    }


    dimension: remark {
      type: string
      hidden: yes
      sql: ${TABLE}.remark ;;
    }

    dimension: user_name {
      type: string
      hidden: yes
      sql: ${TABLE}.user_name ;;
    }

    dimension: approvedby_user_name {
      type: string
      hidden: yes
      sql: ${TABLE}.approvedby_user_name ;;
    }

    dimension: claimtransactionstatus_id {
      type: number
      hidden: yes
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
      hidden: yes
      sql: ${TABLE}.claimstoppmt_id ;;
    }

    dimension_group: reconcile_date {
      type: time
      hidden: yes
      sql: ${TABLE}.reconcile_date ;;
    }

    dimension: claimtransactionsplit_num {
      type: number
      hidden: yes
      sql: ${TABLE}.claimtransactionsplit_num ;;
    }

    dimension: bulk_check {
      type: string
      hidden: yes
      sql: ${TABLE}.bulk_check ;;
    }

    dimension: checkstatus_id {
      type: number
      hidden: yes
      sql: ${TABLE}.checkstatus_id ;;
    }

    dimension: view_only {
      type: string
      hidden: yes
      sql: ${TABLE}.view_only ;;
    }

    dimension: pay_to_the_order_of {
      type: string
      hidden: yes
      sql: ${TABLE}.pay_to_the_order_of ;;
    }

    dimension: user_code {
      type: string
      hidden: yes
      sql: ${TABLE}.user_code ;;
    }

    dimension_group: clearedbank_date {
      type: time
      hidden: yes
      sql: ${TABLE}.clearedbank_date ;;
    }

    dimension: claimscheduledpaymentcycle_id {
      type: number
      hidden: yes
      sql: ${TABLE}.claimscheduledpaymentcycle_id ;;
    }

    dimension: reissued {
      type: string
      hidden: yes
      sql: ${TABLE}.reissued ;;
    }

    dimension: check_number {
      type: string
      hidden: yes
      sql: ${TABLE}.check_number ;;
    }

    dimension_group: check_date {
      type: time
      hidden: yes
      sql: ${TABLE}.check_date ;;
    }

    dimension: is_offset_payment {
      type: number
      hidden: yes
      sql: ${TABLE}.is_offset_payment ;;
    }

    dimension_group: print_date {
      type: time
      hidden: yes
      sql: ${TABLE}.print_date ;;
    }

    dimension_group: export_date {
      type: time
      hidden: yes
      sql: ${TABLE}.export_date ;;
    }

    dimension: claimstoppmtstatus_id {
      type: number
      hidden: yes
      sql: ${TABLE}.claimstoppmtstatus_id ;;
    }

    set: detail {
      fields: [
        cat_dscr,
        type_dscr,
        eff_date_time,
        added_date,
        remark,
        user_name,
        approvedby_user_name,
        status,
        pay_type,
        reconcile_date_time,
        claimtransactionsplit_num,
        bulk_check,
        view_only,
        pay_to_the_order_of,
        user_code,
        clearedbank_date_time,
        reissued,
        check_number,
        check_date_time,
        is_offset_payment,
        print_date_time,
        export_date_time,
      ]
    }
  }

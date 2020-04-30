view: payment_processor_payment_audit {
  sql_table_name: dbo.paymentprocessorpaymentaudit ;;


    measure: count {
      type: count
      label: "Processor Count"
      drill_fields: [detail*]
    }

    measure: amount {
      type: sum
      label: "Processor Amount"
      sql: ${TABLE}.amount ;;
    }

    dimension: paymentprocessorpaymentaudit_id {
      type: number
      hidden: yes
      sql: ${TABLE}.paymentprocessorpaymentaudit_id ;;
    }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: billingcash_num {
      type: number
      hidden: yes
      sql: ${TABLE}.billingcash_num ;;
    }

    dimension: dscr {
      type: string
      label: "Processor Msg"
      sql: ${TABLE}.dscr ;;
    }

    dimension: users_id {
      type: number
      hidden: yes
      sql: ${TABLE}.users_id ;;
    }

    dimension: paymentprocessor_id {
      type: number
      label: "Processor ID"
      sql: ${TABLE}.paymentprocessor_id ;;
    }

    dimension: added_date {
      type: date
      label: "Processor Date"
      hidden: yes
      sql: ${TABLE}.added_date ;;
    }

    dimension: vendor_transactionid {
      type: string
      hidden: yes
      sql: ${TABLE}.vendor_transactionid ;;
    }

    dimension: accountingpayqueue_id {
      type: number
      hidden: yes
      sql: ${TABLE}.accountingpayqueue_id ;;
    }

    dimension: paymentprocessortransactionstatustype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.paymentprocessortransactionstatustype_id ;;
    }

    dimension_group: pcadded_date {
      type: time
      label: "Processor Time"
      hidden: no
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension: paymenttype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.paymenttype_id ;;
    }

    dimension: response_date {
      type: date
      hidden: yes
      sql: ${TABLE}.response_date ;;
    }

    set: detail {
      fields: [
        paymentprocessorpaymentaudit_id,
        policy_id,
        billingcash_num,
        amount,
        dscr,
        users_id,
        paymentprocessor_id,
        added_date,
        vendor_transactionid,
        accountingpayqueue_id,
        paymentprocessortransactionstatustype_id,
        pcadded_date_time,
        paymenttype_id,
        response_date
      ]
    }
  }

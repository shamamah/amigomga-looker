view: agency_activity {
       sql_table_name: agencyactivity
        ;;

    dimension: agencyactivity_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencyactivity_id ;;
    }

    dimension: agency_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agency_id ;;
    }

    dimension: agencyproducer_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencyproducer_id ;;
    }

    dimension: companystatelob_id {
      type: number
      hidden: yes
      sql: ${TABLE}.companystatelob_id ;;
    }

    dimension: agencyactivitytype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencyactivitytype_id ;;
    }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      hidden: yes
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: eff_date {
      type: date
      hidden: yes
      sql: ${TABLE}.eff_date ;;
    }

    dimension: exp_date {
      type: date
      hidden: yes
      sql: ${TABLE}.exp_date ;;
    }

    dimension: reference {
      type: string
      hidden: yes
      sql: ${TABLE}.reference ;;
    }

    dimension: description {
      type: string
      sql: ${TABLE}.description ;;
    }

    dimension: billmethod_id {
      type: number
      hidden: yes
      sql: ${TABLE}.billmethod_id ;;
    }

    dimension_group: accounting_date {
      type: time
      hidden: yes
      sql: ${TABLE}.accounting_date ;;
    }

    dimension: amount {
      type: string
      hidden: yes
      sql: ${TABLE}.amount ;;
    }

    dimension: rate {
      type: string
      hidden: yes
      sql: ${TABLE}.rate ;;
    }

    measure: commission {
      type: sum
      sql: ${TABLE}.commission ;;
    }

    dimension: amount_due {
      type: string
      hidden: yes
      sql: ${TABLE}.amount_due ;;
    }

    dimension: amount_paid {
      type: string
      hidden: yes
      sql: ${TABLE}.amount_paid ;;
    }

    dimension: balance {
      type: string
      hidden: yes
      sql: ${TABLE}.balance ;;
    }

    dimension: users_id {
      type: number
      hidden: yes
      sql: ${TABLE}.users_id ;;
    }

    dimension: checkitem_id {
      type: number
      hidden: yes
      sql: ${TABLE}.checkitem_id ;;
    }

    dimension: billingcashinsource_id {
      type: number
      hidden: yes
      sql: ${TABLE}.billingcashinsource_id ;;
    }

    dimension_group: check_date {
      type: time
      hidden: yes
      sql: ${TABLE}.check_date ;;
    }

    dimension: cleared {
      type: string
      hidden: yes
      sql: ${TABLE}.cleared ;;
    }

    dimension_group: clear_date {
      type: time
      hidden: yes
      sql: ${TABLE}.clear_date ;;
    }

    dimension: policy_number {
      type: string
      hidden: yes
      sql: ${TABLE}.policy_number ;;
    }

    dimension: generated {
      type: string
      hidden: yes
      sql: ${TABLE}.generated ;;
    }

    dimension: adjust_agencyactivity_id {
      type: number
      hidden: yes
      sql: ${TABLE}.adjust_agencyactivity_id ;;
    }

    dimension_group: last_modified_date {
      type: time
      hidden: yes
      sql: ${TABLE}.last_modified_date ;;
    }

    dimension: agencybilladjustmentreasontype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencybilladjustmentreasontype_id ;;
    }

    dimension: agencybilladjustmenttype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencybilladjustmenttype_id ;;
    }

    dimension_group: appliedtoagencybillstatementdate {
      type: time
      hidden: yes
      sql: ${TABLE}.appliedtoagencybillstatementdate ;;
    }

    dimension: agencycommission_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencycommission_id ;;
    }

    dimension: accountingbatch_id {
      type: number
      hidden: yes
      sql: ${TABLE}.accountingbatch_id ;;
    }

    dimension: agencycommissiondetailtype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agencycommissiondetailtype_id ;;
    }

    dimension: billingaccount_id {
      type: number
      hidden: yes
      sql: ${TABLE}.billingaccount_id ;;
    }

    dimension: client_id {
      type: number
      hidden: yes
      sql: ${TABLE}.client_id ;;
    }

    dimension: agency_of_record_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agency_of_record_id ;;
    }

    dimension: hide_from_display_flag {
      type: string
      hidden: yes
      sql: ${TABLE}.hide_from_display_flag ;;
    }

    dimension: display_balance {
      type: string
      hidden: yes
      sql: ${TABLE}.display_balance ;;
    }

    dimension: display_amount {
      type: string
      hidden: yes
      sql: ${TABLE}.display_amount ;;
    }

    set: detail {
      fields: [
        agencyactivity_id,
        agency_id,
        agencyproducer_id,
        companystatelob_id,
        agencyactivitytype_id,
        policy_id,
        policyimage_num,
        eff_date,
        exp_date,
        reference,
        description,
        billmethod_id,
        accounting_date_time,
        amount,
        rate,
        commission,
        amount_due,
        amount_paid,
        balance,
        users_id,
        checkitem_id,
        billingcashinsource_id,
        check_date_time,
        cleared,
        clear_date_time,
        policy_number,
        generated,
        adjust_agencyactivity_id,
        last_modified_date_time,
        agencybilladjustmentreasontype_id,
        agencybilladjustmenttype_id,
        appliedtoagencybillstatementdate_time,
        agencycommission_id,
        accountingbatch_id,
        agencycommissiondetailtype_id,
        billingaccount_id,
        client_id,
        agency_of_record_id,
        hide_from_display_flag,
        display_balance,
        display_amount
      ]
    }
  }

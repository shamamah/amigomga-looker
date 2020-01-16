view: billing_charge_credit {
  sql_table_name: dbo.BillingChargeCredit ;;

  dimension_group: added {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: addedwith_policyimage_num {
    type: number
    sql: ${TABLE}.addedwith_policyimage_num ;;
  }

  dimension: adjust_num {
    type: number
    sql: ${TABLE}.adjust_num ;;
  }

  dimension: amount {
    type: string
    sql: ${TABLE}.amount ;;
  }

  dimension: billingaccountinvoice_id {
    type: number
    sql: ${TABLE}.billingaccountinvoice_id ;;
  }

  dimension: billingaccountinvoice_num {
    type: number
    sql: ${TABLE}.billingaccountinvoice_num ;;
  }

  dimension: billingactivityorder {
    type: number
    sql: ${TABLE}.billingactivityorder ;;
  }

  dimension: billingchargecredit_num {
    type: number
    sql: ${TABLE}.billingchargecredit_num ;;
  }

  dimension: billingchargescreditstype_id {
    type: number
    sql: ${TABLE}.billingchargescreditstype_id ;;
  }

  dimension: billinggrouping_num {
    type: number
    sql: ${TABLE}.billinggrouping_num ;;
  }

  dimension: billinggroupingreason_id {
    type: number
    sql: ${TABLE}.billinggroupingreason_id ;;
  }

  dimension: billingreason_id {
    type: number
    sql: ${TABLE}.billingreason_id ;;
  }

  dimension_group: due {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.due_date ;;
  }

  dimension_group: export {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.export_date ;;
  }

  dimension: exported_to_payrolldeduction_file {
    type: string
    sql: ${TABLE}.exported_to_payrolldeduction_file ;;
  }

  dimension: exportstatus_id {
    type: number
    sql: ${TABLE}.exportstatus_id ;;
  }

  dimension: flatfee {
    type: string
    sql: ${TABLE}.flatfee ;;
  }

  dimension: initinstall {
    type: string
    sql: ${TABLE}.initinstall ;;
  }

  dimension: is_premium_audit_installment {
    type: string
    sql: ${TABLE}.is_premium_audit_installment ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension: manual_service_charge {
    type: string
    sql: ${TABLE}.manual_service_charge ;;
  }

  dimension: packagepart_num {
    type: number
    sql: ${TABLE}.packagepart_num ;;
  }

  dimension_group: pcadded {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: perinstall {
    type: string
    sql: ${TABLE}.perinstall ;;
  }

  dimension: policy_id {
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: printprocess_id {
    type: number
    sql: ${TABLE}.printprocess_id ;;
  }

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: spread {
    type: string
    sql: ${TABLE}.spread ;;
  }

  dimension: spread_num {
    type: number
    sql: ${TABLE}.spread_num ;;
  }

  dimension: staticfee {
    type: string
    sql: ${TABLE}.staticfee ;;
  }

  dimension: unapplied_amount {
    type: string
    sql: ${TABLE}.unapplied_amount ;;
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.users_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

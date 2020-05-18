view: billing_charge_credit {
  sql_table_name: dbo.BillingChargeCredit ;;

  dimension_group: added {
    type: time
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.addedwith_policyimage_num ;;
  }

  dimension: adjust_num {
    type: number
    hidden: yes
    sql: ${TABLE}.adjust_num ;;
  }

  measure: amount {
    label: "Charge Amount"
    type: sum
    sql: ${TABLE}.amount ;;
  }

  dimension: billingaccountinvoice_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billingaccountinvoice_id ;;
  }

  dimension: billingaccountinvoice_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billingaccountinvoice_num ;;
  }

  dimension: billingactivityorder {
    type: number
    hidden: yes
    sql: ${TABLE}.billingactivityorder ;;
  }

  dimension: billingchargecredit_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billingchargecredit_num ;;
  }

  dimension: billingchargescreditstype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billingchargescreditstype_id ;;
  }

  dimension: billinggrouping_num {
    type: number
    hidden: yes
    sql: ${TABLE}.billinggrouping_num ;;
  }

  dimension: billinggroupingreason_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billinggroupingreason_id ;;
  }

  dimension: billingreason_id {
    type: number
    sql: ${TABLE}.billingreason_id ;;
  }

  dimension_group: due {
    type: time
    hidden: yes
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
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.exported_to_payrolldeduction_file ;;
  }

  dimension: exportstatus_id {
    type: number
    hidden: yes
    sql: ${TABLE}.exportstatus_id ;;
  }

  dimension: flatfee {
    type: string
    hidden: yes
    sql: ${TABLE}.flatfee ;;
  }

  dimension: initinstall {
    type: string
    hidden: yes
    sql: ${TABLE}.initinstall ;;
  }

  dimension: is_premium_audit_installment {
    type: string
    hidden: yes
    sql: ${TABLE}.is_premium_audit_installment ;;
  }

  dimension_group: last_modified {
    type: time
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.manual_service_charge ;;
  }

  dimension: packagepart_num {
    type: number
    hidden: yes
    sql: ${TABLE}.packagepart_num ;;
  }

  dimension_group: pcadded {
    type: time
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}.perinstall ;;
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

  dimension: printprocess_id {
    type: number
    hidden: yes
    sql: ${TABLE}.printprocess_id ;;
  }

  dimension: renewal_ver {
    type: number
    hidden: yes
    sql: ${TABLE}.renewal_ver ;;
  }

  dimension: spread {
    type: string
    hidden: yes
    sql: ${TABLE}.spread ;;
  }

  dimension: spread_num {
    type: number
    hidden: yes
    sql: ${TABLE}.spread_num ;;
  }

  dimension: staticfee {
    type: string
    hidden: yes
    sql: ${TABLE}.staticfee ;;
  }

  measure: unapplied_amount {
    type: sum
    sql: ${TABLE}.unapplied_amount ;;
  }

  dimension: users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }

}

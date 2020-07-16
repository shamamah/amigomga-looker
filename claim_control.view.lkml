view: claim_control {
  sql_table_name: dbo.ClaimControl ;;

  dimension_group: added {
    label: "Processed"
    hidden: yes
    type: time
    timeframes: [date]
    convert_tz: no
    sql: ${TABLE}.added_date ;;
  }

  dimension: claim_number {
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Claim/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
    type: string
    label: "Number"
    sql: ${TABLE}.claim_number ;;
  }

  dimension: claim_type_id {
    label: "Is Record-Only"
    type: string
    sql: CASE WHEN  ${TABLE}.claim_type_id=3 THEN 'Yes' ELSE 'No' END ;;
  }

  dimension: claimcatastrophe_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcatastrophe_id ;;
  }

  dimension: claimclosereason_id {
    label: "Close Reason Code"
    type: number
    sql: case when ISNULL(${TABLE}.claimclosereason_id,-1)>=0 then ${TABLE}.claimclosereason_id else NULL end  ;;
  }

  dimension: claimcluedisp_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcluedisp_id ;;
  }

  dimension: claimcontrol_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimcontrolstatus_id {
    label: "Status Code"
    type: number
    hidden: no
    sql: ${TABLE}.claimcontrolstatus_id ;;
  }

  dimension: claimfault_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimfault_id ;;
  }

  dimension: claimfinancials_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimfinancials_num ;;
  }

  dimension: claimlnimage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimlnimage_num ;;
  }

  dimension: claimlnmaster_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimlnmaster_id ;;
  }

  dimension: claimlosstype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimlosstype_id ;;
  }

  dimension: claimoffice_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimoffice_id ;;
  }

  dimension: claimreportedby_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimreportedby_id ;;
  }

  dimension: claimreportedbymethod_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimreportedbymethod_id ;;
  }

  dimension: claimseverity_id {
    label: "Severity Code"
    type: number
    hidden: no
    sql: ${TABLE}.claimseverity_id ;;
  }

  dimension: dscr {
    type: string
    label: "Loss Description"
    sql: ${TABLE}.dscr ;;
  }

  dimension_group: last_modified {
    # USED for WaterStreet data delivery
    hidden: no
    type: time
    timeframes: [date]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: loss_date {
    type: time
    label: "Loss Date"
    timeframes: [date,week,quarter,year,month]
    sql: ${TABLE}.loss_date ;;
  }

  dimension: police_notified {
    type: string
    label: "Is Police Notified"
    sql: CASE WHEN ${TABLE}.police_notified=1  THEN 'Yes' ELSE 'No' END ;;
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

  dimension_group: reported_date {
    type: time
    label: "Reported Date"
    timeframes: [date,month,quarter,year,day_of_week,hour_of_day]
    sql: ${TABLE}.reported_date ;;
  }

  measure: count {
    label: "Claim Count"
    type: count
    drill_fields: [claim_stat*]
    link: {
      label: "Sort by Claim Number"
      url: "{{ link }}&sorts=claim_control.claim_number"
    }
    link: {
      label: "Sort by Date Reported"
      url: "{{ link }}&sorts=claim_control.reported_date_date"
    }
    link: {
      label: "Sort by Loss Paid"
      url: "{{ link }}&sorts=v_claim_detail_feature.sum_indemnity_paid"
    }
    link: {
      label: "Sort by Reserve Amount"
      url: "{{ link }}&sorts=v_claim_detail_feature.sum_indemnity_reserve"
    }
    link: {
      label: "Sort by CAT Code"
      url: "{{ link }}&sorts=claim_catastrophe.user_code"
    }
  }

  set: claim_stat {
    fields: [
      claim_control.claim_number,
      policy.current_policy,
      claim_control_status.dscr,
      claim_loss_type.dscr,
      #claim_catastrophe.user_code,
      claim_type.dscr,
      claim_severity.dscr,
      claim_control.loss_date_date,
      claim_control.reported_date_date,
      dt_claim_days_open.days_open,
      dt_claim_close_date.claim_close_date_date,
      #dt_claim_inside_adjuster.initials,
      #dt_claim_supervisor.supervisor_initials,
      v_claim_detail_feature.sum_indemnity_paid,
      v_claim_detail_feature.sum_indemnity_reserve,
      v_claim_detail_feature.sum_expense_paid
    ]
  }
}

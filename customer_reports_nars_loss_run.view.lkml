view: customer_reports_nars_loss_run {
  sql_table_name: customer_reports.dbo.NARSLossRun;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: reporting_date {
    type: date
    hidden: yes
    sql: ${TABLE}.ReportingDate ;;
  }

  dimension: program_name {
    type: string
    hidden: yes
    sql: ${TABLE}.ProgramName ;;
  }

  dimension: agency {
    type: string
    hidden: yes
    sql: ${TABLE}.Agency ;;
  }

  dimension: insured {
    type: string
    hidden: yes
    sql: ${TABLE}.Insured ;;
  }

  dimension: insured_state {
    type: string
    hidden: yes
    sql: ${TABLE}.InsuredState ;;
  }

  dimension: driver {
    type: string
    hidden: yes
    sql: ${TABLE}.Driver ;;
  }

  dimension: vehicle_make {
    type: string
    hidden: yes
    sql: ${TABLE}.VehicleMake ;;
  }

  dimension: vehicle_model {
    type: string
    hidden: yes
    sql: ${TABLE}.VehicleModel ;;
  }

  dimension: policy_number {
    type: string
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
    sql: ${TABLE}.PolicyNumber ;;
  }

  dimension: pol_eff_date {
    type: date
    hidden: yes
    sql: ${TABLE}.PolEffDate ;;
  }

  dimension: pol_exp_date {
    type: date
    hidden: yes
    sql: ${TABLE}.PolExpDate ;;
  }

  dimension: pol_cancel_date {
    type: date
    hidden: yes
    sql: ${TABLE}.PolCancelDate ;;
  }

  dimension: reserve_num {
    type: number
    hidden: yes
    sql: ${TABLE}.ReserveNum ;;
  }

  dimension: reserve_status {
    type: string
    hidden: yes
    sql: ${TABLE}.ReserveStatus ;;
  }

  dimension: claim_number {
    type: string
    sql: ${TABLE}.ClaimNumber ;;
  }

  dimension: claim_type {
    type: string
    hidden: yes
    sql: ${TABLE}.ClaimType ;;
  }

  dimension: is_denied {
    type: string
    hidden: yes
    sql: ${TABLE}.IsDenied ;;
  }

  dimension: is_contested {
    type: string
    hidden: yes
    sql: ${TABLE}.IsContested ;;
  }

  dimension: litigation {
    type: string
    hidden: yes
    sql: ${TABLE}.Litigation ;;
  }

  dimension: loss_date {
    type: date
    sql: ${TABLE}.LossDate ;;
  }

  dimension: accident_desr {
    type: string
    hidden: yes
    sql: ${TABLE}.AccidentDesr ;;
  }

  dimension: loss_type {
    type: string
    sql: ${TABLE}.LossType ;;
  }

  dimension: acc_location {
    type: string
    hidden: yes
    sql: ${TABLE}.AccLocation ;;
  }

  dimension: acc_city {
    type: string
    sql: ${TABLE}.AccCity ;;
  }

  dimension: acc_county {
    type: string
    hidden: yes
    sql: ${TABLE}.AccCounty ;;
  }

  dimension: acc_state {
    type: string
    hidden: yes
    sql: ${TABLE}.AccState ;;
  }

  dimension: feature_status {
    type: string
    sql: ${TABLE}.FeatureStatus ;;
  }

  dimension: coverage_code {
    type: string
    hidden: yes
    sql: ${TABLE}.CoverageCode ;;
  }

  dimension: coverage {
    type: string
    sql: ${TABLE}.Coverage ;;
  }

  dimension: claimant_name {
    type: string
    sql: ${TABLE}.ClaimantName ;;
  }

  dimension: adjuster {
    type: string
    sql: ${TABLE}.Adjuster ;;
  }

  dimension: supervisor {
    type: string
    sql: ${TABLE}.Supervisor ;;
  }

  dimension: days_reserve_open {
    type: number
    sql: ${TABLE}.DaysReserveOpen ;;
  }

  measure: indemnity_paid {
    type: sum
    sql: ${TABLE}.IndemnityPaid ;;
  }

  measure: expense_paid {
    type: sum
    sql: ${TABLE}.ExpensePaid ;;
  }

  measure: legal_paid {
    type: sum
    hidden: yes
    sql: ${TABLE}.LegalPaid ;;
  }

  measure: dccpaid {
    type: sum
    hidden: yes
    sql: ${TABLE}.DCCPaid ;;
  }

  measure: alaepaid {
    type: sum
    sql: ${TABLE}.ALAEPaid ;;
  }

  measure: ulaepaid {
    type: sum
    hidden: yes
    sql: ${TABLE}.ULAEPaid ;;
  }

  measure: aoepaid {
    type: sum
    hidden: yes
    sql: ${TABLE}.AOEPaid ;;
  }

  measure: indemnity_reserve {
    type: sum
    sql: ${TABLE}.IndemnityReserve ;;
  }

  measure: expense_reserve {
    type: sum
    hidden: yes
    sql: ${TABLE}.ExpenseReserve ;;
  }

  measure: legal_reserve {
    type: sum
    hidden: yes
    sql: ${TABLE}.LegalReserve ;;
  }

  dimension: alaereserve {
    type: string
    hidden: yes
    sql: ${TABLE}.ALAEReserve ;;
  }

  dimension: dccreserve {
    type: string
    hidden: yes
    sql: ${TABLE}.DCCReserve ;;
  }

  dimension: ulaereserve {
    type: string
    hidden: yes
    sql: ${TABLE}.ULAEReserve ;;
  }

  dimension: aoereserve {
    type: string
    hidden: yes
    sql: ${TABLE}.AOEReserve ;;
  }

  dimension: gross_incurred {
    type: string
    hidden: yes
    sql: ${TABLE}.GrossIncurred ;;
  }

  dimension: total_recoveries {
    type: string
    hidden: yes
    sql: ${TABLE}.TotalRecoveries ;;
  }

  measure: subro {
    type: sum
    sql: ${TABLE}.Subro ;;
  }

  measure: salvage {
    type: sum
    sql: ${TABLE}.Salvage ;;
  }

  dimension: deductible_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.DeductibleRecovery ;;
  }

  dimension: other_recovery {
    type: string
    hidden: yes
    sql: ${TABLE}.OtherRecovery ;;
  }

  dimension: net_incurred {
    type: string
    hidden: yes
    sql: ${TABLE}.NetIncurred ;;
  }

  dimension: reported_date {
    type: date
    sql: ${TABLE}.ReportedDate ;;
  }

  dimension: lag_time {
    type: number
    sql: ${TABLE}.LagTime ;;
  }

  dimension: feature_open_date {
    type: date
    sql: ${TABLE}.FeatureOpenDate ;;
  }

  dimension: feature_closed_date {
    type: date
    sql: ${TABLE}.FeatureClosedDate ;;
  }

  dimension: feature_reopen_date {
    type: date
    sql: ${TABLE}.FeatureReopenDate ;;
  }

  set: detail {
    fields: [
      id,
      reporting_date,
      program_name,
      agency,
      insured,
      insured_state,
      driver,
      vehicle_make,
      vehicle_model,
      policy_number,
      pol_eff_date,
      pol_exp_date,
      pol_cancel_date,
      reserve_num,
      reserve_status,
      claim_number,
      claim_type,
      is_denied,
      is_contested,
      litigation,
      loss_date,
      accident_desr,
      loss_type,
      acc_location,
      acc_city,
      acc_county,
      acc_state,
      feature_status,
      coverage_code,
      coverage,
      claimant_name,
      adjuster,
      supervisor,
      days_reserve_open,
      indemnity_paid,
      expense_paid,
      legal_paid,
      dccpaid,
      alaepaid,
      ulaepaid,
      aoepaid,
      indemnity_reserve,
      expense_reserve,
      legal_reserve,
      alaereserve,
      dccreserve,
      ulaereserve,
      aoereserve,
      gross_incurred,
      total_recoveries,
      subro,
      salvage,
      deductible_recovery,
      other_recovery,
      net_incurred,
      reported_date,
      lag_time,
      feature_open_date,
      feature_closed_date,
      feature_reopen_date
    ]
  }
}

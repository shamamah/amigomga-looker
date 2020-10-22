view: claim_feature {
  sql_table_name: dbo.claimfeature
      ;;

  measure: count {
    type: count_distinct
    sql: CONCAT(${TABLE}.claimcontrol_id, ' ', ${TABLE}.claimant_num, ' ', ${TABLE}.claimfeature_num) ;;
    drill_fields: [detail*]
  }

  dimension: claimcontrol_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: primary_key {
    type:  string
    primary_key: yes
    sql:  CONCAT(${TABLE}.claimcontrol_id, ' ', ${TABLE}.claimant_num, ' ', ${TABLE}.claimfeature_num) ;;
  }
  dimension: claimexposure_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimexposure_id ;;
  }

  dimension: claimsubexposure_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimsubexposure_num ;;
  }

  dimension: claimcoverage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcoverage_num ;;
  }

  dimension: claimsubcoverage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimsubcoverage_num ;;
  }

  dimension_group: reported_date {
    type: time
    sql: ${TABLE}.reported_date ;;
  }


  dimension: dscr {
    type: string
    label: "Description"
    sql: ${TABLE}.dscr ;;
  }

    dimension: perperson_limit {
    type: string
    sql: ${TABLE}.perperson_limit ;;
  }

  dimension: peroccur_limit {
    type: string
    sql: ${TABLE}.peroccur_limit ;;
  }

  dimension: deductible {
    type: string
    sql: ${TABLE}.deductible ;;
  }

  dimension: exposure_dscr {
    type: string
    sql: ${TABLE}.exposure_dscr ;;
  }

  dimension: subexposure_dscr {
    type: string
    sql: ${TABLE}.subexposure_dscr ;;
  }

  dimension: coverage_dscr {
    type: string
    sql: ${TABLE}.coverage_dscr ;;
  }

  dimension: subcoverage_dscr {
    type: string
    sql: ${TABLE}.subcoverage_dscr ;;
  }

  dimension: inside_adjuster_id {
    type: number
    sql: ${TABLE}.inside_adjuster_id ;;
  }

  dimension: outside_adjuster_id {
    type: number
    sql: ${TABLE}.outside_adjuster_id ;;
  }

  dimension: in_litigation {
    type: string
    hidden: yes
    sql: ${TABLE}.in_litigation ;;
  }

  dimension: in_suit {
    type: string
    hidden: yes
    sql: ${TABLE}.in_suit ;;
  }

  dimension: in_salvage {
    type: string
    sql: ${TABLE}.in_salvage ;;
  }

  dimension: zero_tort {
    type: string
    sql: ${TABLE}.zero_tort ;;
  }

  dimension: record_only {
    type: string
    sql: ${TABLE}.record_only ;;
  }

  dimension: tort_id {
    type: number
    hidden: yes
    sql: ${TABLE}.tort_id ;;
  }

  dimension: users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }

  dimension_group: added_date {
    type: time
    sql: ${TABLE}.added_date ;;
  }

  dimension_group: clue_date {
    type: time
    sql: ${TABLE}.clue_date ;;
  }

  dimension: reopened {
    type: string
    sql: ${TABLE}.reopened ;;
  }

  dimension_group: reopened_date {
    type: time
    sql: ${TABLE}.reopened_date ;;
  }


  dimension: claimfeaturestatus_id {
    type: number
    sql: ${TABLE}.claimfeaturestatus_id ;;
  }

  dimension: claimfinancials_num {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfinancials_num ;;
  }


  dimension_group: pcadded_date {
    type: time
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: deductible_waived {
    type: string
    sql: ${TABLE}.deductible_waived ;;
  }


  dimension: claimoffice_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimoffice_id ;;
  }


  dimension: coverage_limitations {
    type: string
    sql: ${TABLE}.coverage_limitations ;;
  }

  dimension_group: statute_of_limitations_date {
    type: time
    sql: ${TABLE}.statute_of_limitations_date ;;
  }

  dimension: waive_iso_reporting {
    type: string
    sql: ${TABLE}.waive_iso_reporting ;;
  }

  dimension: corvel_approved_amount {
    type: string
    sql: ${TABLE}.corvel_approved_amount ;;
  }

  dimension: exclude_from_medical {
    type: string
    sql: ${TABLE}.exclude_from_medical ;;
  }

  dimension: attorney_involved_date {
    type: date
    hidden: yes
    sql: ${TABLE}.attorney_involved_date ;;
  }

  dimension: attorney_rep {
    label: "Atty Rep"
    type: string
    sql: CASE WHEN ${TABLE}.attorney_involved_date = '1800-01-01' or
            ${TABLE}.attorney_involved_date is NULL THEN 'No' ELSE 'Yes' END;;
  }

  dimension_group: claimdenial_date {
    type: time
    sql: ${TABLE}.claimdenial_date ;;
  }

  dimension: denied {
    type: string
    sql: ${TABLE}.denied ;;
  }

  dimension: claimdenialreason_remarks {
    type: string
    sql: ${TABLE}.claimdenialreason_remarks ;;
  }

  dimension: claimdenialusers_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimdenialusers_id ;;
  }

  dimension: claimdenialreason_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimdenialreason_id ;;
  }

  dimension: deductible_available_amount {
    type: string
    hidden: yes
    sql: ${TABLE}.deductible_available_amount ;;
  }

  dimension: deductible_applied_amount {
    type: string
    hidden: yes
    sql: ${TABLE}.deductible_applied_amount ;;
  }

  dimension: in_litigation_yesno_id {
    type: number
    hidden: yes
    sql: ${TABLE}.in_litigation_yesno_id ;;
  }

  dimension: claimfeatureclosereason_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimfeatureclosereason_id ;;
  }

  dimension: claimsubropotentialtype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimsubropotentialtype_id ;;
  }

  dimension: is_early_settlement_opportunity {
    type: string
    hidden: yes
    sql: ${TABLE}.is_early_settlement_opportunity ;;
  }

  set: detail {
    fields: [
      claimcontrol_id,
      claimant_num,
      claimfeature_num,
      claimexposure_id,
      claimsubexposure_num,
      claimcoverage_num,
      claimsubcoverage_num,
      reported_date_time,
      dscr,
      perperson_limit,
      peroccur_limit,
      deductible,
      exposure_dscr,
      subexposure_dscr,
      coverage_dscr,
      subcoverage_dscr,
      inside_adjuster_id,
      outside_adjuster_id,
      in_litigation,
      in_suit,
      in_salvage,
      zero_tort,
      record_only,
      tort_id,
      users_id,
      clue_date_time,
      reopened,
      reopened_date_time,
      claimfeaturestatus_id,
      claimfinancials_num,
      added_date_time,
      pcadded_date_time,
      deductible_waived,
      claimoffice_id,
      coverage_limitations,
      statute_of_limitations_date_time,
      waive_iso_reporting,
      corvel_approved_amount,
      exclude_from_medical,
      attorney_involved_date,
      claimdenial_date_time,
      denied,
      claimdenialreason_remarks,
      claimdenialusers_id,
      claimdenialreason_id,
      deductible_available_amount,
      deductible_applied_amount,
      in_litigation_yesno_id,
      claimfeatureclosereason_id,
      claimsubropotentialtype_id,
      is_early_settlement_opportunity
    ]
  }
}

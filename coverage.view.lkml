view: coverage {
  sql_table_name: dbo.Coverage ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_id}, '  ', ${policyimage_num}, ' ', ${coverage_num}) ;;
  }

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

  dimension: added_policyimage_num {
    hidden:yes
    type: number
    sql: ${TABLE}.added_policyimage_num ;;
  }

  dimension: apply_to_written_premium {
    label: "Apply to Written Prem (Y/N)"
    type: string
    sql: case when ${TABLE}.apply_to_written_premium=1 then 'Yes' else 'No' end ;;
  }

  dimension: asl_id {
    hidden: yes
    type: number
    sql: ${TABLE}.asl_id ;;
  }

  dimension: calc {
    label: "Algorithm"
    type: string
    sql: ${TABLE}.calc ;;
  }

  dimension: checkbox {
    hidden: yes
    type: string
    sql: ${TABLE}.checkbox ;;
  }

  dimension: coverage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.coverage_num ;;
  }

  dimension: coveragecode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: coveragelimit_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coveragelimit_id ;;
  }

  dimension: deductible {
    hidden: yes
    type: string
    sql: ${TABLE}.deductible ;;
  }

  dimension: deductible_id {
    hidden: yes
    type: number
    sql: ${TABLE}.deductible_id ;;
  }

  dimension: deleted_policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.deleted_policyimage_num ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  dimension: dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension_group: eff {
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
    sql: ${TABLE}.eff_date ;;
  }

  dimension_group: exp {
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
    sql: ${TABLE}.exp_date ;;
  }

  dimension: exposure {
    hidden: yes
    type: number
    sql: ${TABLE}.exposure ;;
  }

  dimension: ftp_offset_for_prev_image {
    hidden: yes
    type: string
    sql: ${TABLE}.ftp_offset_for_prev_image ;;
  }

  dimension: ftp_offset_for_reapplied {
    hidden: yes
    type: string
    sql: ${TABLE}.ftp_offset_for_reapplied ;;
  }

  dimension: ftp_onset_for_current {
    hidden: yes
    type: string
    sql: ${TABLE}.ftp_onset_for_current ;;
  }

  dimension: ftp_onset_for_reapplied {
    hidden: yes
    type: string
    sql: ${TABLE}.ftp_onset_for_reapplied ;;
  }

  dimension_group: last_modified {
    hidden: yes
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

  dimension_group: manualdate {
    hidden: yes
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
    sql: ${TABLE}.manualdate ;;
  }

  dimension: manuallimit_included {
    hidden: yes
    type: string
    sql: ${TABLE}.manuallimit_included ;;
  }

  dimension: manuallimit_increased {
    hidden: yes
    type: string
    sql: ${TABLE}.manuallimit_increased ;;
  }

  dimension: manuallimitamount {
    hidden: yes
    type: string
    sql: ${TABLE}.manuallimitamount ;;
  }

  dimension: minimum_liability_premium_fullterm {
    hidden: yes
    type: string
    sql: ${TABLE}.minimum_liability_premium_fullterm ;;
  }

  dimension: offset_for_prev_image {
    hidden: yes
    type: string
    sql: ${TABLE}.offset_for_prev_image ;;
  }

  dimension: offset_for_reapplied {
    hidden: yes
    type: string
    sql: ${TABLE}.offset_for_reapplied ;;
  }

  dimension: onset_for_current {
    hidden: yes
    type: string
    sql: ${TABLE}.onset_for_current ;;
  }

  dimension: onset_for_reapplied {
    hidden: yes
    type: string
    sql: ${TABLE}.onset_for_reapplied ;;
  }

  dimension: original_cost {
    hidden: yes
    type: string
    sql: ${TABLE}.original_cost ;;
  }

  dimension: override_fully_earned {
    hidden: yes
    type: string
    sql: ${TABLE}.override_fully_earned ;;
  }

  dimension: packagepart_num {
    hidden: yes
    type: number
    sql: ${TABLE}.packagepart_num ;;
  }

  dimension_group: pcadded {
    hidden: yes
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

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: premium_annual {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_annual ;;
  }

  dimension: premium_chg_annual {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_chg_annual ;;
  }

  dimension: premium_chg_fullterm {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_chg_fullterm ;;
  }

  dimension: premium_chg_written {
    label: "Prem-Written Change"
    type: number
    value_format_name: decimal_2
    sql: ${TABLE}.premium_chg_written ;;
  }

  dimension: premium_diff_chg_annual {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_diff_chg_annual ;;
  }

  dimension: premium_diff_chg_fullterm {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_diff_chg_fullterm ;;
  }

  dimension: premium_diff_chg_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_diff_chg_written ;;
  }

  dimension: premium_fullterm {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_fullterm ;;
  }

  dimension: premium_guaranteed_rate_period {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_guaranteed_rate_period ;;
  }

  dimension: premium_prev_chg_annual {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_prev_chg_annual ;;
  }

  dimension: premium_prev_chg_fullterm {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_prev_chg_fullterm ;;
  }

  dimension: premium_prev_chg_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_prev_chg_written ;;
  }

  dimension: premium_prevaudit_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_prevaudit_written ;;
  }

  dimension: premium_previous_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_previous_written ;;
  }

  dimension: premium_previous_written_shortrate {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_previous_written_shortrate ;;
  }

  dimension: premium_written {
    label: "Prem-Written"
    type: string
    sql: ${TABLE}.premium_written ;;
  }

  dimension: read_only {
    hidden: yes
    type: string
    sql: ${TABLE}.read_only ;;
  }

  dimension: scheduleditems {
    hidden: yes
    type: number
    sql: ${TABLE}.scheduleditems ;;
  }

  dimension: sequence_num {
    hidden: yes
    type: number
    sql: ${TABLE}.sequence_num ;;
  }

  dimension: subcoveragecode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.subcoveragecode_id ;;
  }

  dimension: unit_num {
    hidden: yes
    type: number
    sql: ${TABLE}.unit_num ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_premium_chg_written {
    label: "Total Change in Written Prem"
    type: sum
    value_format_name: decimal_2
    sql: ${premium_chg_written} ;;
  }
}

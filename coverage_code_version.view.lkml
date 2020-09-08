view: coverage_code_version {
      sql_table_name: coveragecodeversion
        ;;


    dimension: coveragecodeversion_id {
      type: number
      hidden: yes
      sql: ${TABLE}.coveragecodeversion_id ;;
    }

    dimension: coveragecode_id {
      type: number
      hidden:  yes
      sql: ${TABLE}.coveragecode_id ;;
    }

    dimension: version_id {
      type: number
      hidden: yes
      sql: ${TABLE}.version_id ;;
    }

#     dimension: covorder {
#       type: number
#       sql: ${TABLE}.covorder ;;
#     }
#
#     dimension: manuallimit {
#       type: string
#       sql: ${TABLE}.manuallimit ;;
#     }
#
#     dimension: asl_id {
#       type: number
#       sql: ${TABLE}.asl_id ;;
#     }
#
#     dimension: majorperil_id {
#       type: number
#       sql: ${TABLE}.majorperil_id ;;
#     }
#
#     dimension: typebureau_id {
#       type: number
#       sql: ${TABLE}.typebureau_id ;;
#     }
#
#     dimension: fullyearned {
#       type: string
#       sql: ${TABLE}.fullyearned ;;
#     }
#
#     dimension: coveragecodeversiongrouping_id {
#       type: number
#       sql: ${TABLE}.coveragecodeversiongrouping_id ;;
#     }
#
    dimension: caption {
       type: string
      hidden: yes
       sql: ${TABLE}.caption ;;
      }
#
#     dimension: coveragecodedatatype_id {
#       type: number
#       sql: ${TABLE}.coveragecodedatatype_id ;;
#     }
#
#     dimension: apply_to_written_premium {
#       type: string
#       sql: ${TABLE}.apply_to_written_premium ;;
#     }
#
#     dimension: scheduleditemscategory_id {
#       type: number
#       sql: ${TABLE}.scheduleditemscategory_id ;;
#     }
#
#     dimension: classcode_id {
#       type: number
#       sql: ${TABLE}.classcode_id ;;
#     }
#
#     dimension: claimpolicylimitcode_id {
#       type: number
#       sql: ${TABLE}.claimpolicylimitcode_id ;;
#     }
#
#     dimension: eff_date {
#       type: date
#       sql: ${TABLE}.eff_date ;;
#     }
#
#     dimension: exp_date {
#       type: date
#       sql: ${TABLE}.exp_date ;;
#     }
#
#     dimension: iso_bureaucode {
#       type: string
#       sql: ${TABLE}.iso_bureaucode ;;
#     }
#
#     dimension: aais_bureaucode {
#       type: string
#       sql: ${TABLE}.aais_bureaucode ;;
#     }
#
#     dimension: naii_bureaucode {
#       type: string
#       sql: ${TABLE}.naii_bureaucode ;;
#     }
#
#     dimension: niss_bureaucode {
#       type: string
#       sql: ${TABLE}.niss_bureaucode ;;
#     }
#
#     dimension: upload_dscr {
#       type: string
#       sql: ${TABLE}.upload_dscr ;;
#     }
#
#     dimension: excludefromlistview {
#       type: string
#       sql: ${TABLE}.excludefromlistview ;;
#     }
#
#     dimension: is_claimcoverage {
#       type: string
#       sql: ${TABLE}.is_claimcoverage ;;
#     }
#
#     dimension: samelimitacrossrisks {
#       type: string
#       sql: ${TABLE}.samelimitacrossrisks ;;
#     }
#
#     dimension: claim_sort_order {
#       type: number
#       sql: ${TABLE}.claim_sort_order ;;
#     }
#
#     dimension: appraisal_coverage {
#       type: string
#       sql: ${TABLE}.appraisal_coverage ;;
#     }
#
#     dimension: appraisal_sort_order {
#       type: number
#       sql: ${TABLE}.appraisal_sort_order ;;
#     }
#
#     dimension: allow_multiples {
#       type: string
#       sql: ${TABLE}.allow_multiples ;;
#     }
#
#     dimension: excludefromcoverageplans {
#       type: string
#       sql: ${TABLE}.excludefromcoverageplans ;;
#     }
#
#     dimension: coveragecategory_id {
#       type: number
#       sql: ${TABLE}.coveragecategory_id ;;
#     }
#
#     dimension: writtenpremium_roundto_id {
#       type: number
#       sql: ${TABLE}.writtenpremium_roundto_id ;;
#     }
#
#     dimension: medicare_liability {
#       type: string
#       sql: ${TABLE}.medicare_liability ;;
#     }
#
#     dimension: is_nofault {
#       type: string
#       sql: ${TABLE}.is_nofault ;;
#     }
#
#     dimension: removelimitwhenunitissuspended {
#       type: string
#       sql: ${TABLE}.removelimitwhenunitissuspended ;;
#     }
#
#     dimension_group: pcadded_date {
#       type: time
#       sql: ${TABLE}.pcadded_date ;;
#     }
#
#     dimension_group: last_modified_date {
#       type: time
#       sql: ${TABLE}.last_modified_date ;;
#     }
#
#     dimension: is_obsolete {
#       type: string
#       sql: ${TABLE}.is_obsolete ;;
#     }
#
#     dimension: should_always_save {
#       type: string
#       sql: ${TABLE}.should_always_save ;;
#     }
#
#     dimension: should_always_load {
#       type: string
#       sql: ${TABLE}.should_always_load ;;
#     }
#
#     dimension: coveragecodedisplaytype_id {
#       type: number
#       sql: ${TABLE}.coveragecodedisplaytype_id ;;
#     }
#
#     dimension: coveragecategoryroletype_id {
#       type: number
#       sql: ${TABLE}.coveragecategoryroletype_id ;;
#     }
#
#     dimension: acord_code {
#       type: string
#       sql: ${TABLE}.acord_code ;;
#     }
#
#     dimension: blankettype_id {
#       type: number
#       sql: ${TABLE}.blankettype_id ;;
#     }
#
#     dimension: master_coveragecode_id {
#       type: number
#       sql: ${TABLE}.master_coveragecode_id ;;
#     }
#
#     dimension: refer_to_coverage_fully_earned {
#       type: string
#       sql: ${TABLE}.refer_to_coverage_fully_earned ;;
#     }
#
#     dimension: default_deductible_id {
#       type: number
#       sql: ${TABLE}.default_deductible_id ;;
#     }
#
#     dimension: default_manuallimitamount {
#       type: string
#       sql: ${TABLE}.default_manuallimitamount ;;
#     }
#
#     dimension_group: default_manualdate {
#       type: time
#       sql: ${TABLE}.default_manualdate ;;
#     }
#
#     dimension: default_checkbox {
#       type: string
#       sql: ${TABLE}.default_checkbox ;;
#     }
#
#     dimension: default_coveragelimit_id {
#       type: number
#       sql: ${TABLE}.default_coveragelimit_id ;;
#     }
#
#     dimension: refer_to_coverage_asl_id {
#       type: string
#       sql: ${TABLE}.refer_to_coverage_asl_id ;;
#     }
#
#     dimension: exclude_for_new_business {
#       type: string
#       sql: ${TABLE}.exclude_for_new_business ;;
#     }
#
#     dimension: auditable {
#       type: string
#       sql: ${TABLE}.auditable ;;
#     }
#
#     dimension: tool_tip_text {
#       type: string
#       sql: ${TABLE}.tool_tip_text ;;
#     }
#
#     dimension: exclude_from_calc_screen {
#       type: string
#       sql: ${TABLE}.exclude_from_calc_screen ;;
#     }
#
#     dimension: should_coverageratingversion_be_used {
#       type: string
#       sql: ${TABLE}.should_coverageratingversion_be_used ;;
#     }
#
#     dimension: exclude_from_commissions {
#       type: string
#       sql: ${TABLE}.exclude_from_commissions ;;
#     }
#
#     dimension: taxratecoveragetype_id {
#       type: number
#       sql: ${TABLE}.taxratecoveragetype_id ;;
#     }
#
#     dimension: coverageexposure_id {
#       type: number
#       sql: ${TABLE}.coverageexposure_id ;;
#     }
#
#     dimension: iso_coverage_type {
#       type: string
#       sql: ${TABLE}.iso_coverage_type ;;
#     }
#
#     dimension: iso_loss_type {
#       type: string
#       sql: ${TABLE}.iso_loss_type ;;
#     }
#
#     dimension: question_format {
#       type: string
#       sql: ${TABLE}.question_format ;;
#     }
#
#     dimension: developer_notes {
#       type: string
#       sql: ${TABLE}.developer_notes ;;
#     }
#
#     dimension: default_checkbox_amount {
#       type: string
#       sql: ${TABLE}.default_checkbox_amount ;;
#     }
#
#     dimension: claimexposure_id {
#       type: number
#       sql: ${TABLE}.claimexposure_id ;;
#     }
#
#     dimension: additional_coverage_info {
#       type: string
#       sql: ${TABLE}.additional_coverage_info ;;
#     }
#
#     dimension: iso_policy_type {
#       type: string
#       sql: ${TABLE}.iso_policy_type ;;
#     }
#
#     dimension: minimum_earned_premium_oncancel {
#       type: string
#       sql: ${TABLE}.minimum_earned_premium_oncancel ;;
#     }
#
#     dimension: person {
#       type: number
#       sql: ${TABLE}.person ;;
#     }
#
#     dimension: apply_to_policy_fee {
#       type: string
#       sql: ${TABLE}.apply_to_policy_fee ;;
#     }
#
#     dimension: include_in_property_clue_file {
#       type: string
#       sql: ${TABLE}.include_in_property_clue_file ;;
#     }
#
#     dimension: validate_subro_adjuster {
#       type: string
#       sql: ${TABLE}.validate_subro_adjuster ;;
#     }
#
#     dimension: clue_ca_pd {
#       type: string
#       sql: ${TABLE}.clue_ca_pd ;;
#     }
#
#     dimension: clue_ca_bi {
#       type: string
#       sql: ${TABLE}.clue_ca_bi ;;
#     }
#
#     dimension: corvel_coveragecode_value {
#       type: number
#       sql: ${TABLE}.corvel_coveragecode_value ;;
#     }
#
#     dimension: exclude_from_summary {
#       type: string
#       sql: ${TABLE}.exclude_from_summary ;;
#     }
#
#     dimension: include_in_medical {
#       type: string
#       sql: ${TABLE}.include_in_medical ;;
#     }
#
#     dimension: medicalvendor_coveragecode_value {
#       type: string
#       sql: ${TABLE}.medicalvendor_coveragecode_value ;;
#     }
#
#     dimension: corvel_coverage_type {
#       type: string
#       sql: ${TABLE}.corvel_coverage_type ;;
#     }
#
#     dimension: include_alae_in_limit {
#       type: string
#       sql: ${TABLE}.include_alae_in_limit ;;
#     }
#
#     dimension: include_expense_in_limit {
#       type: string
#       sql: ${TABLE}.include_expense_in_limit ;;
#     }
#
#     dimension: claims_made {
#       type: string
#       sql: ${TABLE}.claims_made ;;
#     }
#
#     dimension: injury_related {
#       type: string
#       sql: ${TABLE}.injury_related ;;
#     }
#
#     dimension: claims_show_evaluation_tab {
#       type: string
#       sql: ${TABLE}.claims_show_evaluation_tab ;;
#     }
#
#     dimension: claims_show_pip_negotiation_tab {
#       type: string
#       sql: ${TABLE}.claims_show_pip_negotiation_tab ;;
#     }
#
#     dimension: claims_show_negotiation_tab {
#       type: string
#       sql: ${TABLE}.claims_show_negotiation_tab ;;
#     }
#
#     dimension: claims_show_eob_tab {
#       type: string
#       sql: ${TABLE}.claims_show_eob_tab ;;
#     }
#
#     dimension: is_property_damage_coverage {
#       type: string
#       sql: ${TABLE}.is_property_damage_coverage ;;
#     }
#
#     dimension: validate_in_litigation {
#       type: string
#       sql: ${TABLE}.validate_in_litigation ;;
#     }
#
#     dimension: prorate_premium_over_min_oncancel {
#       type: string
#       sql: ${TABLE}.prorate_premium_over_min_oncancel ;;
#     }
#
#     dimension: medicarecoveragetype_id {
#       type: number
#       sql: ${TABLE}.medicarecoveragetype_id ;;
#     }
#
#     dimension: acdlosscategorytype_id {
#       type: number
#       sql: ${TABLE}.acdlosscategorytype_id ;;
#     }
#
#     dimension: apluslosstype_id {
#       type: number
#       sql: ${TABLE}.apluslosstype_id ;;
#     }
#
#     dimension: suppress_claimant_num_for_corvel {
#       type: string
#       sql: ${TABLE}.suppress_claimant_num_for_corvel ;;
#     }
#
#     dimension: coverageperiltype_id {
#       type: number
#       sql: ${TABLE}.coverageperiltype_id ;;
#     }
#
#     dimension: coverageverifiercoveragetype_id {
#       type: number
#       sql: ${TABLE}.coverageverifiercoveragetype_id ;;
#     }
#
#     dimension: coverageverifiercoveragecode_id {
#       type: number
#       sql: ${TABLE}.coverageverifiercoveragecode_id ;;
#     }
#
#     dimension: verify_for_subro {
#       type: string
#       sql: ${TABLE}.verify_for_subro ;;
#     }
#
#     dimension: verify_for_salvage {
#       type: string
#       sql: ${TABLE}.verify_for_salvage ;;
#     }
#
#     dimension: include_in_xactware {
#       type: string
#       sql: ${TABLE}.include_in_xactware ;;
#     }
#
#     dimension: coveragegroup_id {
#       type: number
#       sql: ${TABLE}.coveragegroup_id ;;
#     }
#
#     dimension: exclude_from_packagesync {
#       type: string
#       sql: ${TABLE}.exclude_from_packagesync ;;
#     }
#
#     dimension: is_depreciable {
#       type: string
#       sql: ${TABLE}.is_depreciable ;;
#     }
#
#     dimension: sync_across_state {
#       type: string
#       sql: ${TABLE}.sync_across_state ;;
#     }
#
#     dimension: workerscompcoveragetype_id {
#       type: number
#       sql: ${TABLE}.workerscompcoveragetype_id ;;
#     }
#
#     dimension: limit_perperson_value {
#       type: string
#       sql: ${TABLE}.limit_perperson_value ;;
#     }
#
#     dimension: limit_peroccur_value {
#       type: string
#       sql: ${TABLE}.limit_peroccur_value ;;
#     }
#
#     dimension: limit_min_value {
#       type: string
#       sql: ${TABLE}.limit_min_value ;;
#     }
#
#     dimension: limit_max_value {
#       type: string
#       sql: ${TABLE}.limit_max_value ;;
#     }
#
#     dimension: limit_customlogic_dscr {
#       type: string
#       sql: ${TABLE}.limit_customlogic_dscr ;;
#     }
#
#     dimension: limit_coveragelimitdeductibleoption_id {
#       type: number
#       sql: ${TABLE}.limit_coveragelimitdeductibleoption_id ;;
#     }
#
#     dimension: limit_coverage_percentage {
#       type: number
#       sql: ${TABLE}.limit_coverage_percentage ;;
#     }
#
#     dimension: deductible_static_value {
#       type: string
#       sql: ${TABLE}.deductible_static_value ;;
#     }
#
#     dimension: deductible_customlogic_dscr {
#       type: string
#       sql: ${TABLE}.deductible_customlogic_dscr ;;
#     }
#
#     dimension: deductible_coveragelimitdeductibleoption_id {
#       type: number
#       sql: ${TABLE}.deductible_coveragelimitdeductibleoption_id ;;
#     }
#
#     dimension: claims_coverage_comments {
#       type: string
#       sql: ${TABLE}.claims_coverage_comments ;;
#     }
#

  }

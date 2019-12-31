view: driver {
  sql_table_name: dbo.Driver ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_id}, '  ', ${policyimage_num}, ' ', ${driver_num}) ;;
  }

  dimension: transuniontransmissionrvpimporteddriver_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transuniontransmissionrvpimporteddriver_id ;;
  }

  dimension: acc_prev_course {
    hidden: yes
    type: string
    sql: ${TABLE}.acc_prev_course ;;
  }

  dimension_group: acc_prev_course {
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
    sql: ${TABLE}.acc_prev_course_date ;;
  }

  dimension_group: acc_prevention_course {
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
    sql: ${TABLE}.acc_prevention_course ;;
  }

  dimension_group: accident {
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
    sql: ${TABLE}.accident_date ;;
  }

  dimension: accident_free {
    hidden: yes
    type: string
    sql: ${TABLE}.accident_free ;;
  }

  dimension_group: accident_free {
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
    sql: ${TABLE}.accident_free_date ;;
  }

  dimension: accidentfree_id {
    hidden: yes
    type: number
    sql: ${TABLE}.accidentfree_id ;;
  }

  dimension: accidents_violations {
    label: "Has Accidents/Violations (Y/N)"
    type: string
    sql: case when ${TABLE}.accidents_violations=1 then 'Yes' else 'No' end ;;
  }

  dimension: accidentsurchargetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.accidentsurchargetype_id ;;
  }

  dimension_group: added {
    label: "Added"
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: added_policyimage_num {
    label: "Image Number Added"
    type: number
    sql: ${TABLE}.added_policyimage_num ;;
  }

  dimension: agency_issued_sr22 {
    hidden: yes
    type: string
    sql: ${TABLE}.agency_issued_sr22 ;;
  }

  dimension_group: alcohol_drugs {
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
    sql: ${TABLE}.alcohol_drugs_date ;;
  }

  dimension: alcohol_drugs_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.alcohol_drugs_disc ;;
  }

  dimension_group: apcd {
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
    sql: ${TABLE}.apcd ;;
  }

  dimension: away_with_car {
    hidden: yes
    type: string
    sql: ${TABLE}.away_with_car ;;
  }

  dimension: away_wo_car {
    hidden: yes
    type: string
    sql: ${TABLE}.away_wo_car ;;
  }

  dimension: bureau_case_number {
    hidden: yes
    type: string
    sql: ${TABLE}.bureau_case_number ;;
  }

  dimension: calculated_tier {
    hidden: yes
    type: number
    sql: ${TABLE}.calculated_tier ;;
  }

  dimension: choicepoint_driverlicensestatus_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.choicepoint_driverlicensestatus_dscr ;;
  }

  dimension: choicepointtransmission_num {
    hidden: yes
    type: number
    sql: ${TABLE}.choicepointtransmission_num ;;
  }

  dimension: class_code {
    label: "Class Code"
    type: string
    sql: ${TABLE}.class_code ;;
  }

  dimension: classcode_override {
    hidden: yes
    type: string
    sql: ${TABLE}.classcode_override ;;
  }

  dimension: clue {
    hidden: yes
    type: string
    sql: ${TABLE}.clue ;;
  }

  dimension: college_student {
    hidden: yes
    type: number
    sql: ${TABLE}.college_student ;;
  }

  dimension: companion_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.companion_discount ;;
  }

  dimension: companydriver_num {
    hidden: yes
    type: number
    sql: ${TABLE}.companydriver_num ;;
  }

  dimension: coordinationofbenefitstype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coordinationofbenefitstype_id ;;
  }

  dimension: coverage_default_plan_applied {
    hidden: yes
    type: string
    sql: ${TABLE}.coverage_default_plan_applied ;;
  }

  dimension: creditsurcharge {
    hidden: yes
    type: string
    sql: ${TABLE}.creditsurcharge ;;
  }

  dimension: deductibletype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.deductibletype_id ;;
  }

  dimension: def_driver {
    hidden: yes
    type: string
    sql: case when ${TABLE}.def_driver=1 then 'Yes' else 'No' end ;;
  }

  dimension_group: def_driver {
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
    sql: ${TABLE}.def_driver_date ;;
  }

  dimension: deleted_policyimage_num {
    label: "Image Number Deleted"
    type: number
    sql: ${TABLE}.deleted_policyimage_num ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  dimension: disable_agent_deletion {
    hidden: yes
    type: string
    sql: ${TABLE}.disable_agent_deletion ;;
  }

  dimension: disclosed_clue {
    hidden: yes
    type: string
    sql: ${TABLE}.disclosed_clue ;;
  }

  dimension: disclosed_mvr {
    hidden: yes
    type: string
    sql: ${TABLE}.disclosed_mvr ;;
  }

  dimension: disposition {
    hidden: yes
    type: string
    sql: ${TABLE}.disposition ;;
  }

  dimension: distant_student {
    hidden: yes
    type: string
    sql: ${TABLE}.distant_student ;;
  }

  dimension: drive_alive {
    hidden: yes
    type: string
    sql: ${TABLE}.drive_alive ;;
  }

  dimension: drive_alive_disc_applied {
    hidden: yes
    type: string
    sql: ${TABLE}.drive_alive_disc_applied ;;
  }

  dimension: driver_display_num {
    hidden: yes
    type: number
    sql: ${TABLE}.driver_display_num ;;
  }

  dimension: driver_improve_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.driver_improve_disc ;;
  }

  dimension: driver_num {
    hidden: yes
    type: number
    sql: ${TABLE}.driver_num ;;
  }

  dimension_group: driver_train {
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
    sql: ${TABLE}.driver_train ;;
  }

  dimension: driver_training {
    label: "Driver Training (Y/N)"
    type: string
    sql: case when ${TABLE}.driver_training=1 then 'Yes' else 'No' end ;;
  }

  dimension: driver_training_override {
    hidden: yes
    type: string
    sql: ${TABLE}.driver_training_override ;;
  }

  dimension: driverexcludereason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.driverexcludereason_id ;;
  }

  dimension: driverexcludetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.driverexcludetype_id ;;
  }

  dimension: driverocc_id {
    hidden: yes
    type: number
    sql: ${TABLE}.driverocc_id ;;
  }

  dimension: driveroccupationtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.driveroccupationtype_id ;;
  }

  dimension: driverreasonexcludetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.driverreasonexcludetype_id ;;
  }

  dimension: drivertype {
    hidden: yes
    type: number
    sql: ${TABLE}.drivertype ;;
  }

  dimension_group: eff {
    label: "Effective"
    type: time
    timeframes: [date,month,quarter,year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.eff_date ;;
  }

  dimension: employment_info {
    hidden: yes
    type: string
    sql: ${TABLE}.employment_info ;;
  }

  dimension: enol_annualmiles {
    hidden: yes
    type: number
    sql: ${TABLE}.enol_annualmiles ;;
  }

  dimension: enol_days {
    hidden: yes
    type: number
    sql: ${TABLE}.enol_days ;;
  }

  dimension: enol_drivername {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_drivername ;;
  }

  dimension: enol_employedbygarage {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_employedbygarage ;;
  }

  dimension: enol_garageliability {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_garageliability ;;
  }

  dimension: enol_govtbusiness {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_govtbusiness ;;
  }

  dimension: enol_hiredauto {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_hiredauto ;;
  }

  dimension: enol_insuredorspouse {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_insuredorspouse ;;
  }

  dimension: enol_medpay_exclude {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_medpay_exclude ;;
  }

  dimension: enol_miles {
    hidden: yes
    type: number
    sql: ${TABLE}.enol_miles ;;
  }

  dimension: enol_namedinsured {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_namedinsured ;;
  }

  dimension: enol_primaryliability {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_primaryliability ;;
  }

  dimension: enol_regularuse {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_regularuse ;;
  }

  dimension: enol_relative {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_relative ;;
  }

  dimension: enol_specificvehicle {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_specificvehicle ;;
  }

  dimension: enol_territory_num {
    hidden: yes
    type: number
    sql: ${TABLE}.enol_territory_num ;;
  }

  dimension: enol_use {
    hidden: yes
    type: string
    sql: ${TABLE}.enol_use ;;
  }

  dimension: enol_vehicleusetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.enol_vehicleusetype_id ;;
  }

  dimension: excluded_designated_driver {
    hidden: yes
    type: string
    sql: ${TABLE}.excluded_designated_driver ;;
  }

  dimension: excluded_driver {
    hidden: yes
    type: string
    sql: ${TABLE}.excluded_driver ;;
  }

  dimension: excluded_vehicle {
    hidden: yes
    type: number
    sql: ${TABLE}.excluded_vehicle ;;
  }

  dimension: experienced_operator_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.experienced_operator_discount ;;
  }

  dimension: expr_operator_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.expr_operator_discount ;;
  }

  dimension: expr_operator_discount_motorcycle {
    hidden: yes
    type: string
    sql: ${TABLE}.expr_operator_discount_motorcycle ;;
  }

  dimension: expr_operator_discount_watercraft {
    hidden: yes
    type: string
    sql: ${TABLE}.expr_operator_discount_watercraft ;;
  }

  dimension: extended_non_owned {
    hidden: yes
    type: string
    sql: ${TABLE}.extended_non_owned ;;
  }

  dimension: extendedproperties_xml {
    hidden: yes
    type: string
    sql: ${TABLE}.extendedproperties_xml ;;
  }

  dimension: external_id {
    hidden: yes
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: external_unit_identifier {
    hidden: yes
    type: string
    sql: ${TABLE}.external_unit_identifier ;;
  }

  dimension: federal_employee {
    hidden: yes
    type: string
    sql: ${TABLE}.federal_employee ;;
  }

  dimension: female_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.female_discount ;;
  }

  dimension: filing_info {
    hidden: yes
    type: string
    sql: ${TABLE}.filing_info ;;
  }

  dimension: filing_state {
    hidden: yes
    type: string
    sql: ${TABLE}.filing_state ;;
  }

  dimension: first_permit {
    hidden: yes
    type: string
    sql: ${TABLE}.first_permit ;;
  }

  dimension_group: fr_exp {
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
    sql: ${TABLE}.fr_exp_date ;;
  }

  dimension: good_student {
    label: "Good Student (Y/N)"
    type: string
    sql: case when ${TABLE}.good_student=1 then 'Yes' else 'No' end ;;
  }

  dimension_group: good_student {
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
    sql: ${TABLE}.good_student_date ;;
  }

  dimension: good_student_disc_applied {
    hidden: yes
    type: string
    sql: ${TABLE}.good_student_disc_applied ;;
  }

  dimension: gooddriver {
    label: "Good Driver (Y/N)"
    type: string
    sql: case when ${TABLE}.gooddriver=1 then 'Yes' else 'No' end ;;
  }

  dimension: has_foreign_license {
    hidden: yes
    type: string
    sql: ${TABLE}.has_foreign_license ;;
  }

  dimension: has_inactive_license {
    hidden: yes
    type: string
    sql: ${TABLE}.has_inactive_license ;;
  }

  dimension: incometype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.incometype_id ;;
  }

  dimension: is_additional_driver_discovery_received {
    hidden: yes
    type: string
    sql: ${TABLE}.is_additional_driver_discovery_received ;;
  }

  dimension: is_additional_driver_discovery_required {
    hidden: yes
    type: string
    sql: ${TABLE}.is_additional_driver_discovery_required ;;
  }

  dimension: is_clue_report_required {
    hidden: yes
    type: string
    sql: ${TABLE}.is_clue_report_required ;;
  }

  dimension: is_college_graduate {
    hidden: yes
    type: string
    sql: ${TABLE}.is_college_graduate ;;
  }

  dimension: is_exceptional_driver {
    hidden: yes
    type: string
    sql: ${TABLE}.is_exceptional_driver ;;
  }

  dimension: is_imported_driver {
    hidden: yes
    type: string
    sql: ${TABLE}.is_imported_driver ;;
  }

  dimension: is_license_status_overridden {
    hidden: yes
    type: string
    sql: ${TABLE}.is_license_status_overridden ;;
  }

  dimension: is_mvr_report_required {
    hidden: yes
    type: string
    sql: ${TABLE}.is_mvr_report_required ;;
  }

  dimension: is_named_individual {
    hidden: yes
    type: string
    sql: ${TABLE}.is_named_individual ;;
  }

  dimension: is_registered_owner {
    hidden: yes
    type: string
    sql: ${TABLE}.is_registered_owner ;;
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

  dimension: liabilitytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.liabilitytype_id ;;
  }

  dimension: licensestatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.licensestatus_id ;;
  }

  dimension: licensetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.licensetype_id ;;
  }

  dimension: linknumber {
    hidden: yes
    type: string
    sql: ${TABLE}.linknumber ;;
  }

  dimension: loss_free {
    hidden: yes
    type: number
    sql: ${TABLE}.loss_free ;;
  }

  dimension: majorconvictionlevelonetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.majorconvictionlevelonetype_id ;;
  }

  dimension: majorconvictionleveltwotype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.majorconvictionleveltwotype_id ;;
  }

  dimension: majorsurchargetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.majorsurchargetype_id ;;
  }

  dimension: married_driver {
    hidden: yes
    type: string
    sql: ${TABLE}.married_driver ;;
  }

  dimension: med_imp {
    hidden: yes
    type: string
    sql: ${TABLE}.med_imp ;;
  }

  dimension: med_imp_description {
    hidden: yes
    type: string
    sql: ${TABLE}.med_imp_description ;;
  }

  dimension: military {
    hidden: yes
    type: string
    sql: ${TABLE}.military ;;
  }

  dimension: militarytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.militarytype_id ;;
  }

  dimension: minorsurchargetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.minorsurchargetype_id ;;
  }

  dimension: months_licensed_in_us {
    label: "Licensed in USA-Months"
    type: number
    sql: ${TABLE}.months_licensed_in_us ;;
  }

  dimension: months_licensed_instate {
    label: "Licensed in State-Months"
    type: number
    sql: ${TABLE}.months_licensed_instate ;;
  }

  dimension: months_licensed_international {
    hidden: yes
    type: number
    sql: ${TABLE}.months_licensed_international ;;
  }

  dimension: months_licensed_total {
    hidden: yes
    type: number
    sql: ${TABLE}.months_licensed_total ;;
  }

  dimension: months_revoked {
    hidden: yes
    type: number
    sql: ${TABLE}.months_revoked ;;
  }

  dimension_group: motor_membership {
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
    sql: ${TABLE}.motor_membership_date ;;
  }

  dimension: motorclub {
    hidden: yes
    type: string
    sql: ${TABLE}.motorclub ;;
  }

  dimension: motorcycle_training_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.motorcycle_training_disc ;;
  }

  dimension_group: motorcycle_training_disc {
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
    sql: ${TABLE}.motorcycle_training_disc_date ;;
  }

  dimension: motorcycle_years_experience {
    hidden: yes
    type: number
    sql: ${TABLE}.motorcycle_years_experience ;;
  }

  dimension: multiple_occurrence_surcharge {
    hidden: yes
    type: string
    sql: ${TABLE}.multiple_occurrence_surcharge ;;
  }

  dimension: mvr {
    label: "MVR (Y/N)"
    type: string
    sql: case when ${TABLE}.mvr=1 then 'Yes' else 'No' end ;;
  }

  dimension_group: mvr {
    label: "MVR "
    type: time
    timeframes: [time,date,week,month,quarter,year]
    sql: case when ${TABLE}.mvr_date<'1900-01-01' then NULL else ${TABLE}.mvr_date end ;;
  }

  dimension: mvr_points {
    hidden: yes
    type: number
    sql: ${TABLE}.mvr_points ;;
  }

  dimension: named_non_owned {
    hidden: yes
    type: string
    sql: ${TABLE}.named_non_owned ;;
  }

  dimension: nnol_days {
    hidden: yes
    type: number
    sql: ${TABLE}.nnol_days ;;
  }

  dimension: nnol_miles {
    hidden: yes
    type: number
    sql: ${TABLE}.nnol_miles ;;
  }

  dimension: nnol_territory_num {
    hidden: yes
    type: number
    sql: ${TABLE}.nnol_territory_num ;;
  }

  dimension: nnol_vehicleusetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nnol_vehicleusetype_id ;;
  }

  dimension: non_driver {
    hidden: yes
    type: string
    sql: ${TABLE}.non_driver ;;
  }

  dimension: non_driver_remark {
    hidden: yes
    type: string
    sql: ${TABLE}.non_driver_remark ;;
  }

  dimension: num {
    label: "Number"
    type: number
    sql: ${TABLE}.num ;;
  }

  dimension: numberinhouseholdtype_id {
    type: number
    sql: ${TABLE}.numberinhouseholdtype_id ;;
  }

  dimension: only_driver_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.only_driver_discount ;;
  }

  dimension: package_unit_num {
    hidden: yes
    type: number
    sql: ${TABLE}.package_unit_num ;;
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

  dimension: pip_named_herein {
    hidden: yes
    type: string
    sql: ${TABLE}.pip_named_herein ;;
  }

  dimension: points {
    label: "Points"
    type: number
    sql: ${TABLE}.points ;;
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

  dimension: preferred {
    hidden: yes
    type: string
    sql: ${TABLE}.preferred ;;
  }

  dimension: prior_licensed_number {
    hidden: yes
    type: string
    sql: ${TABLE}.prior_licensed_number ;;
  }

  dimension: prior_licensed_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.prior_licensed_state_id ;;
  }

  dimension: rcposimporteddriver_id {
    hidden: yes
    type: number
    sql: ${TABLE}.rcposimporteddriver_id ;;
  }

  dimension: reason_exclude {
    hidden: yes
    type: string
    sql: ${TABLE}.reason_exclude ;;
  }

  dimension: reason_excluded {
    hidden: yes
    type: string
    sql: ${TABLE}.reason_excluded ;;
  }

  dimension: reason_excluded_description {
    hidden: yes
    type: string
    sql: ${TABLE}.reason_excluded_description ;;
  }

  dimension: recoupmentfee {
    hidden: yes
    type: string
    sql: ${TABLE}.recoupmentfee ;;
  }

  dimension: reject_work_loss {
    hidden: yes
    type: string
    sql: ${TABLE}.reject_work_loss ;;
  }

  dimension: relation_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.relation_dscr ;;
  }

  dimension: relationshiptype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.relationshiptype_id ;;
  }

  dimension: saq_imported {
    hidden: yes
    type: string
    sql: ${TABLE}.saq_imported ;;
  }

  dimension: saqimporteddriver_num {
    hidden: yes
    type: number
    sql: ${TABLE}.saqimporteddriver_num ;;
  }

  dimension: school_city {
    hidden: yes
    type: string
    sql: ${TABLE}.school_city ;;
  }

  dimension: school_distance {
    hidden: yes
    type: number
    sql: ${TABLE}.school_distance ;;
  }

  dimension: school_name {
    hidden: yes
    type: string
    sql: ${TABLE}.school_name ;;
  }

  dimension: school_state {
    hidden: yes
    type: number
    sql: ${TABLE}.school_state ;;
  }

  dimension: school_vehicleatschool {
    hidden: yes
    type: string
    sql: ${TABLE}.school_vehicleatschool ;;
  }

  dimension: school_whichvehicle {
    hidden: yes
    type: string
    sql: ${TABLE}.school_whichvehicle ;;
  }

  dimension: school_zip {
    hidden: yes
    type: string
    sql: ${TABLE}.school_zip ;;
  }

  dimension: senior_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.senior_discount ;;
  }

  dimension_group: senior_driver {
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
    sql: ${TABLE}.senior_driver_date ;;
  }

  dimension: seniorlowmileage {
    hidden: yes
    type: string
    sql: ${TABLE}.seniorlowmileage ;;
  }

  dimension: sr22_filing_fee {
    hidden: yes
    type: string
    sql: ${TABLE}.sr22_filing_fee ;;
  }

  dimension: sr22_filing_info {
    hidden: yes
    type: string
    sql: ${TABLE}.sr22_filing_info ;;
  }

  dimension: sr22type_id {
    hidden: yes
    type: number
    sql: ${TABLE}.sr22type_id ;;
  }

  dimension: student_has_car {
    hidden: yes
    type: string
    sql: ${TABLE}.student_has_car ;;
  }

  dimension: studentmiles_id {
    hidden: yes
    type: number
    sql: ${TABLE}.studentmiles_id ;;
  }

  dimension: tier_override {
    hidden: yes
    type: string
    sql: ${TABLE}.tier_override ;;
  }

  dimension: tiertype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.tiertype_id ;;
  }

  dimension: titleowner {
    hidden: yes
    type: string
    sql: ${TABLE}.titleowner ;;
  }

  dimension: undeclared_operator {
    hidden: yes
    type: string
    sql: ${TABLE}.undeclared_operator ;;
  }

  dimension: undeclared_operator_override {
    hidden: yes
    type: string
    sql: ${TABLE}.undeclared_operator_override ;;
  }

  dimension: underwriting_points {
    hidden: yes
    type: number
    sql: ${TABLE}.underwriting_points ;;
  }

  dimension: unverifiable_driving_record {
    hidden: yes
    type: string
    sql: ${TABLE}.unverifiable_driving_record ;;
  }

  dimension: unverifiable_surcharge {
    hidden: yes
    type: string
    sql: ${TABLE}.unverifiable_surcharge ;;
  }

  dimension: warp_id {
    hidden: yes
    type: string
    sql: ${TABLE}.warp_id ;;
  }

  dimension: watercraft_passing_grade {
    hidden: yes
    type: string
    sql: ${TABLE}.watercraft_passing_grade ;;
  }

  dimension_group: watercraft_safety_course {
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
    sql: ${TABLE}.watercraft_safety_course_date ;;
  }

  dimension: worklossexclusion {
    hidden: yes
    type: number
    sql: ${TABLE}.worklossexclusion ;;
  }

  dimension: years_licensed_in_us {
    label: "Licensed in USA-Years"
    type: number
    sql: ${TABLE}.years_licensed_in_us ;;
  }

  dimension: years_licensed_international {
    hidden: yes
    type: number
    sql: ${TABLE}.years_licensed_international ;;
  }

  dimension: years_licensed_total {
    hidden: yes
    type: number
    sql: ${TABLE}.years_licensed_total ;;
  }

  dimension_group: years_months_lic_updated {
    hidden: yes
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
    sql: ${TABLE}.years_months_lic_updated_date ;;
  }

  dimension: yearslicinstate {
    label: "Licensed in State-Years"
    type: number
    sql: ${TABLE}.yearslicinstate ;;
  }

  dimension: youthful_operator {
    hidden: yes
    type: string
    sql: ${TABLE}.youthful_operator ;;
  }

  dimension: youthful_operator_premium {
    hidden: yes
    type: string
    sql: ${TABLE}.youthful_operator_premium ;;
  }

  dimension: youthfulpledge {
    hidden: yes
    type: string
    sql: ${TABLE}.youthfulpledge ;;
  }

  measure: count {
    type: count
    drill_fields: [transuniontransmissionrvpimporteddriver_id, school_name, enol_drivername]
  }
}

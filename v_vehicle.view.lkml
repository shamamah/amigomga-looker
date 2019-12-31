view: v_vehicle {
  sql_table_name: dbo.vVehicle ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_id}, '  ', ${policyimage_num}, ' ', ${vehicle_num}) ;;
  }

  dimension: abs_disc_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.abs_disc_pct ;;
  }

  dimension: abs_id {
    hidden: yes
    type: number
    sql: ${TABLE}.abs_id ;;
  }

  dimension: accconamt {
    hidden: yes
    type: string
    sql: ${TABLE}.accconamt ;;
  }

  dimension: accconper {
    hidden: yes
    type: string
    sql: ${TABLE}.accconper ;;
  }

  dimension: accessorieamount {
    hidden: yes
    type: string
    sql: ${TABLE}.accessorieamount ;;
  }

  dimension: accessoriedescription {
    hidden: yes
    type: string
    sql: ${TABLE}.accessoriedescription ;;
  }

  dimension: accident_free_disc_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.accident_free_disc_pct ;;
  }

  dimension: accidentamount {
    hidden: yes
    type: string
    sql: ${TABLE}.accidentamount ;;
  }

  dimension: accidentdescription {
    hidden: yes
    type: string
    sql: ${TABLE}.accidentdescription ;;
  }

  dimension: accprev_disc_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.accprev_disc_pct ;;
  }

  dimension: accprevamt {
    hidden: yes
    type: string
    sql: ${TABLE}.accprevamt ;;
  }

  dimension: accprevper {
    hidden: yes
    type: string
    sql: ${TABLE}.accprevper ;;
  }

  dimension: acv {
    label: "ACV"
    type: number
    sql: ${TABLE}.acv ;;
  }

  dimension_group: added {
    label: "Added"
    type: time
    timeframes: [
      time,
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
    label: "Image Number Added"
    type: number
    sql: ${TABLE}.added_policyimage_num ;;
  }

  dimension: additional_interest {
    label: "Additional Interest (Y/N)"
    type: string
    sql: case when ${TABLE}.additional_interest=1 then 'Yes' else 'No' end ;;
  }

  dimension: annual_miles {
    label: "Annual Miles"
    type: number
    sql: ${TABLE}.annual_miles ;;
  }

  dimension: anti_theft_discount {
    hidden: yes
    type: string
    sql: ${TABLE}.anti_theft_discount ;;
  }

  dimension: antilockamt {
    hidden: yes
    type: number
    sql: ${TABLE}.antilockamt ;;
  }

  dimension: antilockper {
    hidden: yes
    type: string
    sql: ${TABLE}.antilockper ;;
  }

  dimension: antilocktype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.antilocktype_id ;;
  }

  dimension: antitheft_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.antitheft_disc ;;
  }

  dimension: antitheft_disc_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.antitheft_disc_pct ;;
  }

  dimension: antitheftamt {
    hidden: yes
    type: number
    sql: ${TABLE}.antitheftamt ;;
  }

  dimension: antitheftper {
    hidden: yes
    type: string
    sql: ${TABLE}.antitheftper ;;
  }

  dimension: antithefttype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.antithefttype_id ;;
  }

  dimension: bodystyle_id {
    hidden: yes
    type: number
    sql: ${TABLE}.bodystyle_id ;;
  }

  dimension: bodytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.bodytype_id ;;
  }

  dimension: business_use_description {
    hidden: yes
    type: string
    sql: ${TABLE}.business_use_description ;;
  }

  dimension: car_pool {
    hidden: yes
    type: string
    sql: ${TABLE}.car_pool ;;
  }

  dimension: carpooldays {
    hidden: yes
    type: number
    sql: ${TABLE}.carpooldays ;;
  }

  dimension: ccs {
    hidden: yes
    type: number
    sql: ${TABLE}.ccs ;;
  }

  dimension: cctype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.cctype_id ;;
  }

  dimension: circular_number {
    hidden: yes
    type: string
    sql: ${TABLE}.circular_number ;;
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

  dimension: classcodeclassiilength {
    hidden: yes
    type: string
    sql: ${TABLE}.classcodeclassiilength ;;
  }

  dimension: classcodeclassiiwatercrafttype {
    hidden: yes
    type: string
    sql: ${TABLE}.classcodeclassiiwatercrafttype ;;
  }

  dimension: classcodeclassilength {
    hidden: yes
    type: string
    sql: ${TABLE}.classcodeclassilength ;;
  }

  dimension: classcodeclassiwatercrafttype {
    hidden: yes
    type: string
    sql: ${TABLE}.classcodeclassiwatercrafttype ;;
  }

  dimension: collisiontype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.collisiontype_id ;;
  }

  dimension: comp_auto {
    hidden: yes
    type: string
    sql: ${TABLE}.comp_auto ;;
  }

  dimension: comp_coll_only {
    hidden: yes
    type: string
    sql: ${TABLE}.comp_coll_only ;;
  }

  dimension: comp_surcharge {
    hidden: yes
    type: string
    sql: ${TABLE}.comp_surcharge ;;
  }

  dimension: comp_surcharge_fee {
    hidden: yes
    type: string
    sql: ${TABLE}.comp_surcharge_fee ;;
  }

  dimension: company_car {
    hidden: yes
    type: string
    sql: ${TABLE}.company_car ;;
  }

  dimension: companyvehicle_num {
    hidden: yes
    type: number
    sql: ${TABLE}.companyvehicle_num ;;
  }

  dimension: componly {
    hidden: yes
    type: string
    sql: ${TABLE}.componly ;;
  }

  dimension: cost_new {
    label: "Cost New"
    type: string
    sql: ${TABLE}.cost_new ;;
  }

  dimension: cost_used {
    hidden: yes
    type: string
    sql: ${TABLE}.cost_used ;;
  }

  dimension: county {
    hidden: yes
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: cov_prop {
    hidden: yes
    type: string
    sql: ${TABLE}.cov_prop ;;
  }

  dimension: coveragetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coveragetype_id ;;
  }

  dimension: ctr_cov_eliminated_liability {
    hidden: yes
    type: string
    sql: ${TABLE}.ctr_cov_eliminated_liability ;;
  }

  dimension: ctr_cov_eliminated_physical_damage {
    hidden: yes
    type: string
    sql: ${TABLE}.ctr_cov_eliminated_physical_damage ;;
  }

  dimension: ctr_cov_involved_liability {
    hidden: yes
    type: string
    sql: ${TABLE}.ctr_cov_involved_liability ;;
  }

  dimension: ctr_cov_involved_physical_damage {
    hidden: yes
    type: string
    sql: ${TABLE}.ctr_cov_involved_physical_damage ;;
  }

  dimension: curb_weight {
    hidden: yes
    type: number
    sql: ${TABLE}.curb_weight ;;
  }

  dimension: cust_equip {
    hidden: yes
    type: string
    sql: ${TABLE}.cust_equip ;;
  }

  dimension: cylinders {
    label: "Cylinders"
    type: string
    sql: ${TABLE}.cylinders ;;
  }

  dimension: damage {
    hidden: yes
    type: string
    sql: ${TABLE}.damage ;;
  }

  dimension: damage_remarks {
    hidden: yes
    type: string
    sql: ${TABLE}.damage_remarks ;;
  }

  dimension: damage_yesno_id {
    label: "Damage (Y/N)"
    type: string
    sql: case when ${TABLE}.damage_yesno_id=2 then 'No' else (case when ${TABLE}.damage_yesno_id=1 then 'Yes' else NULL end) end ;;
  }

  dimension: day_run_light_id {
    hidden: yes
    type: number
    sql: ${TABLE}.day_run_light_id ;;
  }

  dimension: daylightamt {
    hidden: yes
    type: number
    sql: ${TABLE}.daylightamt ;;
  }

  dimension: daylightper {
    hidden: yes
    type: string
    sql: ${TABLE}.daylightper ;;
  }

  dimension: days {
    hidden: yes
    type: number
    sql: ${TABLE}.days ;;
  }

  dimension: days_lapsed {
    hidden: yes
    type: number
    sql: ${TABLE}.days_lapsed ;;
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

  dimension: display_num {
    hidden: yes
    type: number
    sql: ${TABLE}.display_num ;;
  }

  dimension: dmv_fee {
    hidden: yes
    type: string
    sql: ${TABLE}.dmv_fee ;;
  }

  dimension: dmv_fee_amount {
    hidden: yes
    type: string
    sql: ${TABLE}.dmv_fee_amount ;;
  }

  dimension: driver_assign_id {
    hidden: yes
    type: number
    sql: ${TABLE}.driver_assign_id ;;
  }

  dimension: driver_out_of_state_surcharge {
    hidden: yes
    type: string
    sql: ${TABLE}.driver_out_of_state_surcharge ;;
  }

  dimension: drivertrainamt {
    hidden: yes
    type: string
    sql: ${TABLE}.drivertrainamt ;;
  }

  dimension: drivertrainper {
    hidden: yes
    type: string
    sql: ${TABLE}.drivertrainper ;;
  }

  dimension: drivetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.drivetype_id ;;
  }

  dimension_group: eff {
    label: "Effective"
    type: time
    timeframes: [
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

  dimension: electronicstabilitytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.electronicstabilitytype_id ;;
  }

  dimension: etched_glass {
    hidden: yes
    type: string
    sql: ${TABLE}.etched_glass ;;
  }

  dimension: excess_rate {
    hidden: yes
    type: string
    sql: ${TABLE}.excess_rate ;;
  }

  dimension: excess_rate_reason {
    hidden: yes
    type: string
    sql: ${TABLE}.excess_rate_reason ;;
  }

  dimension: excluded_designated_vehicle {
    hidden: yes
    type: string
    sql: ${TABLE}.excluded_designated_vehicle ;;
  }

  dimension: exclusions_apply {
    hidden: yes
    type: string
    sql: ${TABLE}.exclusions_apply ;;
  }

  dimension: experiencecredit_id {
    hidden: yes
    type: number
    sql: ${TABLE}.experiencecredit_id ;;
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

  dimension: extra_auto {
    hidden: yes
    type: string
    sql: ${TABLE}.extra_auto ;;
  }

  dimension: extra_hazard {
    hidden: yes
    type: string
    sql: ${TABLE}.extra_hazard ;;
  }

  dimension: extra_hazardous {
    hidden: yes
    type: string
    sql: ${TABLE}.extra_hazardous ;;
  }

  dimension: farmusecodetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.farmusecodetype_id ;;
  }

  dimension: fire_island {
    hidden: yes
    type: string
    sql: ${TABLE}.fire_island ;;
  }

  dimension_group: first_added {
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
    sql: ${TABLE}.first_added_date ;;
  }

  dimension: fueltank_id {
    hidden: yes
    type: number
    sql: ${TABLE}.fueltank_id ;;
  }

  dimension: furnished_name {
    hidden: yes
    type: string
    sql: ${TABLE}.furnished_name ;;
  }

  dimension: garage {
    label: "Garage (Y/N)"
    type: string
    sql: case when ${TABLE}.garage=1 then 'Yes' else 'No' end ;;
  }

  dimension: good_driver_percentage {
    hidden: yes
    type: string
    sql: ${TABLE}.good_driver_percentage ;;
  }

  dimension: govt_use {
    hidden: yes
    type: string
    sql: ${TABLE}.govt_use ;;
  }

  dimension: gvw {
    label: "GVW"
    type: number
    sql: ${TABLE}.gvw ;;
  }

  dimension: height {
    hidden: yes
    type: string
    sql: ${TABLE}.height ;;
  }

  dimension: hired_autos_specified_as_covered_autos_you_own {
    hidden: yes
    type: string
    sql: ${TABLE}.hired_autos_specified_as_covered_autos_you_own ;;
  }

  dimension: homing_device {
    hidden: yes
    type: string
    sql: ${TABLE}.homing_device ;;
  }

  dimension: horsepower_id {
    hidden: yes
    type: number
    sql: ${TABLE}.horsepower_id ;;
  }

  dimension: hpcctype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hpcctype_id ;;
  }

  dimension: hullamountused {
    hidden: yes
    type: string
    sql: ${TABLE}.hullamountused ;;
  }

  dimension: hullclassiiinsuredvalueofboat {
    hidden: yes
    type: string
    sql: ${TABLE}.hullclassiiinsuredvalueofboat ;;
  }

  dimension: hullclassiinsuredvalue {
    hidden: yes
    type: string
    sql: ${TABLE}.hullclassiinsuredvalue ;;
  }

  dimension: hullclassiireplacementcostestimate {
    hidden: yes
    type: string
    sql: ${TABLE}.hullclassiireplacementcostestimate ;;
  }

  dimension: hullcostnew {
    hidden: yes
    type: string
    sql: ${TABLE}.hullcostnew ;;
  }

  dimension: hulldeductibleclassi_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hulldeductibleclassi_id ;;
  }

  dimension: hulldeductibleclassii_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hulldeductibleclassii_id ;;
  }

  dimension: hulldesign_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hulldesign_id ;;
  }

  dimension: hulllength {
    hidden: yes
    type: string
    sql: ${TABLE}.hulllength ;;
  }

  dimension: hullmanufacturer {
    hidden: yes
    type: string
    sql: ${TABLE}.hullmanufacturer ;;
  }

  dimension: hullmaterial_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hullmaterial_id ;;
  }

  dimension: hullmodel {
    hidden: yes
    type: string
    sql: ${TABLE}.hullmodel ;;
  }

  dimension: hullserialnumber {
    hidden: yes
    type: string
    sql: ${TABLE}.hullserialnumber ;;
  }

  dimension: hulltype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hulltype_id ;;
  }

  dimension: hulltypeclassi_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hulltypeclassi_id ;;
  }

  dimension: hulltypeclassii_id {
    hidden: yes
    type: number
    sql: ${TABLE}.hulltypeclassii_id ;;
  }

  dimension: hullyear {
    hidden: yes
    type: number
    sql: ${TABLE}.hullyear ;;
  }

  dimension: increasedaccamt {
    hidden: yes
    type: string
    sql: ${TABLE}.increasedaccamt ;;
  }

  dimension: increasedperprop {
    hidden: yes
    type: string
    sql: ${TABLE}.increasedperprop ;;
  }

  dimension: inexpopamt {
    hidden: yes
    type: string
    sql: ${TABLE}.inexpopamt ;;
  }

  dimension: inexpopper {
    hidden: yes
    type: string
    sql: ${TABLE}.inexpopper ;;
  }

  dimension: irf_liability_prorata {
    hidden: yes
    type: string
    sql: ${TABLE}.irf_liability_prorata ;;
  }

  dimension: irf_physicaldamage_prorata {
    hidden: yes
    type: string
    sql: ${TABLE}.irf_physicaldamage_prorata ;;
  }

  dimension: iso_body_style {
    hidden: yes
    type: string
    sql: ${TABLE}.iso_body_style ;;
  }

  dimension: isocollisionfactor {
    hidden: yes
    type: number
    sql: ${TABLE}.isocollisionfactor ;;
  }

  dimension: isocollisionsymbol {
    hidden: yes
    type: number
    sql: ${TABLE}.isocollisionsymbol ;;
  }

  dimension: isocompfactor {
    hidden: yes
    type: number
    sql: ${TABLE}.isocompfactor ;;
  }

  dimension: isocompsymbol {
    hidden: yes
    type: number
    sql: ${TABLE}.isocompsymbol ;;
  }

  dimension: isoliabilityfactor {
    hidden: yes
    type: number
    sql: ${TABLE}.isoliabilityfactor ;;
  }

  dimension: isoliabilitysymbol {
    hidden: yes
    type: number
    sql: ${TABLE}.isoliabilitysymbol ;;
  }

  dimension: isopipmedpayfactor {
    hidden: yes
    type: number
    sql: ${TABLE}.isopipmedpayfactor ;;
  }

  dimension: isopipmedpaysymbol {
    hidden: yes
    type: number
    sql: ${TABLE}.isopipmedpaysymbol ;;
  }

  dimension: joint_owned {
    hidden: yes
    type: string
    sql: ${TABLE}.joint_owned ;;
  }

  dimension: layup_credit {
    hidden: yes
    type: string
    sql: ${TABLE}.layup_credit ;;
  }

  dimension: length {
    hidden: yes
    type: number
    sql: ${TABLE}.length ;;
  }

  dimension: liability {
    hidden: yes
    type: string
    sql: ${TABLE}.liability ;;
  }

  dimension: liability_circular_number {
    hidden: yes
    type: string
    sql: ${TABLE}.liability_circular_number ;;
  }

  dimension: liability_class_code {
    hidden: yes
    type: string
    sql: ${TABLE}.liability_class_code ;;
  }

  dimension: liability_normal_premium {
    hidden: yes
    type: string
    sql: ${TABLE}.liability_normal_premium ;;
  }

  dimension: liabilityamount {
    hidden: yes
    type: string
    sql: ${TABLE}.liabilityamount ;;
  }

  dimension: liabilityctr {
    hidden: yes
    type: string
    sql: ${TABLE}.liabilityctr ;;
  }

  dimension: liabilitydescription {
    hidden: yes
    type: string
    sql: ${TABLE}.liabilitydescription ;;
  }

  dimension: liabilityirf {
    hidden: yes
    type: string
    sql: ${TABLE}.liabilityirf ;;
  }

  dimension: liabilitynone {
    hidden: yes
    type: string
    sql: ${TABLE}.liabilitynone ;;
  }

  dimension: liabilitysurchargegroup_id {
    hidden: yes
    type: number
    sql: ${TABLE}.liabilitysurchargegroup_id ;;
  }

  dimension: license {
    hidden: yes
    type: string
    sql: ${TABLE}.license ;;
  }

  dimension: license_plate_number {
    hidden: yes
    type: string
    sql: ${TABLE}.license_plate_number ;;
  }

  dimension: license_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.license_state_id ;;
  }

  dimension: linknumber {
    hidden: yes
    type: string
    sql: ${TABLE}.linknumber ;;
  }

  dimension: lossfreetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.lossfreetype_id ;;
  }

  dimension: low_mileage {
    hidden: yes
    type: string
    sql: ${TABLE}.low_mileage ;;
  }

  dimension: lpmp_circular_indicator {
    hidden: yes
    type: string
    sql: ${TABLE}.lpmp_circular_indicator ;;
  }

  dimension_group: lpmp_symbol_distribution {
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
    sql: ${TABLE}.lpmp_symbol_distribution_date ;;
  }

  dimension: make {
    label: "Make"
    type: string
    sql: ${TABLE}.make ;;
  }

  dimension: manual_assign {
    hidden: yes
    type: string
    sql: ${TABLE}.manual_assign ;;
  }

  dimension: manual_class {
    hidden: yes
    type: string
    sql: ${TABLE}.manual_class ;;
  }

  dimension: manual_youth_operator {
    hidden: yes
    type: string
    sql: ${TABLE}.manual_youth_operator ;;
  }

  dimension: manualyouthfuloperator {
    hidden: yes
    type: number
    sql: ${TABLE}.manualyouthfuloperator ;;
  }

  dimension: market_value {
    hidden: yes
    type: string
    sql: ${TABLE}.market_value ;;
  }

  dimension: mccacollectionfee_amount {
    hidden: yes
    type: string
    sql: ${TABLE}.mccacollectionfee_amount ;;
  }

  dimension: mccacollectionfeetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.mccacollectionfeetype_id ;;
  }

  dimension: miles {
    label: "Miles"
    type: number
    sql: ${TABLE}.miles ;;
  }

  dimension: minor_violations_surcharge_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.minor_violations_surcharge_pct ;;
  }

  dimension: model {
    label: "Model"
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension_group: motorcycle_layupbegin {
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
    sql: ${TABLE}.motorcycle_layupbegin ;;
  }

  dimension_group: motorcycle_layupend {
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
    sql: ${TABLE}.motorcycle_layupend ;;
  }

  dimension: motorcycle_layupmonths {
    hidden: yes
    type: number
    sql: ${TABLE}.motorcycle_layupmonths ;;
  }

  dimension: motorcycle_racingmodified {
    hidden: yes
    type: string
    sql: ${TABLE}.motorcycle_racingmodified ;;
  }

  dimension: motorcycle_rider_training_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.motorcycle_rider_training_disc ;;
  }

  dimension: motorcyclelayuptype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.motorcyclelayuptype_id ;;
  }

  dimension: motorhome_rented {
    hidden: yes
    type: string
    sql: ${TABLE}.motorhome_rented ;;
  }

  dimension: multi_car {
    type: string
    sql: case when ${TABLE}.multi_car='true' then 'Yes' else 'No' end ;;
  }

  dimension: multi_car_override {
    hidden: yes
    type: string
    sql: ${TABLE}.multi_car_override ;;
  }

  dimension: multi_policy_disc_amt {
    hidden: yes
    type: string
    sql: ${TABLE}.multi_policy_disc_amt ;;
  }

  dimension: multi_policy_disc_per {
    hidden: yes
    type: number
    sql: ${TABLE}.multi_policy_disc_per ;;
  }

  dimension: multicaramt {
    hidden: yes
    type: number
    sql: ${TABLE}.multicaramt ;;
  }

  dimension: multicarper {
    hidden: yes
    type: string
    sql: ${TABLE}.multicarper ;;
  }

  dimension: navigationallimit_id {
    hidden: yes
    type: number
    sql: ${TABLE}.navigationallimit_id ;;
  }

  dimension: non_iso_rating_symbol {
    hidden: yes
    type: string
    sql: ${TABLE}.non_iso_rating_symbol ;;
  }

  dimension: non_iso_symbol {
    hidden: yes
    type: string
    sql: ${TABLE}.non_iso_symbol ;;
  }

  dimension: non_owned {
    hidden: yes
    type: string
    sql: ${TABLE}.non_owned ;;
  }

  dimension: nonowned_extended {
    hidden: yes
    type: string
    sql: ${TABLE}.nonowned_extended ;;
  }

  dimension: nonowned_named {
    hidden: yes
    type: string
    sql: ${TABLE}.nonowned_named ;;
  }

  dimension: nonowned_named_specificvehicle {
    hidden: yes
    type: string
    sql: ${TABLE}.nonowned_named_specificvehicle ;;
  }

  dimension: occ_1_id {
    hidden: yes
    type: number
    sql: ${TABLE}.occ_1_id ;;
  }

  dimension: occ_2_id {
    hidden: yes
    type: number
    sql: ${TABLE}.occ_2_id ;;
  }

  dimension: occ_3_id {
    hidden: yes
    type: number
    sql: ${TABLE}.occ_3_id ;;
  }

  dimension: occasional_1_driver_percent {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_1_driver_percent ;;
  }

  dimension: occasional_1_num {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_1_num ;;
  }

  dimension: occasional_1_numpct {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_1_numpct ;;
  }

  dimension: occasional_2_driver_percent {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_2_driver_percent ;;
  }

  dimension: occasional_2_num {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_2_num ;;
  }

  dimension: occasional_2_numpct {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_2_numpct ;;
  }

  dimension: occasional_3_driver_percent {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_3_driver_percent ;;
  }

  dimension: occasional_3_num {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_3_num ;;
  }

  dimension: occasional_3_numpct {
    hidden: yes
    type: number
    sql: ${TABLE}.occasional_3_numpct ;;
  }

  dimension: odometer {
    hidden: yes
    type: number
    sql: ${TABLE}.odometer ;;
  }

  dimension: operatoragetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.operatoragetype_id ;;
  }

  dimension: otherfueltankdescription {
    hidden: yes
    type: string
    sql: ${TABLE}.otherfueltankdescription ;;
  }

  dimension: otherhulldescription {
    hidden: yes
    type: string
    sql: ${TABLE}.otherhulldescription ;;
  }

  dimension: otherhulldesigndescription {
    hidden: yes
    type: string
    sql: ${TABLE}.otherhulldesigndescription ;;
  }

  dimension: otherhullmaterialdescription {
    hidden: yes
    type: string
    sql: ${TABLE}.otherhullmaterialdescription ;;
  }

  dimension: othermotordescription {
    hidden: yes
    type: string
    sql: ${TABLE}.othermotordescription ;;
  }

  dimension: othernavigation {
    hidden: yes
    type: string
    sql: ${TABLE}.othernavigation ;;
  }

  dimension: otherpowerdescription {
    hidden: yes
    type: string
    sql: ${TABLE}.otherpowerdescription ;;
  }

  dimension: override_vin {
    hidden: yes
    type: string
    sql: ${TABLE}.override_vin ;;
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

  dimension: passrestamt {
    hidden: yes
    type: number
    sql: ${TABLE}.passrestamt ;;
  }

  dimension: passrestper {
    hidden: yes
    type: string
    sql: ${TABLE}.passrestper ;;
  }

  dimension: payload_capacity {
    hidden: yes
    type: string
    sql: ${TABLE}.payload_capacity ;;
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

  dimension: performance_info {
    hidden: yes
    type: string
    sql: ${TABLE}.performance_info ;;
  }

  dimension: performancetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.performancetype_id ;;
  }

  dimension: personalpropertyamount {
    hidden: yes
    type: string
    sql: ${TABLE}.personalpropertyamount ;;
  }

  dimension: personalpropertydescription {
    hidden: yes
    type: string
    sql: ${TABLE}.personalpropertydescription ;;
  }

  dimension: personsinhousehold_id {
    hidden: yes
    type: number
    sql: ${TABLE}.personsinhousehold_id ;;
  }

  dimension: photoinspect {
    hidden: yes
    type: number
    sql: ${TABLE}.photoinspect ;;
  }

  dimension_group: photoinspection {
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
    sql: ${TABLE}.photoinspection ;;
  }

  dimension: physical_damage {
    hidden: yes
    type: string
    sql: ${TABLE}.physical_damage ;;
  }

  dimension: physical_damage_class_code {
    hidden: yes
    type: string
    sql: ${TABLE}.physical_damage_class_code ;;
  }

  dimension: physicaldamage_normal_premium {
    hidden: yes
    type: string
    sql: ${TABLE}.physicaldamage_normal_premium ;;
  }

  dimension: physicaldamageamount {
    hidden: yes
    type: string
    sql: ${TABLE}.physicaldamageamount ;;
  }

  dimension: physicaldamagectr {
    hidden: yes
    type: string
    sql: ${TABLE}.physicaldamagectr ;;
  }

  dimension: physicaldamagedescription {
    hidden: yes
    type: string
    sql: ${TABLE}.physicaldamagedescription ;;
  }

  dimension: physicaldamagegroup_id {
    hidden: yes
    type: number
    sql: ${TABLE}.physicaldamagegroup_id ;;
  }

  dimension: physicaldamageirf {
    hidden: yes
    type: string
    sql: ${TABLE}.physicaldamageirf ;;
  }

  dimension: physicaldamagenone {
    hidden: yes
    type: string
    sql: ${TABLE}.physicaldamagenone ;;
  }

  dimension: pip_classcode {
    hidden: yes
    type: number
    sql: ${TABLE}.pip_classcode ;;
  }

  dimension: piptype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.piptype_id ;;
  }

  dimension: pipworklossperson_id {
    hidden: yes
    type: number
    sql: ${TABLE}.pipworklossperson_id ;;
  }

  dimension: points {
    label: "Points"
    type: number
    sql: ${TABLE}.points ;;
  }

  dimension: points_surcharge_amt {
    hidden: yes
    type: string
    sql: ${TABLE}.points_surcharge_amt ;;
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

  dimension: power_id {
    hidden: yes
    type: number
    sql: ${TABLE}.power_id ;;
  }

  dimension: premium_chg_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_chg_written ;;
  }

  dimension: premium_fullterm {
    label: "Prem-Fullterm"
    type: string
    sql: ${TABLE}.premium_fullterm ;;
  }

  dimension: premium_uim {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_uim ;;
  }

  dimension: premium_um {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_um ;;
  }

  dimension: premium_written {
    hidden: yes
    type: string
    sql: ${TABLE}.premium_written ;;
  }

  dimension: price_new_symbol {
    hidden: yes
    type: number
    sql: ${TABLE}.price_new_symbol ;;
  }

  dimension: princ_driver_id {
    hidden: yes
    type: number
    sql: ${TABLE}.princ_driver_id ;;
  }

  dimension: principal_driver_num {
    label: "Principle Driver Number"
    type: number
    sql: ${TABLE}.principal_driver_num ;;
  }

  dimension: principal_driver_percent {
    label: "Principle Driver Percent"
    type: number
    sql: ${TABLE}.principal_driver_percent ;;
  }

  dimension: principal_numpct {
    hidden: yes
    type: number
    sql: ${TABLE}.principal_numpct ;;
  }

  dimension: prior_insurance_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.prior_insurance_disc ;;
  }

  dimension: prior_months_with_company {
    hidden: yes
    type: number
    sql: ${TABLE}.prior_months_with_company ;;
  }

  dimension_group: purchased {
    label: "Purchased"
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.purchased_date ;;
  }

  dimension: rated_occ_driver_num {
    hidden: yes
    type: number
    sql: ${TABLE}.rated_occ_driver_num ;;
  }

  dimension: rated_principal_driver_num {
    hidden: yes
    type: number
    sql: ${TABLE}.rated_principal_driver_num ;;
  }

  dimension: rcposimportedvehicle_id {
    hidden: yes
    type: number
    sql: ${TABLE}.rcposimportedvehicle_id ;;
  }

  dimension: registered {
    hidden: yes
    type: string
    sql: ${TABLE}.registered ;;
  }

  dimension: registered_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.registered_state_id ;;
  }

  dimension: rejectionpipworkloss_id {
    hidden: yes
    type: number
    sql: ${TABLE}.rejectionpipworkloss_id ;;
  }

  dimension: replacement_vehicle {
    hidden: yes
    type: string
    sql: ${TABLE}.replacement_vehicle ;;
  }

  dimension: restraint_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.restraint_disc ;;
  }

  dimension: restraint_disc_pct {
    hidden: yes
    type: number
    sql: ${TABLE}.restraint_disc_pct ;;
  }

  dimension: restraint_id {
    hidden: yes
    type: number
    sql: ${TABLE}.restraint_id ;;
  }

  dimension: restrainttype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.restrainttype_id ;;
  }

  dimension: restricted_vehicle {
    hidden: yes
    type: string
    sql: ${TABLE}.restricted_vehicle ;;
  }

  dimension: rollover_disc {
    hidden: yes
    type: string
    sql: ${TABLE}.rollover_disc ;;
  }

  dimension: seatbelt {
    hidden: yes
    type: string
    sql: ${TABLE}.seatbelt ;;
  }

  dimension: stability_info {
    hidden: yes
    type: string
    sql: ${TABLE}.stability_info ;;
  }

  dimension: stated_amt {
    label: "Stated Amount"
    type: string
    sql: ${TABLE}.stated_amt ;;
  }

  dimension: suppspousalliability_premium {
    hidden: yes
    type: string
    sql: ${TABLE}.suppspousalliability_premium ;;
  }

  dimension: suspend {
    hidden: yes
    type: string
    sql: ${TABLE}.suspend ;;
  }

  dimension: suspend_coverage {
    hidden: yes
    type: string
    sql: ${TABLE}.suspend_coverage ;;
  }

  dimension: symbol {
    hidden: yes
    type: number
    sql: ${TABLE}.symbol ;;
  }

  dimension: symbol_override {
    hidden: yes
    type: string
    sql: ${TABLE}.symbol_override ;;
  }

  dimension: territory_num {
    label: "Territory Number"
    type: number
    sql: ${TABLE}.territory_num ;;
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

  dimension: titleholder_info {
    hidden: yes
    type: string
    sql: ${TABLE}.titleholder_info ;;
  }

  dimension: tonnage_info {
    hidden: yes
    type: string
    sql: ${TABLE}.tonnage_info ;;
  }

  dimension: totalhp {
    hidden: yes
    type: number
    sql: ${TABLE}.totalhp ;;
  }

  dimension: trailer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.trailer_id ;;
  }

  dimension: traileramount {
    hidden: yes
    type: string
    sql: ${TABLE}.traileramount ;;
  }

  dimension: trailerlength {
    hidden: yes
    type: number
    sql: ${TABLE}.trailerlength ;;
  }

  dimension: trailermanufacturer {
    hidden: yes
    type: string
    sql: ${TABLE}.trailermanufacturer ;;
  }

  dimension: trailermodel {
    hidden: yes
    type: string
    sql: ${TABLE}.trailermodel ;;
  }

  dimension: trailerserialnumber {
    hidden: yes
    type: string
    sql: ${TABLE}.trailerserialnumber ;;
  }

  dimension: traileryear {
    hidden: yes
    type: number
    sql: ${TABLE}.traileryear ;;
  }

  dimension: uim {
    hidden: yes
    type: string
    sql: ${TABLE}.uim ;;
  }

  dimension: um {
    hidden: yes
    type: string
    sql: ${TABLE}.um ;;
  }

  dimension: unacceptable_risk {
    hidden: yes
    type: string
    sql: ${TABLE}.unacceptable_risk ;;
  }

  dimension: used_in_business {
    hidden: yes
    type: string
    sql: ${TABLE}.used_in_business ;;
  }

  dimension: valuationmethodtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.valuationmethodtype_id ;;
  }

  dimension: vehicle_display_num {
    hidden: yes
    type: number
    sql: ${TABLE}.vehicle_display_num ;;
  }

  dimension: vehicle_num {
    label: "Number"
    type: number
    sql: ${TABLE}.vehicle_num ;;
  }

  dimension: vehicle_type {
    hidden: yes
    type: string
    sql: ${TABLE}.vehicle_type ;;
  }

  dimension: vehicleannualmilestype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.vehicleannualmilestype_id ;;
  }

  dimension: vehicleratingtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.vehicleratingtype_id ;;
  }

  dimension: vehicletype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.vehicletype_id ;;
  }

  dimension: vehicleusagetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.vehicleusagetype_id ;;
  }

  dimension: vehicleusetype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.vehicleusetype_id ;;
  }

  dimension: vehiclevalue_id {
    hidden: yes
    type: number
    sql: ${TABLE}.vehiclevalue_id ;;
  }

  dimension: vin {
    label: "VIN"
    type: string
    sql: ${TABLE}.vin ;;
  }

  dimension: vin_override {
    hidden: yes
    type: string
    sql: ${TABLE}.vin_override ;;
  }

  dimension: waive_vehicle_inspection {
    hidden: yes
    type: string
    sql: ${TABLE}.waive_vehicle_inspection ;;
  }

  dimension: waivevehicleinspectionreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.waivevehicleinspectionreason_id ;;
  }

  dimension: warp_id {
    hidden: yes
    type: string
    sql: ${TABLE}.warp_id ;;
  }

  dimension: weeks {
    hidden: yes
    type: number
    sql: ${TABLE}.weeks ;;
  }

  dimension: worklossamt {
    hidden: yes
    type: string
    sql: ${TABLE}.worklossamt ;;
  }

  dimension: worklossper {
    hidden: yes
    type: string
    sql: ${TABLE}.worklossper ;;
  }

  dimension: year {
    label: "Year"
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: [furnished_name]
  }
}

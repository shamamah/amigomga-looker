view: vehicle {
  sql_table_name: vehicle
        ;;


    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: vehicle_num {
      type: number
      sql: ${TABLE}.vehicle_num ;;
    }

    dimension: eff_date {
      type: date
      sql: ${TABLE}.eff_date ;;
    }

    dimension: premium_fullterm {
      type: string
      sql: ${TABLE}.premium_fullterm ;;
    }

    dimension: premium_written {
      type: string
      sql: ${TABLE}.premium_written ;;
    }

    dimension: premium_chg_written {
      type: string
      sql: ${TABLE}.premium_chg_written ;;
    }

    dimension: year {
      type: number
      sql: ${TABLE}.year ;;
    }

    dimension: vin {
      type: string
      sql: ${TABLE}.vin ;;
    }

    dimension: make {
      type: string
      sql: ${TABLE}.make ;;
    }

    dimension: model {
      type: string
      sql: ${TABLE}.model ;;
    }

    dimension: bodytype_id {
      type: number
      sql: ${TABLE}.bodytype_id ;;
    }

    dimension: performancetype_id {
      type: number
      sql: ${TABLE}.performancetype_id ;;
    }

    dimension: symbol {
      type: number
      sql: ${TABLE}.symbol ;;
    }

    dimension: territory_num {
      type: number
      sql: ${TABLE}.territory_num ;;
    }

    dimension: class_code {
      type: string
      sql: ${TABLE}.class_code ;;
    }

    dimension: vehicleusetype_id {
      type: number
      sql: ${TABLE}.vehicleusetype_id ;;
    }

    dimension: miles {
      type: number
      sql: ${TABLE}.miles ;;
    }

    dimension: days {
      type: number
      sql: ${TABLE}.days ;;
    }

    dimension: annual_miles {
      type: number
      sql: ${TABLE}.annual_miles ;;
    }

    dimension: principal_driver_num {
      type: number
      sql: ${TABLE}.principal_driver_num ;;
    }

    dimension: occasional_1_num {
      type: number
      sql: ${TABLE}.occasional_1_num ;;
    }

    dimension: occasional_2_num {
      type: number
      sql: ${TABLE}.occasional_2_num ;;
    }

    dimension: occasional_3_num {
      type: number
      sql: ${TABLE}.occasional_3_num ;;
    }

    dimension: license {
      type: string
      sql: ${TABLE}.license ;;
    }

    dimension: license_state_id {
      type: number
      sql: ${TABLE}.license_state_id ;;
    }

    dimension: detailstatuscode_id {
      type: number
      sql: ${TABLE}.detailstatuscode_id ;;
    }

    dimension: points {
      type: number
      sql: ${TABLE}.points ;;
    }

    dimension: cost_new {
      type: string
      sql: ${TABLE}.cost_new ;;
    }

    dimension: cust_equip {
      type: string
      sql: ${TABLE}.cust_equip ;;
    }

    dimension: cov_prop {
      type: string
      sql: ${TABLE}.cov_prop ;;
    }

    dimension: stated_amt {
      type: string
      sql: ${TABLE}.stated_amt ;;
    }

    dimension: multi_car {
      type: string
      sql: ${TABLE}.multi_car ;;
    }

    dimension: car_pool {
      type: string
      sql: ${TABLE}.car_pool ;;
    }

    dimension: odometer {
      type: number
      sql: ${TABLE}.odometer ;;
    }

    dimension: restrainttype_id {
      type: number
      sql: ${TABLE}.restrainttype_id ;;
    }

    dimension: antilocktype_id {
      type: number
      sql: ${TABLE}.antilocktype_id ;;
    }

    dimension: antithefttype_id {
      type: number
      sql: ${TABLE}.antithefttype_id ;;
    }

    dimension: extra_auto {
      type: string
      sql: ${TABLE}.extra_auto ;;
    }

    dimension: comp_auto {
      type: string
      sql: ${TABLE}.comp_auto ;;
    }

    dimension: external_id {
      type: string
      sql: ${TABLE}.external_id ;;
    }

    dimension: warp_id {
      type: string
      sql: ${TABLE}.warp_id ;;
    }

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension: companyvehicle_num {
      type: number
      sql: ${TABLE}.companyvehicle_num ;;
    }

    dimension: nonowned_extended {
      type: string
      sql: ${TABLE}.nonowned_extended ;;
    }

    dimension: nonowned_named {
      type: string
      sql: ${TABLE}.nonowned_named ;;
    }

    dimension_group: purchased_date {
      type: time
      sql: ${TABLE}.purchased_date ;;
    }

    dimension: motorcycle_layupmonths {
      type: number
      sql: ${TABLE}.motorcycle_layupmonths ;;
    }

    dimension: prior_insurance_disc {
      type: string
      sql: ${TABLE}.prior_insurance_disc ;;
    }

    dimension: antitheft_disc {
      type: string
      sql: ${TABLE}.antitheft_disc ;;
    }

    dimension: restraint_disc {
      type: string
      sql: ${TABLE}.restraint_disc ;;
    }

    dimension: rollover_disc {
      type: string
      sql: ${TABLE}.rollover_disc ;;
    }

    dimension: liability {
      type: string
      sql: ${TABLE}.liability ;;
    }

    dimension: physical_damage {
      type: string
      sql: ${TABLE}.physical_damage ;;
    }

    dimension: extra_hazardous {
      type: string
      sql: ${TABLE}.extra_hazardous ;;
    }

    dimension: bodystyle_id {
      type: number
      sql: ${TABLE}.bodystyle_id ;;
    }

    dimension: horsepower_id {
      type: number
      sql: ${TABLE}.horsepower_id ;;
    }

    dimension: market_value {
      type: string
      sql: ${TABLE}.market_value ;;
    }

    dimension: registered {
      type: string
      sql: ${TABLE}.registered ;;
    }

    dimension: suspend_coverage {
      type: string
      sql: ${TABLE}.suspend_coverage ;;
    }

    dimension: manual_youth_operator {
      type: string
      sql: ${TABLE}.manual_youth_operator ;;
    }

    dimension: weeks {
      type: number
      sql: ${TABLE}.weeks ;;
    }

    dimension: principal_driver_percent {
      type: number
      sql: ${TABLE}.principal_driver_percent ;;
    }

    dimension: occasional_1_driver_percent {
      type: number
      sql: ${TABLE}.occasional_1_driver_percent ;;
    }

    dimension: occasional_2_driver_percent {
      type: number
      sql: ${TABLE}.occasional_2_driver_percent ;;
    }

    dimension: occasional_3_driver_percent {
      type: number
      sql: ${TABLE}.occasional_3_driver_percent ;;
    }

    dimension: damage {
      type: string
      sql: ${TABLE}.damage ;;
    }

    dimension: damage_remarks {
      type: string
      sql: ${TABLE}.damage_remarks ;;
    }

    dimension: cylinders {
      type: string
      sql: ${TABLE}.cylinders ;;
    }

    dimension: manual_assign {
      type: string
      sql: ${TABLE}.manual_assign ;;
    }

    dimension: length {
      type: number
      sql: ${TABLE}.length ;;
    }

    dimension: liabilitysurchargegroup_id {
      type: number
      sql: ${TABLE}.liabilitysurchargegroup_id ;;
    }

    dimension: physicaldamagegroup_id {
      type: number
      sql: ${TABLE}.physicaldamagegroup_id ;;
    }

    dimension: piptype_id {
      type: number
      sql: ${TABLE}.piptype_id ;;
    }

    dimension: collisiontype_id {
      type: number
      sql: ${TABLE}.collisiontype_id ;;
    }

    dimension: mccacollectionfeetype_id {
      type: number
      sql: ${TABLE}.mccacollectionfeetype_id ;;
    }

    dimension: mccacollectionfee_amount {
      type: string
      sql: ${TABLE}.mccacollectionfee_amount ;;
    }

    dimension: antitheft_disc_amt {
      type: string
      sql: ${TABLE}.antitheft_disc_amt ;;
    }

    dimension: restraint_disc_amt {
      type: string
      sql: ${TABLE}.restraint_disc_amt ;;
    }

    dimension: abs_disc_amt {
      type: string
      sql: ${TABLE}.abs_disc_amt ;;
    }

    dimension: accprev_disc_amt {
      type: string
      sql: ${TABLE}.accprev_disc_amt ;;
    }

    dimension: accident_free_disc_amt {
      type: string
      sql: ${TABLE}.accident_free_disc_amt ;;
    }

    dimension: multi_policy_disc_amt {
      type: string
      sql: ${TABLE}.multi_policy_disc_amt ;;
    }

    dimension: prior_months_with_company {
      type: number
      sql: ${TABLE}.prior_months_with_company ;;
    }

    dimension: days_lapsed {
      type: number
      sql: ${TABLE}.days_lapsed ;;
    }

    dimension: rated_principal_driver_num {
      type: number
      sql: ${TABLE}.rated_principal_driver_num ;;
    }

    dimension: rated_occ_driver_num {
      type: number
      sql: ${TABLE}.rated_occ_driver_num ;;
    }

    dimension: antitheft_disc_pct {
      type: number
      sql: ${TABLE}.antitheft_disc_pct ;;
    }

    dimension: restraint_disc_pct {
      type: number
      sql: ${TABLE}.restraint_disc_pct ;;
    }

    dimension: abs_disc_pct {
      type: number
      sql: ${TABLE}.abs_disc_pct ;;
    }

    dimension: accprev_disc_pct {
      type: number
      sql: ${TABLE}.accprev_disc_pct ;;
    }

    dimension: accident_free_disc_pct {
      type: number
      sql: ${TABLE}.accident_free_disc_pct ;;
    }

    dimension: componly {
      type: string
      sql: ${TABLE}.componly ;;
    }

    dimension: cctype_id {
      type: number
      sql: ${TABLE}.cctype_id ;;
    }

    dimension: lossfreetype_id {
      type: number
      sql: ${TABLE}.lossfreetype_id ;;
    }

    dimension: comp_surcharge_fee {
      type: string
      sql: ${TABLE}.comp_surcharge_fee ;;
    }

    dimension: comp_surcharge {
      type: string
      sql: ${TABLE}.comp_surcharge ;;
    }

    dimension: vehicle_type {
      type: string
      sql: ${TABLE}.vehicle_type ;;
    }

    dimension: minor_violations_surcharge_pct {
      type: number
      sql: ${TABLE}.minor_violations_surcharge_pct ;;
    }

    dimension: additional_equipment {
      type: string
      sql: ${TABLE}.additional_equipment ;;
    }

    dimension: extra_hazard {
      type: string
      sql: ${TABLE}.extra_hazard ;;
    }

    dimension: anti_theft_discount {
      type: string
      sql: ${TABLE}.anti_theft_discount ;;
    }

    dimension: multi_car_override {
      type: string
      sql: ${TABLE}.multi_car_override ;;
    }

    dimension: business_use {
      type: string
      sql: ${TABLE}.business_use ;;
    }

    dimension: business_use_description {
      type: string
      sql: ${TABLE}.business_use_description ;;
    }

    dimension: drivertype_id {
      type: number
      sql: ${TABLE}.drivertype_id ;;
    }

    dimension: vehicleusagetype_id {
      type: number
      sql: ${TABLE}.vehicleusagetype_id ;;
    }

    dimension: garage {
      type: string
      sql: ${TABLE}.garage ;;
    }

    dimension: additional_interest {
      type: string
      sql: ${TABLE}.additional_interest ;;
    }

    dimension: scheduled_items {
      type: string
      sql: ${TABLE}.scheduled_items ;;
    }

    dimension: non_owned {
      type: string
      sql: ${TABLE}.non_owned ;;
    }

    dimension: etched_glass {
      type: string
      sql: ${TABLE}.etched_glass ;;
    }

    dimension: homing_device {
      type: string
      sql: ${TABLE}.homing_device ;;
    }

    dimension: fire_island {
      type: string
      sql: ${TABLE}.fire_island ;;
    }

    dimension: manual_class {
      type: string
      sql: ${TABLE}.manual_class ;;
    }

    dimension: dmv_fee {
      type: string
      sql: ${TABLE}.dmv_fee ;;
    }

    dimension: airbag {
      type: string
      sql: ${TABLE}.airbag ;;
    }

    dimension: class {
      type: string
      sql: ${TABLE}.class ;;
    }

    dimension: veh_load_cap {
      type: string
      sql: ${TABLE}.veh_load_cap ;;
    }

    dimension: passrestper {
      type: string
      sql: ${TABLE}.passrestper ;;
    }

    dimension: antitheftper {
      type: string
      sql: ${TABLE}.antitheftper ;;
    }

    dimension: antilockper {
      type: string
      sql: ${TABLE}.antilockper ;;
    }

    dimension: daylightper {
      type: string
      sql: ${TABLE}.daylightper ;;
    }

    dimension: multicarper {
      type: string
      sql: ${TABLE}.multicarper ;;
    }

    dimension: occ_1_id {
      type: number
      sql: ${TABLE}.occ_1_id ;;
    }

    dimension: driver_assign_id {
      type: number
      sql: ${TABLE}.driver_assign_id ;;
    }

    dimension: princ_driver_id {
      type: number
      sql: ${TABLE}.princ_driver_id ;;
    }

    dimension: occ_2_id {
      type: number
      sql: ${TABLE}.occ_2_id ;;
    }

    dimension: occ_3_id {
      type: number
      sql: ${TABLE}.occ_3_id ;;
    }

    dimension: restraint_id {
      type: number
      sql: ${TABLE}.restraint_id ;;
    }

    dimension: abs_id {
      type: number
      sql: ${TABLE}.abs_id ;;
    }

    dimension: day_run_light_id {
      type: number
      sql: ${TABLE}.day_run_light_id ;;
    }

    dimension: trailer_id {
      type: number
      sql: ${TABLE}.trailer_id ;;
    }

    dimension: photoinspect {
      type: number
      sql: ${TABLE}.photoinspect ;;
    }

    dimension: acv {
      type: number
      sql: ${TABLE}.acv ;;
    }

    dimension: passrestamt {
      type: number
      sql: ${TABLE}.passrestamt ;;
    }

    dimension: antitheftamt {
      type: number
      sql: ${TABLE}.antitheftamt ;;
    }

    dimension: antilockamt {
      type: number
      sql: ${TABLE}.antilockamt ;;
    }

    dimension: daylightamt {
      type: number
      sql: ${TABLE}.daylightamt ;;
    }

    dimension: multicaramt {
      type: number
      sql: ${TABLE}.multicaramt ;;
    }

    dimension_group: photoinspection {
      type: time
      sql: ${TABLE}.photoinspection ;;
    }

    dimension: inexpopper {
      type: string
      sql: ${TABLE}.inexpopper ;;
    }

    dimension: inexpopamt {
      type: string
      sql: ${TABLE}.inexpopamt ;;
    }

    dimension: accconper {
      type: string
      sql: ${TABLE}.accconper ;;
    }

    dimension: accconamt {
      type: string
      sql: ${TABLE}.accconamt ;;
    }

    dimension: accprevamt {
      type: string
      sql: ${TABLE}.accprevamt ;;
    }

    dimension: accprevper {
      type: string
      sql: ${TABLE}.accprevper ;;
    }

    dimension: worklossamt {
      type: string
      sql: ${TABLE}.worklossamt ;;
    }

    dimension: worklossper {
      type: string
      sql: ${TABLE}.worklossper ;;
    }

    dimension: inc_symbol {
      type: number
      sql: ${TABLE}.inc_symbol ;;
    }

    dimension: govt_use {
      type: string
      sql: ${TABLE}.govt_use ;;
    }

    dimension: joint_owned {
      type: string
      sql: ${TABLE}.joint_owned ;;
    }

    dimension: gvw {
      type: number
      sql: ${TABLE}.gvw ;;
    }

    dimension: suspend {
      type: string
      sql: ${TABLE}.suspend ;;
    }

    dimension: vehicle_display_num {
      type: number
      sql: ${TABLE}.vehicle_display_num ;;
    }

    dimension: vehicletype_id {
      type: number
      sql: ${TABLE}.vehicletype_id ;;
    }

    dimension: principal_numpct {
      type: number
      sql: ${TABLE}.principal_numpct ;;
    }

    dimension: occasional_1_numpct {
      type: number
      sql: ${TABLE}.occasional_1_numpct ;;
    }

    dimension: occasional_2_numpct {
      type: number
      sql: ${TABLE}.occasional_2_numpct ;;
    }

    dimension: occasional_3_numpct {
      type: number
      sql: ${TABLE}.occasional_3_numpct ;;
    }

    dimension: assigned_driver_num {
      type: number
      sql: ${TABLE}.assigned_driver_num ;;
    }

    dimension: manualyouthfuloperator {
      type: number
      sql: ${TABLE}.manualyouthfuloperator ;;
    }

    dimension: vehiclevalue_id {
      type: number
      sql: ${TABLE}.vehiclevalue_id ;;
    }

    dimension: hpcctype_id {
      type: number
      sql: ${TABLE}.hpcctype_id ;;
    }

    dimension: excess_rate {
      type: string
      sql: ${TABLE}.excess_rate ;;
    }

    dimension: excess_rate_reason {
      type: string
      sql: ${TABLE}.excess_rate_reason ;;
    }

    dimension: motorcycle_racingmodified {
      type: string
      sql: ${TABLE}.motorcycle_racingmodified ;;
    }

    dimension: layup_credit {
      type: string
      sql: ${TABLE}.layup_credit ;;
    }

    dimension_group: motorcycle_layupbegin {
      type: time
      sql: ${TABLE}.motorcycle_layupbegin ;;
    }

    dimension_group: motorcycle_layupend {
      type: time
      sql: ${TABLE}.motorcycle_layupend ;;
    }

    dimension: motorhome_rented {
      type: string
      sql: ${TABLE}.motorhome_rented ;;
    }

    dimension: drivetype_id {
      type: number
      sql: ${TABLE}.drivetype_id ;;
    }

    dimension: nonowned_named_specificvehicle {
      type: string
      sql: ${TABLE}.nonowned_named_specificvehicle ;;
    }

    dimension: personsinhousehold_id {
      type: number
      sql: ${TABLE}.personsinhousehold_id ;;
    }

    dimension: seatbelt {
      type: string
      sql: ${TABLE}.seatbelt ;;
    }

    dimension: carpooldays {
      type: number
      sql: ${TABLE}.carpooldays ;;
    }

    dimension: rejectionpipworkloss_id {
      type: number
      sql: ${TABLE}.rejectionpipworkloss_id ;;
    }

    dimension: suppspousalliability_premium {
      type: string
      sql: ${TABLE}.suppspousalliability_premium ;;
    }

    dimension: multi_car_disc_amt {
      type: string
      sql: ${TABLE}.multi_car_disc_amt ;;
    }

    dimension: dmv_fee_amount {
      type: string
      sql: ${TABLE}.dmv_fee_amount ;;
    }

    dimension: points_surcharge_amt {
      type: string
      sql: ${TABLE}.points_surcharge_amt ;;
    }

    dimension: restricted_vehicle {
      type: string
      sql: ${TABLE}.restricted_vehicle ;;
    }

    dimension: ccs {
      type: number
      sql: ${TABLE}.ccs ;;
    }

    dimension: motorcyclelayuptype_id {
      type: number
      sql: ${TABLE}.motorcyclelayuptype_id ;;
    }

    dimension: stat_territory {
      type: number
      sql: ${TABLE}.stat_territory ;;
    }

    dimension: registered_state_id {
      type: number
      sql: ${TABLE}.registered_state_id ;;
    }

    dimension: titleholder_info {
      type: string
      sql: ${TABLE}.titleholder_info ;;
    }

    dimension: operatoragetype_id {
      type: number
      sql: ${TABLE}.operatoragetype_id ;;
    }

    dimension: pipworklossperson_id {
      type: number
      sql: ${TABLE}.pipworklossperson_id ;;
    }

    dimension: unacceptable_risk {
      type: string
      sql: ${TABLE}.unacceptable_risk ;;
    }

    dimension: county {
      type: string
      sql: ${TABLE}.county ;;
    }

    dimension: override_vin {
      type: string
      sql: ${TABLE}.override_vin ;;
    }

    dimension: comp_coll_only {
      type: string
      sql: ${TABLE}.comp_coll_only ;;
    }

    dimension: non_iso_symbol {
      type: string
      sql: ${TABLE}.non_iso_symbol ;;
    }

    dimension: multi_policy_disc_per {
      type: number
      sql: ${TABLE}.multi_policy_disc_per ;;
    }

    dimension: motorcycle_rider_training_disc {
      type: string
      sql: ${TABLE}.motorcycle_rider_training_disc ;;
    }

    dimension: liability_class_code {
      type: string
      sql: ${TABLE}.liability_class_code ;;
    }

    dimension: physical_damage_class_code {
      type: string
      sql: ${TABLE}.physical_damage_class_code ;;
    }

    dimension: tiertype_id {
      type: number
      sql: ${TABLE}.tiertype_id ;;
    }

    dimension: used_in_business {
      type: string
      sql: ${TABLE}.used_in_business ;;
    }

    dimension: exclusions_apply {
      type: string
      sql: ${TABLE}.exclusions_apply ;;
    }

    dimension: trailerlength {
      type: number
      sql: ${TABLE}.trailerlength ;;
    }

    dimension: excluded_designated_vehicle {
      type: string
      sql: ${TABLE}.excluded_designated_vehicle ;;
    }

    dimension: um {
      type: string
      sql: ${TABLE}.um ;;
    }

    dimension: uim {
      type: string
      sql: ${TABLE}.uim ;;
    }

    dimension: premium_um {
      type: string
      sql: ${TABLE}.premium_um ;;
    }

    dimension: premium_uim {
      type: string
      sql: ${TABLE}.premium_uim ;;
    }

    dimension: linknumber {
      type: string
      sql: ${TABLE}.linknumber ;;
    }

    dimension: hullyear {
      type: number
      sql: ${TABLE}.hullyear ;;
    }

    dimension: hullmanufacturer {
      type: string
      sql: ${TABLE}.hullmanufacturer ;;
    }

    dimension: hullmodel {
      type: string
      sql: ${TABLE}.hullmodel ;;
    }

    dimension: hulltypeclassi_id {
      type: number
      sql: ${TABLE}.hulltypeclassi_id ;;
    }

    dimension: hulltypeclassii_id {
      type: number
      sql: ${TABLE}.hulltypeclassii_id ;;
    }

    dimension: hullserialnumber {
      type: string
      sql: ${TABLE}.hullserialnumber ;;
    }

    dimension: hulllength_id {
      type: number
      sql: ${TABLE}.hulllength_id ;;
    }

    dimension: hullcostnew {
      type: string
      sql: ${TABLE}.hullcostnew ;;
    }

    dimension: hullamountused {
      type: string
      sql: ${TABLE}.hullamountused ;;
    }

    dimension: hulldeductibleclassi_id {
      type: number
      sql: ${TABLE}.hulldeductibleclassi_id ;;
    }

    dimension: hulldeductibleclassii_id {
      type: number
      sql: ${TABLE}.hulldeductibleclassii_id ;;
    }

    dimension: hullclassiireplacementcostestimate {
      type: string
      sql: ${TABLE}.hullclassiireplacementcostestimate ;;
    }

    dimension: hullclassiiinsuredvalueofboat {
      type: string
      sql: ${TABLE}.hullclassiiinsuredvalueofboat ;;
    }

    dimension: traileryear {
      type: number
      sql: ${TABLE}.traileryear ;;
    }

    dimension: trailerserialnumber {
      type: string
      sql: ${TABLE}.trailerserialnumber ;;
    }

    dimension: traileramount {
      type: string
      sql: ${TABLE}.traileramount ;;
    }

    dimension: accidentdescription {
      type: string
      sql: ${TABLE}.accidentdescription ;;
    }

    dimension: accidentamount {
      type: string
      sql: ${TABLE}.accidentamount ;;
    }

    dimension: personalpropertydescription {
      type: string
      sql: ${TABLE}.personalpropertydescription ;;
    }

    dimension: personalpropertyamount {
      type: string
      sql: ${TABLE}.personalpropertyamount ;;
    }

    dimension: trailermanufacturer {
      type: string
      sql: ${TABLE}.trailermanufacturer ;;
    }

    dimension: experiencecredit_id {
      type: number
      sql: ${TABLE}.experiencecredit_id ;;
    }

    dimension: navigationallimit_id {
      type: number
      sql: ${TABLE}.navigationallimit_id ;;
    }

    dimension: trailermodel {
      type: string
      sql: ${TABLE}.trailermodel ;;
    }

    dimension: increasedaccamt {
      type: string
      sql: ${TABLE}.increasedaccamt ;;
    }

    dimension: increasedperprop {
      type: string
      sql: ${TABLE}.increasedperprop ;;
    }

    dimension: hulllength {
      type: string
      sql: ${TABLE}.hulllength ;;
    }

    dimension: accessorieamount {
      type: string
      sql: ${TABLE}.accessorieamount ;;
    }

    dimension: accessoriedescription {
      type: string
      sql: ${TABLE}.accessoriedescription ;;
    }

    dimension: hullclassiinsuredvalue {
      type: string
      sql: ${TABLE}.hullclassiinsuredvalue ;;
    }

    dimension: liabilityctr {
      type: string
      sql: ${TABLE}.liabilityctr ;;
    }

    dimension: liabilityirf {
      type: string
      sql: ${TABLE}.liabilityirf ;;
    }

    dimension: liabilitydescription {
      type: string
      sql: ${TABLE}.liabilitydescription ;;
    }

    dimension: liabilityamount {
      type: string
      sql: ${TABLE}.liabilityamount ;;
    }

    dimension: physicaldamagectr {
      type: string
      sql: ${TABLE}.physicaldamagectr ;;
    }

    dimension: physicaldamageirf {
      type: string
      sql: ${TABLE}.physicaldamageirf ;;
    }

    dimension: physicaldamagedescription {
      type: string
      sql: ${TABLE}.physicaldamagedescription ;;
    }

    dimension: physicaldamageamount {
      type: string
      sql: ${TABLE}.physicaldamageamount ;;
    }

    dimension: othernavigation {
      type: string
      sql: ${TABLE}.othernavigation ;;
    }

    dimension: liabilitynone {
      type: string
      sql: ${TABLE}.liabilitynone ;;
    }

    dimension: physicaldamagenone {
      type: string
      sql: ${TABLE}.physicaldamagenone ;;
    }

    dimension: othermotordescription {
      type: string
      sql: ${TABLE}.othermotordescription ;;
    }

    dimension: display_num {
      type: number
      sql: ${TABLE}.display_num ;;
    }

    dimension: totalhp {
      type: number
      sql: ${TABLE}.totalhp ;;
    }

    dimension: classcodeclassilength {
      type: string
      sql: ${TABLE}.classcodeclassilength ;;
    }

    dimension: classcodeclassiwatercrafttype {
      type: string
      sql: ${TABLE}.classcodeclassiwatercrafttype ;;
    }

    dimension: classcodeclassiilength {
      type: string
      sql: ${TABLE}.classcodeclassiilength ;;
    }

    dimension: classcodeclassiiwatercrafttype {
      type: string
      sql: ${TABLE}.classcodeclassiiwatercrafttype ;;
    }

    dimension: power_id {
      type: number
      sql: ${TABLE}.power_id ;;
    }

    dimension: otherpowerdescription {
      type: string
      sql: ${TABLE}.otherpowerdescription ;;
    }

    dimension: hulltype_id {
      type: number
      sql: ${TABLE}.hulltype_id ;;
    }

    dimension: otherhulldescription {
      type: string
      sql: ${TABLE}.otherhulldescription ;;
    }

    dimension: hullmaterial_id {
      type: number
      sql: ${TABLE}.hullmaterial_id ;;
    }

    dimension: otherhullmaterialdescription {
      type: string
      sql: ${TABLE}.otherhullmaterialdescription ;;
    }

    dimension: hulldesign_id {
      type: number
      sql: ${TABLE}.hulldesign_id ;;
    }

    dimension: otherhulldesigndescription {
      type: string
      sql: ${TABLE}.otherhulldesigndescription ;;
    }

    dimension: fueltank_id {
      type: number
      sql: ${TABLE}.fueltank_id ;;
    }

    dimension: otherfueltankdescription {
      type: string
      sql: ${TABLE}.otherfueltankdescription ;;
    }

    dimension: coveragetype_id {
      type: number
      sql: ${TABLE}.coveragetype_id ;;
    }

    dimension: classcodetowander {
      type: string
      sql: ${TABLE}.classcodetowander ;;
    }

    dimension: classcodeice {
      type: string
      sql: ${TABLE}.classcodeice ;;
    }

    dimension: classcodejetdrive {
      type: string
      sql: ${TABLE}.classcodejetdrive ;;
    }

    dimension: ctr_cov_eliminated_physical_damage {
      type: string
      sql: ${TABLE}.ctr_cov_eliminated_physical_damage ;;
    }

    dimension: ctr_cov_involved_physical_damage {
      type: string
      sql: ${TABLE}.ctr_cov_involved_physical_damage ;;
    }

    dimension: ctr_cov_eliminated_liability {
      type: string
      sql: ${TABLE}.ctr_cov_eliminated_liability ;;
    }

    dimension: ctr_cov_involved_liability {
      type: string
      sql: ${TABLE}.ctr_cov_involved_liability ;;
    }

    dimension: physicaldamage_normal_premium {
      type: string
      sql: ${TABLE}.physicaldamage_normal_premium ;;
    }

    dimension: liability_normal_premium {
      type: string
      sql: ${TABLE}.liability_normal_premium ;;
    }

    dimension: irf_physicaldamage_prorata {
      type: string
      sql: ${TABLE}.irf_physicaldamage_prorata ;;
    }

    dimension: irf_liability_prorata {
      type: string
      sql: ${TABLE}.irf_liability_prorata ;;
    }

    dimension: extendedproperties_xml {
      type: string
      sql: ${TABLE}.extendedproperties_xml ;;
    }

    dimension: cost_used {
      type: string
      sql: ${TABLE}.cost_used ;;
    }

    dimension: vin_override {
      type: string
      sql: ${TABLE}.vin_override ;;
    }

    dimension: symbol_override {
      type: string
      sql: ${TABLE}.symbol_override ;;
    }

    dimension: classcode_override {
      type: string
      sql: ${TABLE}.classcode_override ;;
    }

    dimension: company_car {
      type: string
      sql: ${TABLE}.company_car ;;
    }

    dimension: isoliabilityfactor {
      type: number
      sql: ${TABLE}.isoliabilityfactor ;;
    }

    dimension: isoliabilitysymbol {
      type: number
      sql: ${TABLE}.isoliabilitysymbol ;;
    }

    dimension: isopipmedpayfactor {
      type: number
      sql: ${TABLE}.isopipmedpayfactor ;;
    }

    dimension: isopipmedpaysymbol {
      type: number
      sql: ${TABLE}.isopipmedpaysymbol ;;
    }

    dimension: non_iso_rating_symbol {
      type: string
      sql: ${TABLE}.non_iso_rating_symbol ;;
    }

    dimension: good_driver_percentage {
      type: string
      sql: ${TABLE}.good_driver_percentage ;;
    }

    dimension: isocollisionfactor {
      type: number
      sql: ${TABLE}.isocollisionfactor ;;
    }

    dimension: isocompfactor {
      type: number
      sql: ${TABLE}.isocompfactor ;;
    }

    dimension: isocollisionsymbol {
      type: number
      sql: ${TABLE}.isocollisionsymbol ;;
    }

    dimension: isocompsymbol {
      type: number
      sql: ${TABLE}.isocompsymbol ;;
    }

    dimension: non_iso_umpd {
      type: number
      sql: ${TABLE}.non_iso_umpd ;;
    }

    dimension: non_iso_umbi {
      type: number
      sql: ${TABLE}.non_iso_umbi ;;
    }

    dimension: non_iso_mp {
      type: number
      sql: ${TABLE}.non_iso_mp ;;
    }

    dimension: non_iso_pd {
      type: number
      sql: ${TABLE}.non_iso_pd ;;
    }

    dimension: non_iso_bi {
      type: number
      sql: ${TABLE}.non_iso_bi ;;
    }

    dimension: non_iso_coll {
      type: number
      sql: ${TABLE}.non_iso_coll ;;
    }

    dimension: non_iso_comp {
      type: number
      sql: ${TABLE}.non_iso_comp ;;
    }

    dimension: replacement_vehicle {
      type: string
      sql: ${TABLE}.replacement_vehicle ;;
    }

    dimension: vehicleannualmilestype_id {
      type: number
      sql: ${TABLE}.vehicleannualmilestype_id ;;
    }

    dimension: drivertrainper {
      type: string
      sql: ${TABLE}.drivertrainper ;;
    }

    dimension: drivertrainamt {
      type: string
      sql: ${TABLE}.drivertrainamt ;;
    }

    dimension: tier_override {
      type: string
      sql: ${TABLE}.tier_override ;;
    }

    dimension: driver_out_of_state_surcharge {
      type: string
      sql: ${TABLE}.driver_out_of_state_surcharge ;;
    }

    dimension_group: last_modified_date {
      type: time
      sql: ${TABLE}.last_modified_date ;;
    }

    dimension: includes_passenger_hazard {
      type: string
      sql: ${TABLE}.includes_passenger_hazard ;;
    }

    dimension: transport_migrant_worker {
      type: string
      sql: ${TABLE}.transport_migrant_worker ;;
    }

    dimension: leased {
      type: string
      sql: ${TABLE}.leased ;;
    }

    dimension: abs {
      type: string
      sql: ${TABLE}.abs ;;
    }

    dimension: is_cover_contents {
      type: string
      sql: ${TABLE}.is_cover_contents ;;
    }

    dimension: is_used_in_dumping {
      type: string
      sql: ${TABLE}.is_used_in_dumping ;;
    }

    dimension: is_trailer_zone_rate {
      type: string
      sql: ${TABLE}.is_trailer_zone_rate ;;
    }

    dimension: is_equipped_with_dual_controls {
      type: string
      sql: ${TABLE}.is_equipped_with_dual_controls ;;
    }

    dimension: lengthtype_id {
      type: number
      sql: ${TABLE}.lengthtype_id ;;
    }

    dimension: subtypetype_id {
      type: number
      sql: ${TABLE}.subtypetype_id ;;
    }

    dimension: seatingcapacitytype_id {
      type: number
      sql: ${TABLE}.seatingcapacitytype_id ;;
    }

    dimension: drivertrainingprogramtype_id {
      type: number
      sql: ${TABLE}.drivertrainingprogramtype_id ;;
    }

    dimension: destinationzonetype_id {
      type: number
      sql: ${TABLE}.destinationzonetype_id ;;
    }

    dimension: originzonetype_id {
      type: number
      sql: ${TABLE}.originzonetype_id ;;
    }

    dimension: trailertype_id {
      type: number
      sql: ${TABLE}.trailertype_id ;;
    }

    dimension: businessusecodetype_id {
      type: number
      sql: ${TABLE}.businessusecodetype_id ;;
    }

    dimension: operatorusetype_id {
      type: number
      sql: ${TABLE}.operatorusetype_id ;;
    }

    dimension: operatortype_id {
      type: number
      sql: ${TABLE}.operatortype_id ;;
    }

    dimension: usecodetype_id {
      type: number
      sql: ${TABLE}.usecodetype_id ;;
    }

    dimension: secondaryclasstype_id {
      type: number
      sql: ${TABLE}.secondaryclasstype_id ;;
    }

    dimension: radiustype_id {
      type: number
      sql: ${TABLE}.radiustype_id ;;
    }

    dimension: vehicleratingtype_id {
      type: number
      sql: ${TABLE}.vehicleratingtype_id ;;
    }

    dimension: license_plate_number {
      type: string
      sql: ${TABLE}.license_plate_number ;;
    }

    dimension: secondaryclassusagetype_id {
      type: number
      sql: ${TABLE}.secondaryclassusagetype_id ;;
    }

    dimension: individual_risk_filing_description {
      type: string
      sql: ${TABLE}.individual_risk_filing_description ;;
    }

    dimension: individual_risk_premium {
      type: string
      sql: ${TABLE}.individual_risk_premium ;;
    }

    dimension: number_of_items {
      type: number
      sql: ${TABLE}.number_of_items ;;
    }

    dimension: replaced_vehicle_num {
      type: number
      sql: ${TABLE}.replaced_vehicle_num ;;
    }

    dimension: damage_yesno_id {
      type: number
      sql: ${TABLE}.damage_yesno_id ;;
    }

    dimension: employee_as_lessor {
      type: string
      sql: ${TABLE}.employee_as_lessor ;;
    }

    dimension: pip_classcode {
      type: number
      sql: ${TABLE}.pip_classcode ;;
    }

    dimension: valuationmethodtype_id {
      type: number
      sql: ${TABLE}.valuationmethodtype_id ;;
    }

    dimension: low_mileage {
      type: string
      sql: ${TABLE}.low_mileage ;;
    }

    dimension: sizetype_id {
      type: number
      sql: ${TABLE}.sizetype_id ;;
    }

    dimension: package_unit_num {
      type: number
      sql: ${TABLE}.package_unit_num ;;
    }

    dimension: packagepart_num {
      type: number
      sql: ${TABLE}.packagepart_num ;;
    }

    dimension: furnished_name {
      type: string
      sql: ${TABLE}.furnished_name ;;
    }

    dimension: farmusecodetype_id {
      type: number
      sql: ${TABLE}.farmusecodetype_id ;;
    }

    dimension: hired_autos_specified_as_covered_autos_you_own {
      type: string
      sql: ${TABLE}.hired_autos_specified_as_covered_autos_you_own ;;
    }

    dimension: discount_surcharge_override {
      type: string
      sql: ${TABLE}.discount_surcharge_override ;;
    }

    dimension: discountsurchargeoverridefactortype_id {
      type: number
      sql: ${TABLE}.discountsurchargeoverridefactortype_id ;;
    }

    dimension: rated_vehicle_discount_surcharge_factor {
      type: number
      sql: ${TABLE}.rated_vehicle_discount_surcharge_factor ;;
    }

    dimension: ownerinformation_id {
      type: number
      sql: ${TABLE}.ownerinformation_id ;;
    }

    dimension: discount_surcharge_override_factor {
      type: number
      sql: ${TABLE}.discount_surcharge_override_factor ;;
    }

    dimension: electronicstabilitytype_id {
      type: number
      sql: ${TABLE}.electronicstabilitytype_id ;;
    }

    dimension: payload_capacity {
      type: string
      sql: ${TABLE}.payload_capacity ;;
    }

    dimension: curb_weight {
      type: number
      sql: ${TABLE}.curb_weight ;;
    }

    dimension: iso_body_style {
      type: string
      sql: ${TABLE}.iso_body_style ;;
    }

    dimension: daytime_running_lights {
      type: string
      sql: ${TABLE}.daytime_running_lights ;;
    }

    dimension: historical {
      type: string
      sql: ${TABLE}.historical ;;
    }

    dimension: performance_info {
      type: string
      sql: ${TABLE}.performance_info ;;
    }

    dimension: stability_info {
      type: string
      sql: ${TABLE}.stability_info ;;
    }

    dimension: tonnage_info {
      type: string
      sql: ${TABLE}.tonnage_info ;;
    }

    dimension: price_new_symbol {
      type: number
      sql: ${TABLE}.price_new_symbol ;;
    }

    dimension: circular_number {
      type: string
      sql: ${TABLE}.circular_number ;;
    }

    dimension: height {
      type: string
      sql: ${TABLE}.height ;;
    }

    dimension: lpmp_symbol_distribution_date {
      type: date
      sql: ${TABLE}.lpmp_symbol_distribution_date ;;
    }

    dimension: lpmp_circular_indicator {
      type: string
      sql: ${TABLE}.lpmp_circular_indicator ;;
    }

    dimension: liability_circular_number {
      type: string
      sql: ${TABLE}.liability_circular_number ;;
    }

    dimension: has_customization_exclusion {
      type: string
      sql: ${TABLE}.has_customization_exclusion ;;
    }

    dimension: has_manual_discount {
      type: string
      sql: ${TABLE}.has_manual_discount ;;
    }

    dimension: is_customized_vehicle {
      type: string
      sql: ${TABLE}.is_customized_vehicle ;;
    }

    dimension: vehicle_dscr {
      type: string
      sql: ${TABLE}.vehicle_dscr ;;
    }

    dimension: snowplowoperationstype_id {
      type: number
      sql: ${TABLE}.snowplowoperationstype_id ;;
    }

    dimension: is_convertible_vehicle {
      type: string
      sql: ${TABLE}.is_convertible_vehicle ;;
    }

    dimension: has_salvaged_title {
      type: string
      sql: ${TABLE}.has_salvaged_title ;;
    }

    dimension: is_from_gray_market {
      type: string
      sql: ${TABLE}.is_from_gray_market ;;
    }

    dimension: is_high_risk_vehicle_override {
      type: string
      sql: ${TABLE}.is_high_risk_vehicle_override ;;
    }

    dimension: is_high_risk_vehicle {
      type: string
      sql: ${TABLE}.is_high_risk_vehicle ;;
    }

    dimension: is_prohibited_vehicle_override {
      type: string
      sql: ${TABLE}.is_prohibited_vehicle_override ;;
    }

    dimension: is_prohibited_vehicle {
      type: string
      sql: ${TABLE}.is_prohibited_vehicle ;;
    }

    dimension: salvaged_branded {
      type: string
      sql: ${TABLE}.salvaged_branded ;;
    }

    dimension: external_previous_loss_indicator {
      type: string
      sql: ${TABLE}.external_previous_loss_indicator ;;
    }

    dimension: external_rate_attribute {
      type: string
      sql: ${TABLE}.external_rate_attribute ;;
    }

    dimension: external_vehicle_body_type_identifier {
      type: string
      sql: ${TABLE}.external_vehicle_body_type_identifier ;;
    }

    dimension: external_vehicle_body_style_dscr {
      type: string
      sql: ${TABLE}.external_vehicle_body_style_dscr ;;
    }

    dimension: external_unit_identifier {
      type: string
      sql: ${TABLE}.external_unit_identifier ;;
    }

    dimension: is_individually_owned {
      type: string
      sql: ${TABLE}.is_individually_owned ;;
    }

    dimension: is_principally_operated_by_employees {
      type: string
      sql: ${TABLE}.is_principally_operated_by_employees ;;
    }

    dimension: is_used_as_showroom {
      type: string
      sql: ${TABLE}.is_used_as_showroom ;;
    }

    dimension: vehicletype_id_sys_generated {
      type: number
      sql: ${TABLE}.vehicletype_id_sys_generated ;;
    }

    dimension: has_special_bumpers {
      type: string
      sql: ${TABLE}.has_special_bumpers ;;
    }

    dimension: has_traction_control_system {
      type: string
      sql: ${TABLE}.has_traction_control_system ;;
    }

    dimension: has_anti_lock_brakes {
      type: string
      sql: ${TABLE}.has_anti_lock_brakes ;;
    }

    dimension: odometer_date {
      type: date
      sql: ${TABLE}.odometer_date ;;
    }

    dimension: vin_lookup_performed {
      type: string
      sql: ${TABLE}.vin_lookup_performed ;;
    }

    dimension: interaction_adjustment_factor {
      type: number
      sql: ${TABLE}.interaction_adjustment_factor ;;
    }

    dimension: interaction_adjustment_level {
      type: number
      sql: ${TABLE}.interaction_adjustment_level ;;
    }

    dimension: leasing_company {
      type: string
      sql: ${TABLE}.leasing_company ;;
    }

    dimension: deleted_policyimage_num {
      type: number
      sql: ${TABLE}.deleted_policyimage_num ;;
    }

    dimension: added_policyimage_num {
      type: number
      sql: ${TABLE}.added_policyimage_num ;;
    }

    dimension: is_used_on_premises {
      type: string
      sql: ${TABLE}.is_used_on_premises ;;
    }

    dimension: is_non_trucking_use {
      type: string
      sql: ${TABLE}.is_non_trucking_use ;;
    }

    dimension: first_added_date {
      type: date
      sql: ${TABLE}.first_added_date ;;
    }

    dimension: waivevehicleinspectionreason_id {
      type: number
      sql: ${TABLE}.waivevehicleinspectionreason_id ;;
    }

    dimension: waive_vehicle_inspection {
      type: string
      sql: ${TABLE}.waive_vehicle_inspection ;;
    }

    dimension: is_photos_not_received {
      type: string
      sql: ${TABLE}.is_photos_not_received ;;
    }

    dimension: has_drivecam_contract {
      type: string
      sql: ${TABLE}.has_drivecam_contract ;;
    }

    dimension: coverage_default_plan_applied {
      type: string
      sql: ${TABLE}.coverage_default_plan_applied ;;
    }

    dimension: is_vehicle_history_score_report_required {
      type: string
      sql: ${TABLE}.is_vehicle_history_score_report_required ;;
    }

    dimension: is_operatedbynamedinsured {
      type: string
      sql: ${TABLE}.is_operatedbynamedinsured ;;
    }

    dimension: has_mechanical_lift {
      type: string
      sql: ${TABLE}.has_mechanical_lift ;;
    }

    dimension: branded_title_date {
      type: date
      sql: ${TABLE}.branded_title_date ;;
    }

    dimension: is_flood_vehicle {
      type: string
      sql: ${TABLE}.is_flood_vehicle ;;
    }

    dimension: has_vin_etching {
      type: string
      sql: ${TABLE}.has_vin_etching ;;
    }

    dimension: registeredownerdriver_num {
      type: number
      sql: ${TABLE}.registeredownerdriver_num ;;
    }

    dimension: registeredownertype_id {
      type: number
      sql: ${TABLE}.registeredownertype_id ;;
    }

    dimension: vehicletitlestatustype_id {
      type: number
      sql: ${TABLE}.vehicletitlestatustype_id ;;
    }

    dimension: vehicleinfolookup_identifier {
      type: number
      sql: ${TABLE}.vehicleinfolookup_identifier ;;
    }

    dimension: vehicleinfolookuptype_id {
      type: number
      sql: ${TABLE}.vehicleinfolookuptype_id ;;
    }

    dimension: has_claim_surcharge {
      type: string
      sql: ${TABLE}.has_claim_surcharge ;;
    }

    dimension: rated_mileage {
      type: number
      sql: ${TABLE}.rated_mileage ;;
    }

    dimension: rcposimportedvehicle_id {
      type: number
      sql: ${TABLE}.rcposimportedvehicle_id ;;
    }

    dimension: loss_risk_prediction_score {
      type: string
      sql: ${TABLE}.loss_risk_prediction_score ;;
    }

    dimension: trim_name {
      type: string
      sql: ${TABLE}.trim_name ;;
    }

    dimension: aux_vehicleinfolookuptype_id {
      type: number
      sql: ${TABLE}.aux_vehicleinfolookuptype_id ;;
    }

    dimension: aux_vehicleinfolookup_identifier {
      type: number
      sql: ${TABLE}.aux_vehicleinfolookup_identifier ;;
    }

    set: detail {
      fields: [
        policy_id,
        policyimage_num,
        vehicle_num,
        eff_date,
        premium_fullterm,
        premium_written,
        premium_chg_written,
        year,
        vin,
        make,
        model,
        bodytype_id,
        performancetype_id,
        symbol,
        territory_num,
        class_code,
        vehicleusetype_id,
        miles,
        days,
        annual_miles,
        principal_driver_num,
        occasional_1_num,
        occasional_2_num,
        occasional_3_num,
        license,
        license_state_id,
        detailstatuscode_id,
        points,
        cost_new,
        cust_equip,
        cov_prop,
        stated_amt,
        multi_car,
        car_pool,
        odometer,
        restrainttype_id,
        antilocktype_id,
        antithefttype_id,
        extra_auto,
        comp_auto,
        external_id,
        warp_id,
        added_date,
        pcadded_date_time,
        companyvehicle_num,
        nonowned_extended,
        nonowned_named,
        purchased_date_time,
        motorcycle_layupmonths,
        prior_insurance_disc,
        antitheft_disc,
        restraint_disc,
        rollover_disc,
        liability,
        physical_damage,
        extra_hazardous,
        bodystyle_id,
        horsepower_id,
        market_value,
        registered,
        suspend_coverage,
        manual_youth_operator,
        weeks,
        principal_driver_percent,
        occasional_1_driver_percent,
        occasional_2_driver_percent,
        occasional_3_driver_percent,
        damage,
        damage_remarks,
        cylinders,
        manual_assign,
        length,
        liabilitysurchargegroup_id,
        physicaldamagegroup_id,
        piptype_id,
        collisiontype_id,
        mccacollectionfeetype_id,
        mccacollectionfee_amount,
        antitheft_disc_amt,
        restraint_disc_amt,
        abs_disc_amt,
        accprev_disc_amt,
        accident_free_disc_amt,
        multi_policy_disc_amt,
        prior_months_with_company,
        days_lapsed,
        rated_principal_driver_num,
        rated_occ_driver_num,
        antitheft_disc_pct,
        restraint_disc_pct,
        abs_disc_pct,
        accprev_disc_pct,
        accident_free_disc_pct,
        componly,
        cctype_id,
        lossfreetype_id,
        comp_surcharge_fee,
        comp_surcharge,
        vehicle_type,
        minor_violations_surcharge_pct,
        additional_equipment,
        extra_hazard,
        anti_theft_discount,
        multi_car_override,
        business_use,
        business_use_description,
        drivertype_id,
        vehicleusagetype_id,
        garage,
        additional_interest,
        scheduled_items,
        non_owned,
        etched_glass,
        homing_device,
        fire_island,
        manual_class,
        dmv_fee,
        airbag,
        class,
        veh_load_cap,
        passrestper,
        antitheftper,
        antilockper,
        daylightper,
        multicarper,
        occ_1_id,
        driver_assign_id,
        princ_driver_id,
        occ_2_id,
        occ_3_id,
        restraint_id,
        abs_id,
        day_run_light_id,
        trailer_id,
        photoinspect,
        acv,
        passrestamt,
        antitheftamt,
        antilockamt,
        daylightamt,
        multicaramt,
        photoinspection_time,
        inexpopper,
        inexpopamt,
        accconper,
        accconamt,
        accprevamt,
        accprevper,
        worklossamt,
        worklossper,
        inc_symbol,
        govt_use,
        joint_owned,
        gvw,
        suspend,
        vehicle_display_num,
        vehicletype_id,
        principal_numpct,
        occasional_1_numpct,
        occasional_2_numpct,
        occasional_3_numpct,
        assigned_driver_num,
        manualyouthfuloperator,
        vehiclevalue_id,
        hpcctype_id,
        excess_rate,
        excess_rate_reason,
        motorcycle_racingmodified,
        layup_credit,
        motorcycle_layupbegin_time,
        motorcycle_layupend_time,
        motorhome_rented,
        drivetype_id,
        nonowned_named_specificvehicle,
        personsinhousehold_id,
        seatbelt,
        carpooldays,
        rejectionpipworkloss_id,
        suppspousalliability_premium,
        multi_car_disc_amt,
        dmv_fee_amount,
        points_surcharge_amt,
        restricted_vehicle,
        ccs,
        motorcyclelayuptype_id,
        stat_territory,
        registered_state_id,
        titleholder_info,
        operatoragetype_id,
        pipworklossperson_id,
        unacceptable_risk,
        county,
        override_vin,
        comp_coll_only,
        non_iso_symbol,
        multi_policy_disc_per,
        motorcycle_rider_training_disc,
        liability_class_code,
        physical_damage_class_code,
        tiertype_id,
        used_in_business,
        exclusions_apply,
        trailerlength,
        excluded_designated_vehicle,
        um,
        uim,
        premium_um,
        premium_uim,
        linknumber,
        hullyear,
        hullmanufacturer,
        hullmodel,
        hulltypeclassi_id,
        hulltypeclassii_id,
        hullserialnumber,
        hulllength_id,
        hullcostnew,
        hullamountused,
        hulldeductibleclassi_id,
        hulldeductibleclassii_id,
        hullclassiireplacementcostestimate,
        hullclassiiinsuredvalueofboat,
        traileryear,
        trailerserialnumber,
        traileramount,
        accidentdescription,
        accidentamount,
        personalpropertydescription,
        personalpropertyamount,
        trailermanufacturer,
        experiencecredit_id,
        navigationallimit_id,
        trailermodel,
        increasedaccamt,
        increasedperprop,
        hulllength,
        accessorieamount,
        accessoriedescription,
        hullclassiinsuredvalue,
        liabilityctr,
        liabilityirf,
        liabilitydescription,
        liabilityamount,
        physicaldamagectr,
        physicaldamageirf,
        physicaldamagedescription,
        physicaldamageamount,
        othernavigation,
        liabilitynone,
        physicaldamagenone,
        othermotordescription,
        display_num,
        totalhp,
        classcodeclassilength,
        classcodeclassiwatercrafttype,
        classcodeclassiilength,
        classcodeclassiiwatercrafttype,
        power_id,
        otherpowerdescription,
        hulltype_id,
        otherhulldescription,
        hullmaterial_id,
        otherhullmaterialdescription,
        hulldesign_id,
        otherhulldesigndescription,
        fueltank_id,
        otherfueltankdescription,
        coveragetype_id,
        classcodetowander,
        classcodeice,
        classcodejetdrive,
        ctr_cov_eliminated_physical_damage,
        ctr_cov_involved_physical_damage,
        ctr_cov_eliminated_liability,
        ctr_cov_involved_liability,
        physicaldamage_normal_premium,
        liability_normal_premium,
        irf_physicaldamage_prorata,
        irf_liability_prorata,
        extendedproperties_xml,
        cost_used,
        vin_override,
        symbol_override,
        classcode_override,
        company_car,
        isoliabilityfactor,
        isoliabilitysymbol,
        isopipmedpayfactor,
        isopipmedpaysymbol,
        non_iso_rating_symbol,
        good_driver_percentage,
        isocollisionfactor,
        isocompfactor,
        isocollisionsymbol,
        isocompsymbol,
        non_iso_umpd,
        non_iso_umbi,
        non_iso_mp,
        non_iso_pd,
        non_iso_bi,
        non_iso_coll,
        non_iso_comp,
        replacement_vehicle,
        vehicleannualmilestype_id,
        drivertrainper,
        drivertrainamt,
        tier_override,
        driver_out_of_state_surcharge,
        last_modified_date_time,
        includes_passenger_hazard,
        transport_migrant_worker,
        leased,
        abs,
        is_cover_contents,
        is_used_in_dumping,
        is_trailer_zone_rate,
        is_equipped_with_dual_controls,
        lengthtype_id,
        subtypetype_id,
        seatingcapacitytype_id,
        drivertrainingprogramtype_id,
        destinationzonetype_id,
        originzonetype_id,
        trailertype_id,
        businessusecodetype_id,
        operatorusetype_id,
        operatortype_id,
        usecodetype_id,
        secondaryclasstype_id,
        radiustype_id,
        vehicleratingtype_id,
        license_plate_number,
        secondaryclassusagetype_id,
        individual_risk_filing_description,
        individual_risk_premium,
        number_of_items,
        replaced_vehicle_num,
        damage_yesno_id,
        employee_as_lessor,
        pip_classcode,
        valuationmethodtype_id,
        low_mileage,
        sizetype_id,
        package_unit_num,
        packagepart_num,
        furnished_name,
        farmusecodetype_id,
        hired_autos_specified_as_covered_autos_you_own,
        discount_surcharge_override,
        discountsurchargeoverridefactortype_id,
        rated_vehicle_discount_surcharge_factor,
        ownerinformation_id,
        discount_surcharge_override_factor,
        electronicstabilitytype_id,
        payload_capacity,
        curb_weight,
        iso_body_style,
        daytime_running_lights,
        historical,
        performance_info,
        stability_info,
        tonnage_info,
        price_new_symbol,
        circular_number,
        height,
        lpmp_symbol_distribution_date,
        lpmp_circular_indicator,
        liability_circular_number,
        has_customization_exclusion,
        has_manual_discount,
        is_customized_vehicle,
        vehicle_dscr,
        snowplowoperationstype_id,
        is_convertible_vehicle,
        has_salvaged_title,
        is_from_gray_market,
        is_high_risk_vehicle_override,
        is_high_risk_vehicle,
        is_prohibited_vehicle_override,
        is_prohibited_vehicle,
        salvaged_branded,
        external_previous_loss_indicator,
        external_rate_attribute,
        external_vehicle_body_type_identifier,
        external_vehicle_body_style_dscr,
        external_unit_identifier,
        is_individually_owned,
        is_principally_operated_by_employees,
        is_used_as_showroom,
        vehicletype_id_sys_generated,
        has_special_bumpers,
        has_traction_control_system,
        has_anti_lock_brakes,
        odometer_date,
        vin_lookup_performed,
        interaction_adjustment_factor,
        interaction_adjustment_level,
        leasing_company,
        deleted_policyimage_num,
        added_policyimage_num,
        is_used_on_premises,
        is_non_trucking_use,
        first_added_date,
        waivevehicleinspectionreason_id,
        waive_vehicle_inspection,
        is_photos_not_received,
        has_drivecam_contract,
        coverage_default_plan_applied,
        is_vehicle_history_score_report_required,
        is_operatedbynamedinsured,
        has_mechanical_lift,
        branded_title_date,
        is_flood_vehicle,
        has_vin_etching,
        registeredownerdriver_num,
        registeredownertype_id,
        vehicletitlestatustype_id,
        vehicleinfolookup_identifier,
        vehicleinfolookuptype_id,
        has_claim_surcharge,
        rated_mileage,
        rcposimportedvehicle_id,
        loss_risk_prediction_score,
        trim_name,
        aux_vehicleinfolookuptype_id,
        aux_vehicleinfolookup_identifier
      ]
    }
  }


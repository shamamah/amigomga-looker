connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

datagroup: product_datagroup {
  label: "Product Datagroup"
  sql_trigger: SELECT max(pcadded_date) FROM policyimage;;
  max_cache_age: "24 hours"
}

persist_with: product_datagroup

explore: dt_premiums {
  group_label: "Diamond Analytics (REPORT)"
  label: "Product"
  view_label: "Premium"

  join: company_state_lob {
    view_label: "Company"
    type: inner
    relationship: one_to_many
    sql_on: ${company_state_lob.company_id} = ${dt_premiums.company_id}
        AND ${company_state_lob.lob_id} = ${dt_premiums.lob_id}
        AND ${company_state_lob.state_id} = ${dt_premiums.state_id};;
  }

  aggregate_table: written_earned_by_treaty_coverage_liab_phys {
    query: {
      dimensions: [company_state_lob.commercial_name1, company_state_lob.lobname, dt_coverage_liab_phys.liab_phys, reinsurance_treaty.treatyname, coverage_code.dscr]
      measures: [dt_premiums.total_earned_premium, dt_premiums.total_written_premium, dt_mtd_claims.incurred_net_pd_ss]
    }

    materialization: {
      sql_trigger_value: SELECT CAST(GETDATE());;
    }
  }

    #-----------------------------------------------------------
  join: dt_policyimage_num_unique {
    view_label: "TEST"
    type: inner
    relationship: one_to_many
    sql_on: ${dt_premiums.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_premiums.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
  }

  join: dt_garaging_territory_zip {
    view_label: "Policy"
    type:  inner
    relationship: one_to_one
    sql_on: ${dt_garaging_territory_zip.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_garaging_territory_zip.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num};;
  }

  join: policy_image {
    view_label: "Policy"
    type: inner
    fields: [policy_number, renewal_ver, new_renewal, eff_date, eff_quarter, exp_date, premium_written,
        unique_count]
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num};;
  }

  join: policy {
    view_label: "Policy"
    type:  inner
    fields: [rollover_rewrite]
    relationship: one_to_one
    sql_on:  ${policy_image.policy_id} = ${policy.policy_id};;
  }

  join: v_agency {
    view_label: "Agency"
    type: inner
    sql_on: ${v_agency.agency_id} = ${policy_image.agency_id} ;;
    relationship: one_to_many
  }

  # join: dt_agency_reporting {
  #   view_label: "Agency"
  #   type:  inner
  #   sql_on:  ${dt_agency_reporting.agency_id} = ${v_agency.agency_id} ;;
  #   relationship: one_to_one
  # }

  # join: dt_agencygroup_reporting {
  #   view_label: "Agency"
  #   type: left_outer
  #   sql_on:  ${dt_agency_reporting.agencygroup_id} = ${dt_agencygroup_reporting.agencygroup_id} ;;
  #   relationship: one_to_many
  # }


  # join: dt_agency_location {
  #   view_label: "Agency"
  #   type: inner
  #   sql_on: ${v_agency.agency_id} = ${dt_agency_location.agency_id} ;;
  #   relationship: one_to_one
  # }

  join: policy_current_status {
    view_label: "Policy"
    type:  inner
    relationship: one_to_many
    sql_on: ${policy_current_status.policycurrentstatus_id} = ${policy_image.policystatuscode_id};;
  }

  join: dt_vehicle_count {
    view_label: "Policy"
    type:  inner
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_vehicle_count.policy_id}
    AND ${policy_image.policyimage_num} = ${dt_vehicle_count.policyimage_num};;
  }

  join: dt_driver_count {
    view_label: "Policy"
    type:  inner
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_driver_count.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_driver_count.policyimage_num};;
  }

  join: dt_excluded_driver_count {
    view_label: "Policy"
    type:  inner
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_excluded_driver_count.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_excluded_driver_count.policyimage_num};;
  }

  join: dt_quote_source {
    view_label: "Policy"
    type: inner
    sql_on: ${policy_image.policy_id} = ${dt_quote_source.policy_id} ;;
    relationship: one_to_one
  }
#-------------------------------------------------

  join: dt_coverage_liab_phys {
    view_label: "Coverage"
    type: inner
    relationship: many_to_one
    sql_on: ${policy_image.policy_id} = ${dt_coverage_liab_phys.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_coverage_liab_phys.policyimage_num};;
  }

  join: dt_total_discount_percent {
    view_label: "Policy"
    type: left_outer
    sql_on: ${dt_total_discount_percent.policy_id} = ${policy_image.policy_id}
      AND ${dt_total_discount_percent.policyimage_num} = ${policy_image.policyimage_num};;
    relationship: one_to_many
  }


  join: vehicle {
    view_label: "Vehicle"
    type: inner
    fields: [vehicle.year, vehicle.make, vehicle.model, vehicle.class_code, vehicle.multi_car, vehicle.isocollisionsymbol]
    relationship: one_to_many
    sql_on: ${vehicle.policy_id} = ${dt_policyimage_num_unique.policy_id}
          AND  ${vehicle.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num};;
          # AND ${vehicle.vehicle_num} = ${dt_premiums.unit_num};;
  }

  join: vehicle_symbol {
    view_label: "Vehicle"
    type: inner
    fields: [vehicle_symbol.useroverride_symbol]
    relationship: one_to_many
    sql_on: ${vehicle.policy_id} = ${vehicle_symbol.policy_id}
          AND  ${vehicle.policyimage_num} = ${vehicle_symbol.policyimage_num}
          AND ${vehicle.vehicle_num} = ${vehicle_symbol.vehicle_num};;
  }

  join: v_vehicle_coverage {
    view_label: "Vehicle"
    type: inner
    fields: [v_vehicle_coverage.limitdscr]
    relationship: one_to_one
    sql_on: ${vehicle.policy_id} = ${v_vehicle_coverage.policy_id}
          AND  ${vehicle.policyimage_num} = ${v_vehicle_coverage.policyimage_num}
          AND ${vehicle.vehicle_num} = ${v_vehicle_coverage.vehicle_num}
          AND ${dt_premiums.coveragecode_id}=${v_vehicle_coverage.coveragecode_id};;
    }

    join: driver {
      view_label: "Driver"
      type: inner
      fields: [driver.agency_issued_sr22]
      relationship: one_to_one
      sql_on: ${vehicle.policy_id} = ${driver.policy_id} AND
          ${driver.policyimage_num} = ${vehicle.policyimage_num} AND
          CASE WHEN ${vehicle.driver_assign_id} = 0 THEN 1
          ELSE ${vehicle.driver_assign_id} END = ${driver.driver_num};;
    }

    join: driver_name_link {
      view_label: "Driver"
      type: inner
      fields: []
      relationship: one_to_one
      sql_on: ${driver_name_link.policy_id} = ${driver.policy_id}
          AND ${driver_name_link.policyimage_num} = ${driver.policyimage_num}
          AND ${driver_name_link.driver_num} = ${driver.driver_num} ;;
    }

    join: driver_name {
      view_label: "Driver"
      type: inner
      relationship: one_to_one
      sql_on: ${driver_name.name_id} = ${driver_name_link.name_id} ;;
    }

    join: marital_status {
      view_label: "Driver"
      type: left_outer
      fields: [marital_status.dscr]
      relationship: one_to_many
      sql_on: ${marital_status.maritalstatus_id} = ${driver_name.maritalstatus_id} ;;
    }

    join: sex {
      view_label: "Driver"
      type: left_outer
      fields: [sex.dscr]
      relationship: one_to_many
      sql_on: ${sex.sex_id} = ${driver_name.sex_id} ;;
    }

    join: coverage_code {
      view_label: "Coverage"
      type: left_outer
      relationship: one_to_one
      sql_on: ${dt_premiums.coveragecode_id} = ${coverage_code.coveragecode_id};;
    }


    join: dt_discount_indicator {
      view_label: "Discount"
      type: left_outer
      relationship: many_to_one
      sql_on: ${dt_discount_indicator.policy_id} = ${dt_policyimage_num_unique.policy_id}
        AND ${dt_discount_indicator.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
    }

    join: dt_proof_of_prior {
      view_label:  "Proof of Prior"
      type: left_outer
      relationship: one_to_one
      sql_on: ${dt_proof_of_prior.policy_id} = ${dt_policyimage_num_unique.policy_id}
              AND ${dt_proof_of_prior.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
    }

    join: dt_mtd_claims {
      view_label: "Claims"
      type: left_outer
      relationship: many_to_one
      sql_on: ${dt_premiums.policy_id} = ${dt_mtd_claims.policy_id}
            AND ${dt_premiums.renewal_ver} = ${dt_mtd_claims.renewal_ver}
            AND ${dt_premiums.unit_num} = ${dt_mtd_claims.vehicle_num}
            AND ${dt_premiums.coveragecode_id} = ${dt_mtd_claims.coveragecode_id}
            AND ${dt_premiums.year} = ${dt_mtd_claims.year}
            AND ${dt_premiums.month} = ${dt_mtd_claims.month};;
    }

    join: reinsurance_treaty {
      view_label: "Treaty"
      type:  left_outer
      relationship: one_to_many
      sql_on: ${policy_image.eff_date} between ${reinsurance_treaty.effective_date} AND
                                        ${reinsurance_treaty.expiration_date}
              AND ${reinsurance_treaty.treatylob} = ${dt_premiums.lob_id}
              AND ${company_state_lob.companystatelob_id} = ${reinsurance_treaty.company_state_lob_id};;

    }

  }

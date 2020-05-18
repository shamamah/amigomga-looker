connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: dt_itd_premiums {
  group_label: "Diamond Analytics (REPORT)"
  label: "Product ITD"
  view_label: "Premium"

join: company_state_lob {
  view_label: "Company"
  type: inner
  relationship: one_to_many
  sql_on: ${company_state_lob.company_id} = ${dt_itd_premiums.company_id}
  AND ${company_state_lob.lob_id} = ${dt_itd_premiums.lob_id}
  AND ${company_state_lob.state_id} = ${dt_itd_premiums.state_id};;
}

join: policy_image {
  view_label: "Policy"
  type: inner
  fields: []
  relationship: one_to_one
  sql_on: ${policy_image.policy_id} = ${dt_itd_premiums.policy_id}
  AND ${policy_image.renewal_ver} = ${dt_itd_premiums.renewal_ver};;
}
join: dt_policyimage_num_unique {
  view_label: "TEST"
  type: inner
  relationship: one_to_many
  sql_on: ${policy_image.policy_id} = ${dt_policyimage_num_unique.policy_id}
  AND ${policy_image.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
}

join: v_vehicle {
    view_label: "Vehicle"
    type: left_outer
    fields: []
    relationship: one_to_many
    sql_on: ${dt_policyimage_num_unique.policy_id} = ${v_vehicle.policy_id}
    AND  ${dt_policyimage_num_unique.policyimage_num} = ${v_vehicle.policyimage_num} ;;
  #  AND ${eop_monthly_premiums.unit_num} = ${v_vehicle.vehicle_num}
}

join: driver {
  view_label: "Driver"
  type: left_outer
  fields: []
  relationship: one_to_many
  sql_on: ${v_vehicle.policy_id} = ${driver.policy_id} AND
  ${driver.policyimage_num} = ${v_vehicle.policyimage_num} AND
  CASE WHEN ${v_vehicle.driver_assign_id} = 0 THEN 1
  ELSE ${v_vehicle.driver_assign_id} END = ${driver.driver_num};;
}

  join: driver_name_link {
    view_label: "Driver"
    type: left_outer
    fields: []
    relationship: one_to_many
    sql_on: ${driver_name_link.policy_id} = ${driver.policy_id}
          AND ${driver_name_link.policyimage_num} = ${driver.policyimage_num}
          AND ${driver_name_link.driver_num} = ${driver.driver_num} ;;
  }

  join: driver_name {
    view_label: "Driver"
    type: left_outer
    fields: []
    relationship: one_to_one
    sql_on: ${driver_name.name_id} = ${driver_name_link.name_id} ;;
  }

  join: marital_status {
    view_label: "Driver"
    type: left_outer
    fields: []
    relationship: one_to_many
    sql_on: ${marital_status.maritalstatus_id} = ${driver_name.maritalstatus_id} ;;
  }

  join: sex {
    view_label: "Driver"
    type: left_outer
    fields: []
    relationship: one_to_many
    sql_on: ${sex.sex_id} = ${driver_name.sex_id} ;;
  }

  join: coverage_code {
    view_label: "Coverage"
    type: left_outer
    relationship: one_to_many
    sql_on: ${dt_itd_premiums.coveragecode_id} = ${coverage_code.coveragecode_id};;
  }

  join: dt_itd_claims {
    view_label: "Claims"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dt_itd_premiums.itd_premiums_primarykey} = ${dt_itd_claims.itd_claims_primarykey};;
  }

  join: reinsurance_treaty {
    view_label: "Treaty"
    type:  left_outer
    relationship: one_to_many
    sql_on: ${policy_image.eff_date} between ${reinsurance_treaty.effective_date} AND
      ${reinsurance_treaty.expiration_date};;

  }

}

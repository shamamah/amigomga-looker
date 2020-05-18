connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: eop_monthly_premiums {
  group_label: "Diamond Analytics (REPORT)"
  label: "Product EOP"
  view_label: "Product EOP"

join: version  {
    view_label: "Company"
    type: inner
    relationship: one_to_one
    sql_on: ${eop_monthly_premiums.version_id} = ${version.version_id} ;;
}

join: v_vehicle {
    view_label: "Vehicle"
    type: left_outer
    relationship: one_to_many
    sql_on: ${eop_monthly_premiums.policy_id} = ${v_vehicle.policy_id} AND
    ${eop_monthly_premiums.policyimage_num} = ${v_vehicle.policyimage_num} ;;
  #  AND ${eop_monthly_premiums.unit_num} = ${v_vehicle.vehicle_num}
}

join: driver {
  view_label: "Driver"
  type: left_outer
  relationship: one_to_many
  sql_on: ${v_vehicle.policy_id} = ${driver.policy_id} AND
  ${driver.policyimage_num} = ${v_vehicle.policyimage_num} AND
  CASE WHEN ${v_vehicle.driver_assign_id} = 0 THEN 1
  ELSE ${v_vehicle.driver_assign_id} END = ${driver.driver_num};;
}

  join: driver_name_link {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
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
    type: inner
    relationship: one_to_many
    sql_on: ${marital_status.maritalstatus_id} = ${driver_name.maritalstatus_id} ;;
  }

  join: sex {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${sex.sex_id} = ${driver_name.sex_id} ;;
  }

#  join: claim_control {
#    type: inner
#    relationship: one_to_many
#    sql_on: ${eop_monthly_premiums.policy_id} = ${claim_control.policy_id} AND
#    ${eop_monthly_premiums.policyimage_num} = ${claim_control.policyimage_num}  ;;
#  }

#  join: claim_feature_eod {
#    type: inner
#    relationship: one_to_many
#    sql_on: ${claim_control.claimcontrol_id} = ${claim_feature_eod.claimcontrol_id}
#    AND ${claim_feature_eod.month} = ${eop_monthly_premiums.month}
#    AND ${claim_feature_eod.year} = ${eop_monthly_premiums.year};;
#  }

#  join: claim_financials {
#    type: inner
#    relationship: one_to_many
#    sql_on: ${claim_financials.claimcontrol_id} = ${claim_feature_eod.claimcontrol_id}
#    AND ${claim_financials.claimfinancials_num} = ${claim_feature_eod.claimfinancials_num};;
# }

}

connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: dt_policy_pif {
  group_label: "Diamond Analytics (REPORT)"
  label: "Policy Trend"
  view_label: "Policy"


  join: policy_pif_trans_lkup {
    view_label: "Policy"
    type: inner
    sql_on: ${policy_pif_trans_lkup.transtype_sht} = ${dt_policy_pif.trans_type}
          ;;
    relationship: one_to_many
  }

  join: dt_policyimage_num_unique {
    type: inner
    sql_on: ${dt_policy_pif.policy_id} = ${dt_policyimage_num_unique.policy_id}
            AND ${dt_policy_pif.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
    relationship: one_to_many
  }

  join: dt_proof_of_prior {
    view_label:  "Proof of Prior"
    type: left_outer
    relationship: one_to_one
    sql_on: ${dt_proof_of_prior.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_proof_of_prior.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
  }

  join: dt_policy_attachment {
    view_label: "Attachment"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dt_policy_attachment.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_policy_attachment.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num} ;;
  }

  join: dt_coverage_liab_phys {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_one
    fields: [dt_coverage_liab_phys.liab_phys]
    sql_on: ${dt_coverage_liab_phys.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_coverage_liab_phys.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num} ;;
  }

  join: dt_vehicle_count {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_one
    fields: [dt_vehicle_count.multi_car]
    sql_on: ${dt_vehicle_count.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_vehicle_count.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num} ;;
  }

  join: dt_driver_count {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_one
    fields: [dt_driver_count.fdl_usdl]
    sql_on: ${dt_driver_count.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_driver_count.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num} ;;
  }

  join: dt_policy_new_renew {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_one
    fields: [dt_policy_new_renew.new_renew]
    sql_on: ${dt_policy_new_renew.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${dt_policy_new_renew.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num} ;;
  }

  join: dt_policy_agency {
    view_label: "Agency"
    type: inner
    sql_on: ${dt_policy_agency.policy_id} = ${dt_policyimage_num_unique.policy_id}
          AND ${dt_policy_agency.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num};;
    relationship: one_to_many
  }

  join: version {
    type: inner
    fields: []
    sql_on: ${version.version_id} = ${dt_policyimage_num_unique.version_id};;
    relationship: one_to_many

  }

  join: company_state_lob {
    type: inner
    sql_on: ${company_state_lob.companystatelob_id} = ${version.companystatelob_id} ;;
    relationship: one_to_one
  }

  join: reinsurance_treaty {
    type: inner
    sql_on: ${dt_policy_pif.eff_date} between ${reinsurance_treaty.effective_date} AND ${reinsurance_treaty.expiration_date} ;;
    relationship: one_to_many
  }
}
connection: "c76-reporting"

include: "/views/*.view.lkml"

explore: dt_retention_policy_by_agent {
  group_label: "Diamond Analytics (REPORT)"
  label: "Retention"
  view_label: "Retention"
  access_filter: {
    field: code
    user_attribute: agency_code
  }
}

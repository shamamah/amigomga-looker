connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: dt_policy_pif {
  group_label: "Diamond Analytics (REPORT)"
  label: "Policy Trend"
  view_label: "Policy"


  join: dt_policyimage_num_unique {
    type: inner
    sql_on: ${dt_policy_pif.policy_id} = ${dt_policyimage_num_unique.policy_id}
            AND ${dt_policy_pif.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver};;
    relationship: one_to_many
  }

  join: dt_policy_agency {
    type: inner
    sql_on: ${dt_policyimage_num_unique.policy_id} = ${dt_policy_agency.policy_id} ;;
    relationship: one_to_many
  }

  join: version {
    type: inner
    sql_on: ${version.version_id} = ${dt_policyimage_num_unique.version_id};;
    relationship: one_to_many

  }

  join: company_state_lob {
    type: inner
    sql_on: ${company_state_lob.companystatelob_id} = ${version.companystatelob_id} ;;
    relationship: one_to_one
  }
}

connection: "c76-reporting"

include: "*.view"                # include all views in the views/ folder in this project

fiscal_month_offset: 0
week_start_day: sunday

explore: dt_cash_and_fees {
  group_label: "Diamond Analytics (REPORT)"
  label: "Cash and Fees"
  view_label: "Cash"

  join: company_state_lob {
    view_label: "Company"
    type: inner
    relationship: one_to_many
    sql_on: ${company_state_lob.company_id} = ${dt_cash_and_fees.company_id}
        AND ${company_state_lob.lob_id} = ${dt_cash_and_fees.lob_id}
        AND ${company_state_lob.state_id} = ${dt_cash_and_fees.state_id};;
    }

  join: dt_policyimage_num_unique {
    type: inner
    sql_on: ${dt_cash_and_fees.policy_id} = ${dt_policyimage_num_unique.policy_id}
          AND ${dt_cash_and_fees.renewal_ver} = ${dt_policyimage_num_unique.renewal_ver} ;;
    relationship: one_to_many
  }

  join: policy_image {
    view_label: "Policy"
    type: inner
    fields: [policy_image.teff_date, policy_image.texp_date, policy_image.transtype_id, policy_image.policystatuscode_id]
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_policyimage_num_unique.policyimage_num};;
  }

  join: coverage {
    view_label: "Coverage"
    type: inner
    fields: [checkbox]
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_cash_and_fees.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_cash_and_fees.policyimage_num}
      AND ${coverage.detailstatuscode_id} = 1;;
  }

  join: coverage_code {
    view_label: "Coverage"
    type: inner
    sql_on: ${coverage.coveragecode_id} = ${coverage_code.coveragecode_id} ;;
    fields: [coverage_code.dscr]
    relationship: one_to_many
  }

join: reinsurance_treaty {
  view_label: "Treaty"
  type: inner
  relationship: one_to_many
  sql_on: ${policy_image.eff_date} between ${reinsurance_treaty.effective_date} and ${reinsurance_treaty.expiration_date} ;;
}

}

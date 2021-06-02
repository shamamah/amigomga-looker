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

  join: dt_policyimage_num_unique_current {
    from: dt_policyimage_num_unique
    type: inner
    sql_on: ${dt_cash_and_fees.policy_id} = ${dt_policyimage_num_unique_current.policy_id}
          AND ${dt_cash_and_fees.renewal_ver} = ${dt_policyimage_num_unique_current.renewal_ver} ;;
    relationship: one_to_many
  }

  join: policy_image_current {
    from: policy_image
    view_label: "Policy"
    type: inner
    fields: [policy_image_current.policy, policy_image_current.premium_fullterm, policy_image_current.teff_date, policy_image_current.texp_date, policy_image_current.transtype_id, policy_image_current.policystatuscode_id]
    relationship: one_to_one
    sql_on: ${policy_image_current.policy_id} = ${dt_policyimage_num_unique_current.policy_id}
      AND ${policy_image_current.policyimage_num} = ${dt_policyimage_num_unique_current.policyimage_num};;
  }

  join: billing_acct_receivable_current {
    from: billing_acct_receivable
    view_label: "Policy"
    type: left_outer
    fields: [billing_acct_receivable_current.total_outstanding]
    relationship: one_to_one
    sql_on:  ${policy_image_current.policy_id} = ${billing_acct_receivable_current.policy_id}
      AND ${policy_image_current.renewal_ver} = ${billing_acct_receivable_current.renewal_ver};;
  }

  join: policy {
    type: inner
    relationship: one_to_one
    fields: []
    sql_on: ${policy_image_current.policy_id} = ${policy.policy_id};;
  }


  join: policy_image_prior {
    from: policy_image
    view_label: "Prior Policy"
    type: left_outer
    relationship: one_to_many
    fields: [policy]
    sql_on: ${policy_image_prior.policy_id} = ${policy.rewrittenfrom_policy_id}
    AND ${policy_image_prior.policyimage_num} = ${policy.rewrittenfrom_policyimage_num};;
  }

  join: billing_acct_receivable_prior {
    from: billing_acct_receivable
    view_label: "Prior Policy"
    type: left_outer
    fields: [billing_acct_receivable_prior.total_outstanding]
    relationship: one_to_one
    sql_on:  ${policy_image_prior.policy_id} = ${billing_acct_receivable_prior.policy_id}
      AND ${policy_image_prior.renewal_ver} = ${billing_acct_receivable_prior.renewal_ver};;
  }

  join: dt_policy_agency {
    view_label: "Agency"
    type: left_outer
    relationship: one_to_one
    sql_on:  ${policy_image_current.policy_id} = ${dt_policy_agency.policy_id}
          AND ${dt_policy_agency.policyimage_num} = ${policy_image_current.policyimage_num};;

  }


  join: policy_image_name_link {
    type: left_outer
    fields: []
    relationship: one_to_one
    sql_on: ${policy_image_name_link.policy_id} = ${policy_image_current.policy_id}
          AND ${policy_image_name_link.policyimage_num} = ${policy_image_current.policyimage_num}
          AND ${policy_image_name_link.nameaddresssource_id}=3;;
  }

  join: name {
    view_label: "Insured"
    fields: [display_name, first_name, last_name, middle_name]
    type: inner
    relationship: one_to_one
    sql_on: ${policy_image_name_link.name_id} = ${name.name_id}
     ;;
  }
  join: coverage {
    view_label: "Coverage"
    type: inner
    fields: [checkbox]
    relationship: one_to_one
    sql_on: ${policy_image_current.policy_id} = ${dt_cash_and_fees.policy_id}
      AND ${policy_image_current.policyimage_num} = ${dt_cash_and_fees.policyimage_num}
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
  sql_on: ${policy_image_current.eff_date} between ${reinsurance_treaty.effective_date} and ${reinsurance_treaty.expiration_date}
            AND ${company_state_lob.lob_id} = ${reinsurance_treaty.treatylob};;
}

}

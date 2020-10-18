connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: dt_quote {
  group_label: "Diamond Analytics (REPORT)"
  label: "Temporary Quote"
  view_label: "Quote"


  join: policy_pif_trans_lkup {
    view_label: "Quote"
    fields: []
    type: inner
    sql_on: ${policy_pif_trans_lkup.transtype_sht} = ${dt_quote.trans_type}
      ;;
    relationship: one_to_many
  }

  join: dt_quote_source {
    view_label: "Quote"
    type: inner
    sql_on: ${dt_quote.policy_id} = ${dt_quote_source.policy_id} ;;
    relationship: one_to_one
  }

  join: dt_policy_agency {
    view_label: "Agency"
    type: inner
    sql_on: ${dt_policy_agency.policy_id} = ${dt_quote.policy_id}
      AND ${dt_policy_agency.policyimage_num} = ${dt_quote.policyimage_num};;
    relationship: one_to_many
  }

  join: version {
    type: inner
    fields: []
    sql_on: ${version.version_id} = ${dt_quote.version};;
    relationship: one_to_many

  }

  join: company_state_lob {
    type: inner
    sql_on: ${company_state_lob.companystatelob_id} = ${version.companystatelob_id} ;;
    relationship: one_to_one
  }

  join: reinsurance_treaty {
    type: inner
    sql_on: ${dt_quote.eff_date} between ${reinsurance_treaty.effective_date} AND ${reinsurance_treaty.expiration_date} ;;
    relationship: one_to_many
  }


}

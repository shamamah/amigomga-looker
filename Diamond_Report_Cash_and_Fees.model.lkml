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

  join: policy_image {
    view_label: "Policy"
    type: inner
    fields: []
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${dt_cash_and_fees.policy_id}
      AND ${policy_image.policyimage_num} = ${dt_cash_and_fees.policyimage_num};;
  }



}

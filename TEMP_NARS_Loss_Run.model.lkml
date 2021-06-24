connection: "c76-reporting"

# include all the views
include: "/views/*.view"
include: "*.view"



fiscal_month_offset: 0
week_start_day: sunday

explore: customer_reports_nars_loss_run {
  group_label: "Diamond Analytics (REPORT)"
  label: "NARS Loss Run"
  view_label: "NARS Claims"

join: policy_image_NB {
    from: policy_image
    view_label: "NB Policy"
    type: left_outer
    relationship: one_to_many
    fields: [policy_image_NB.policy_number, policy_image_NB.premium_fullterm]
    sql_on: ${policy_image_NB.policy} = ${customer_reports_nars_loss_run.policy_number}
      and ${policy_image_NB.transtype_id}=2 AND ${policy_image_NB.version_id} in (9,10,11);;
  }

  join: policy_image_RN {
    from: policy_image
    view_label: "RN Policy"
    type: left_outer
    relationship: one_to_many
    fields: [policy_image_RN.policy_number, policy_image_RN.premium_fullterm]
    sql_on: ${policy_image_RN.policy} = ${customer_reports_nars_loss_run.policy_number}
      and ${policy_image_RN.transtype_id}=4 AND ${policy_image_RN.version_id} in (9,10,11);;
  }

  join: claim_control {
    type: left_outer
    relationship: one_to_many
    fields: []
    sql_on: ${customer_reports_nars_loss_run.claim_number} = ${claim_control.claim_number};;
  }

  join: claim_feature {
    type: inner
    relationship: many_to_one
    fields: []
    sql_on: ${claim_feature.claimcontrol_id} = ${claim_control.claimcontrol_id};;
  }

  join: claim_feature_eod {
    type: inner
    relationship: many_to_one
    fields: []
    sql_on: ${claim_feature_eod.claimcontrol_id} = ${claim_feature.claimcontrol_id}
    AND ${claim_feature_eod.claimant_num} = ${claim_feature.claimant_num}
    AND ${claim_feature_eod.claimfeature_num} = ${claim_feature.claimfeature_num}
    AND ${claim_feature_eod.claimeoplevel_id} = 3;;
  }

  join: claim_financials {
    type: inner
    relationship: many_to_one
    sql_on: ${claim_financials.claimcontrol_id} = ${claim_feature_eod.claimcontrol_id}
    AND ${claim_financials.claimfinancials_num} = ${claim_feature_eod.claimfinancials_num};;
  }


  }

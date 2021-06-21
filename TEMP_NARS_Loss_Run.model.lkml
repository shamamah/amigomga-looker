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


  join: v_claimtransaction_adjust2 {
    view_label: "Claim"
    type: left_outer
    relationship: many_to_one
    sql_on: ${policy_image_NB.policy_id} = ${v_claimtransaction_adjust2.policy_id};;

  }
}

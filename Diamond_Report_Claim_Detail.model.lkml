connection: "c76-reporting"

# include all the views
include: "*.view"

explore: v_claimdetail_transaction {
  group_label: "Diamond Analytics (REPORT)"
  label: "Claim Detail"
  view_label: "Claim Detail"

  join: claim_feature {
    type:  inner
    sql_on: ${claim_feature.claimcontrol_id} = ${v_claimdetail_transaction.claimcontrol_id}
    AND ${claim_feature.claimant_num} = ${v_claimdetail_transaction.claimant_num}
    AND ${v_claimdetail_transaction.claimfeature_num} = ${claim_feature.claimfeature_num};;
    relationship: one_to_many
  }

  join: claim_control {
  type: inner
  sql_on: ${v_claimdetail_transaction.claimcontrol_id} = ${claim_control.claimcontrol_id};;
  relationship: one_to_many
  }

  join: policy_image {
    type: inner
    sql_on: ${claim_control.policy_id} = ${policy_image.policy_id}
      AND ${claim_control.policyimage_num} = ${policy_image.policyimage_num};;
    relationship: many_to_one
  }


}

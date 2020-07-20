connection: "c76-reporting"

# include all the views
include: "*.view"

explore: claim_transaction {
  group_label: "Diamond Analytics (REPORT)"
  label: "Claim Management"
  view_label: "Claim Detail"
  sql_always_where: ${claimtransactionstatus_id} IN (1, 4, 7) ;;


  join: v_claimtransaction_adjust2 {
    type: inner
    view_label: "Claim Detail"
    sql_on: ${claim_transaction.compound_primary_key}=${v_claimtransaction_adjust2.compound_primary_key} ;;
    relationship: one_to_one
    fields: [indemnity_paid,indemnity_reserve,expense_paid,alae_paid,subro,salvage]
  }

  join: claim_control {
    type: inner
    view_label: "Claim Detail"
    sql_on: ${claim_transaction.claimcontrol_id} = ${claim_control.claimcontrol_id};;
    relationship: one_to_many

  }

#   join: dt_claim_days_open {
#     view_label: "Claim 1"
#     type: inner
#     relationship: one_to_one
#     sql_on: ${dt_claim_days_open.claimcontrol_id} = ${claim_control.claimcontrol_id} ;;
#   }

  join: policy_image {
    type: inner
    sql_on: ${claim_control.policy_id} = ${policy_image.policy_id}
      AND ${claim_control.policyimage_num} = ${policy_image.policyimage_num};;
    relationship: one_to_many
    fields: []
  }

  join: policy_image_name_link {
    type: inner
    sql_on:  ${policy_image.policy_id}=${policy_image_name_link.policy_id}
            AND  ${policy_image.policyimage_num}=${policy_image_name_link.policyimage_num}
            AND ${}${policy_image_name_link.nameaddresssource_id}=3;;
    relationship: one_to_many
    fields: []
  }

  join: name {
    type: inner
    sql_on: ${policy_image_name_link.name_id}=${name.name_id};;
    relationship: one_to_one
    fields: []
  }

  join: v_agency {
    type: inner
    sql_on: ${v_agency.agency_id} = ${policy_image.agency_id} ;;
    relationship: one_to_many
  }

  join: claim_feature {
    type:  inner
    sql_on: ${claim_feature.claimcontrol_id} = ${claim_transaction.claimcontrol_id}
          AND ${claim_feature.claimant_num} = ${claim_transaction.claimant_num}
          AND ${claim_transaction.claimfeature_num} = ${claim_feature.claimfeature_num};;
    relationship: one_to_one
    fields: [claim_feature.coverage_dscr, claim_feature.in_litigation, claim_feature.in_salvage, claim_feature.in_suit,
      claim_feature.reported_date_date, claim_feature.reported_date_month, claim_feature.reported_date_quarter,
      claim_feature.reported_date_year, claim_feature.reported_date_week]
  }

  join: claim_feature_personnel {
    type:  inner
    sql_on:  ${claim_feature.claimcontrol_id} = ${claim_feature_personnel.claimcontrol_id}
          AND ${claim_feature.claimant_num} = ${claim_feature_personnel.claimant_num}
          AND ${claim_feature.claimfeature_num} = ${claim_feature_personnel.claimfeature_num}
          AND ${claim_feature_personnel.claimpersonneltype_id} = 3
          AND ${claim_feature_personnel.claimadjustertype_id} = 1;;
    relationship: one_to_one
    fields: []
  }

  join: claim_personnel {
    view_label: "Claim Detail"
    type:  inner
    sql_on:  ${claim_personnel.claimpersonnel_id} = ${claim_feature_personnel.claimpersonnel_id};;
    relationship: one_to_many
    fields: []
  }

  join: v_users {
    view_label: "Claim Detail"
    type: inner
    sql_on: ${v_users.users_id} =  ${claim_personnel.users_id};;
    relationship:  one_to_one
    fields: [display_name1]
  }

  join: dt_claim_coverage {
    type:  inner
    sql_on: ${claim_feature.claimcontrol_id}=${dt_claim_coverage.claimcontrol_id}
            AND ${claim_feature.claimexposure_id}=${dt_claim_coverage.claimexposure_id}
            AND ${claim_feature.claimsubexposure_num}=${dt_claim_coverage.claimsubexposure_num}
            AND ${claim_feature.claimcoverage_num}=${dt_claim_coverage.claimcoverage_num};;
    relationship: one_to_many
    fields: []
  }

  join: dt_company_coverages {
    type: inner
    sql_on: ${dt_claim_coverage.coveragecode_id}=${dt_company_coverages.coveragecode_id}
      AND ${policy_image.version_id}=${dt_company_coverages.version_id};;
    relationship: one_to_many
    fields: []
  }

  join: major_peril {
    type: inner
    sql_on: ${dt_company_coverages.majorperil_id}=${major_peril.majorperil_id} ;;
    relationship: one_to_many
    fields: []
  }

  join: asl {
    type: inner
    sql_on: ${dt_company_coverages.asl_id}=${asl.asl_id};;
    relationship: one_to_many
    fields: []
  }

  join: claim_catastrophe {
    view_label: "Claim Detail"
    type: inner
    sql_on: ${claim_control.claimcatastrophe_id}=${claim_catastrophe.claimcatastrophe_id};;
    relationship: one_to_many
    fields: [claim_catastrophe.dscr]
  }

  join: claim_transaction_type {
    type: inner
    sql_on: ${claim_transaction.claimtransactiontype_id}=${claim_transaction_type.claimtransactiontype_id};;
    relationship: one_to_many
    fields: []
  }

  join: version {
    type: inner
    sql_on: ${policy_image.version_id}=${version.version_id} ;;
    relationship: one_to_many
    fields: []
  }

  join: company_state_lob {
    type: inner
    sql_on: ${version.companystatelob_id}=${company_state_lob.companystatelob_id};;
    relationship: one_to_many
  }

  join: reinsurance_treaty {
    type: inner
    sql_on: ${policy_image.eff_date} between ${reinsurance_treaty.effective_date} AND ${reinsurance_treaty.expiration_date} ;;
    relationship: one_to_many
  }

  join: dt_claimcount {
    view_label: "Claim Counts"
    type:  inner
    sql_on: ${dt_claimcount.claimcontrol_id} = ${v_claimtransaction_adjust2.claimcontrol_id}
          AND ${dt_claimcount.claimant_num} = ${v_claimtransaction_adjust2.claimant_num}
          AND ${v_claimtransaction_adjust2.claimfeature_num} = ${dt_claimcount.claimfeature_num};;
#           AND ${claim_transaction.added_date} = ${dt_claimcount.processingdate_date};;
      relationship: many_to_one
    }







  }

connection: "c76-reporting"

# include all the views
include: "/views/*.view"
include: "*.view"



fiscal_month_offset: 0
week_start_day: sunday

explore: dt_mvr_driver {
  group_label: "Diamond Analytics (REPORT)"
  label: "TEMPORARY MVR"
  view_label: "MVR"

join: dt_premiums  {
  view_label: "Premium"
  type: inner
  relationship: many_to_one
  sql_on: ${dt_mvr_driver.policy_id} = ${dt_premiums.policy_id}
      --AND ${dt_mvr_driver.renewal_ver} = ${dt_premiums.renewal_ver}
       ;;
  }

  join: company_state_lob {
    view_label: "Company"
    type: inner
    relationship: one_to_many
    sql_on: ${company_state_lob.company_id} = ${dt_premiums.company_id}
        AND ${company_state_lob.lob_id} = ${dt_premiums.lob_id}
        AND ${company_state_lob.state_id} = ${dt_premiums.state_id};;
  }

  join: dt_mtd_claims {
    view_label: "Claims"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dt_premiums.policy_id} = ${dt_mtd_claims.policy_id}
            AND ${dt_premiums.renewal_ver} = ${dt_mtd_claims.renewal_ver}
            AND ${dt_premiums.unit_num} = ${dt_mtd_claims.vehicle_num}
            AND ${dt_premiums.coveragecode_id} = ${dt_mtd_claims.coveragecode_id}
            AND ${dt_premiums.year} = ${dt_mtd_claims.year}
            AND ${dt_premiums.month} = ${dt_mtd_claims.month};;
  }

  join: policy_image {
    type: inner
    relationship: one_to_one
    sql_on: ${dt_mvr_driver.policy_id} = ${policy_image.policy_id}
          AND ${dt_mvr_driver.policyimage_num} = ${policy_image.policyimage_num};;
  }

  join: reinsurance_treaty {
    type: inner
    sql_on: ${policy_image.eff_date} between ${reinsurance_treaty.effective_date} AND ${reinsurance_treaty.expiration_date}
        AND ${reinsurance_treaty.treatylob} = ${policy_image.version_id} ;;
    relationship: one_to_many
  }

}

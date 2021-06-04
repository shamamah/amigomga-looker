connection: "c76-reporting"

# include all the views
include: "/views/*.view"
include: "*.view"



fiscal_month_offset: 0
week_start_day: sunday

explore: pdt_renewals_rollovers {
  group_label: "Diamond Analytics (REPORT)"
  label: "Renewals and Rollovers"
  view_label: "Renewals_Rollovers"

  join: dt_coverage_liab_phys {
    view_label: "Renewals_Rollovers"
    type: inner
    relationship: many_to_one
    sql_on: ${pdt_renewals_rollovers.current_policy_id} = ${dt_coverage_liab_phys.policy_id}
      AND ${pdt_renewals_rollovers.current_policyimage_num} = ${dt_coverage_liab_phys.policyimage_num};;
  }

  join: dt_mtd_claims {
    view_label: "Claim"
    type: left_outer
    relationship: many_to_one
    sql_on: ${pdt_renewals_rollovers.current_policy_id} = ${dt_mtd_claims.policy_id};;
      # AND ${pdt_renewals_rollovers.current_policyimage_num} = ${dt_mtd_claims.policyimage_num};;
  }
}

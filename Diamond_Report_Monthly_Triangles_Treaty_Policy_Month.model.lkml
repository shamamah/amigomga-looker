connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_caryears_triangle_treaty_policy_month {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangles - Treaty Policy Month (CarYears)"
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

  join: eop_claimcounts_triangle_treaty_policy_month {
      view_label: "Loss Counts"
      type: left_outer
      relationship: one_to_one
      # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
      sql_on: ${eop_caryears_triangle_treaty_policy_month.policy_month} = ${eop_claimcounts_triangle_treaty_policy_month.policy_month}
        AND ${eop_caryears_triangle_treaty_policy_month.lag_month} = ${eop_claimcounts_triangle_treaty_policy_month.lag_month}
        AND ${eop_caryears_triangle_treaty_policy_month.coveragecode_id} = ${eop_claimcounts_triangle_treaty_policy_month.coveragecode_id}
        AND ${eop_caryears_triangle_treaty_policy_month.lob_id} = ${eop_claimcounts_triangle_treaty_policy_month.lob_id}
        AND ${eop_caryears_triangle_treaty_policy_month.new_renewal} = ${eop_claimcounts_triangle_treaty_policy_month.new_ren}
        AND ${eop_caryears_triangle_treaty_policy_month.treaty} = ${eop_claimcounts_triangle_treaty_policy_month.treaty};;
#       AND ${eop_claims_triangle_quarter.liab_full} = ${eop_premium_triangle_quarter.liab_full}

      }

    }

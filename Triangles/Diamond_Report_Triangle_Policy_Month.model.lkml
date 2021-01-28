connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_premium_triangle_policy_month {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangles by Policy Month"
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

  join: eop_claims_triangle_policy_month {
    view_label: "Loss Amounts"
    type: left_outer
    relationship: many_to_one
    sql_on:
         ${eop_claims_triangle_policy_month.lag_month} = ${eop_premium_triangle_policy_month.lag_year_month}
        AND ${eop_claims_triangle_policy_month.policy_month} = ${eop_premium_triangle_policy_month.policy_month}
        AND ${eop_claims_triangle_policy_month.coveragecode_id} = ${eop_premium_triangle_policy_month.coveragecode_id}
        AND ${eop_claims_triangle_policy_month.lob_id} = ${eop_premium_triangle_policy_month.lob_id}
        AND ${eop_claims_triangle_policy_month.new_renewal} = ${eop_premium_triangle_policy_month.new_renewal}
        AND ${eop_claims_triangle_policy_month.treaty} = ${eop_premium_triangle_policy_month.treaty};;

    }

    join: eop_claimcounts_triangle_policy_month {
      view_label: "Loss Counts"
      type: left_outer
      relationship: many_to_one
      sql_on:
         ${eop_claimcounts_triangle_policy_month.lag_month} = ${eop_premium_triangle_policy_month.lag_year_month}
        AND ${eop_claimcounts_triangle_policy_month.policy_month} = ${eop_premium_triangle_policy_month.policy_month}
        AND ${eop_claimcounts_triangle_policy_month.coveragecode_id} = ${eop_premium_triangle_policy_month.coveragecode_id}
        AND ${eop_claimcounts_triangle_policy_month.lob_id} = ${eop_premium_triangle_policy_month.lob_id}
        AND ${eop_claimcounts_triangle_policy_month.new_ren} = ${eop_premium_triangle_policy_month.new_renewal}
        AND ${eop_claimcounts_triangle_policy_month.treaty} = ${eop_premium_triangle_policy_month.treaty};;

      }


    }

connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_premium_triangle_treaty_month {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangles - Treaty Month"
  hidden: no
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

  join: eop_claims_triangle_treaty_policy_month {
    view_label: "Loss"
    type: left_outer
    relationship: many_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on:
         ${eop_claims_triangle_treaty_policy_month.lag_month} = ${eop_premium_triangle_treaty_month.lag_year_month}
        AND ${eop_claims_triangle_treaty_policy_month.policy_month} = ${eop_premium_triangle_treaty_month.policy_month}
        AND ${eop_claims_triangle_treaty_policy_month.coveragecode_id} = ${eop_premium_triangle_treaty_month.coveragecode_id}
        AND ${eop_claims_triangle_treaty_policy_month.lob_id} = ${eop_premium_triangle_treaty_month.lob_id}
        AND ${eop_claims_triangle_treaty_policy_month.new_renewal} = ${eop_premium_triangle_treaty_month.new_renewal}
       AND ${eop_claims_triangle_treaty_policy_month.treaty} = ${eop_premium_triangle_treaty_month.treaty};;
# --  ${eop_claims_triangle_treaty_quarter.accident_quarter} = ${eop_premium_triangle_treaty_quarter.trans_year_quarter}
# --        AND ${eop_claims_triangle_treaty_quarter.lag_year_quarter} = ${eop_premium_triangle_treaty_quarter.lag_year_quarter}

    }

  }

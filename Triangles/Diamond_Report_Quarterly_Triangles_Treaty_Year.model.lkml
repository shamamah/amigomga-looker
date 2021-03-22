connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_premium_triangle_treaty_quarter {
  group_label: "Diamond Analytics (Triangles)"
  label: "Treaty Triangles by Policy Quarter"
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

    join: eop_caryear_triangle_treaty_quarter {
      view_label: "Car Years"
      type: left_outer
      relationship: many_to_one
      # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
      sql_on:
          ${eop_caryear_triangle_treaty_quarter.lag_year_quarter} = ${eop_premium_triangle_treaty_quarter.lag_year_quarter}
          AND  ${eop_caryear_triangle_treaty_quarter.policy_quarter} = ${eop_premium_triangle_treaty_quarter.policy_quarter}
          AND ${eop_caryear_triangle_treaty_quarter.coveragecode_id} = ${eop_premium_triangle_treaty_quarter.coveragecode_id}
          AND ${eop_caryear_triangle_treaty_quarter.lob_id} = ${eop_premium_triangle_treaty_quarter.lob_id}
          AND ${eop_caryear_triangle_treaty_quarter.new_renewal} = ${eop_premium_triangle_treaty_quarter.new_renewal}
          AND ${eop_caryear_triangle_treaty_quarter.treaty} = ${eop_premium_triangle_treaty_quarter.treaty}
          AND ${eop_caryear_triangle_treaty_quarter.renewal_ver} = ${eop_premium_triangle_treaty_quarter.renewal_ver}
  ;;
  }

  join: eop_claims_triangle_treaty_quarter {
    view_label: "Loss"
    type: left_outer
    relationship: many_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on:
         ${eop_claims_triangle_treaty_quarter.lag_year_quarter} = ${eop_premium_triangle_treaty_quarter.lag_year_quarter}
        AND  ${eop_claims_triangle_treaty_quarter.policy_quarter} = ${eop_premium_triangle_treaty_quarter.policy_quarter}
        AND ${eop_claims_triangle_treaty_quarter.coveragecode_id} = ${eop_premium_triangle_treaty_quarter.coveragecode_id}
        AND ${eop_claims_triangle_treaty_quarter.lob_id} = ${eop_premium_triangle_treaty_quarter.lob_id}
        AND ${eop_claims_triangle_treaty_quarter.new_renewal} = ${eop_premium_triangle_treaty_quarter.new_renewal}
        AND ${eop_claims_triangle_treaty_quarter.treaty} = ${eop_premium_triangle_treaty_quarter.treaty}
        AND ${eop_claims_triangle_treaty_quarter.renewal_ver} = ${eop_premium_triangle_treaty_quarter.renewal_ver}
;;
    }

  join: eop_claimcounts_triangle_treaty_policy_quarter {
    view_label: "Loss Counts"
    type: left_outer
    relationship: many_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on:
         ${eop_claimcounts_triangle_treaty_policy_quarter.lag_quarter} = ${eop_premium_triangle_treaty_quarter.lag_year_quarter}
        AND  ${eop_claimcounts_triangle_treaty_policy_quarter.policy_quarter} = ${eop_premium_triangle_treaty_quarter.policy_quarter}
        AND ${eop_claimcounts_triangle_treaty_policy_quarter.coveragecode_id} = ${eop_premium_triangle_treaty_quarter.coveragecode_id}
        AND ${eop_claimcounts_triangle_treaty_policy_quarter.lob_id} = ${eop_premium_triangle_treaty_quarter.lob_id}
        AND ${eop_claimcounts_triangle_treaty_policy_quarter.new_ren} = ${eop_premium_triangle_treaty_quarter.new_renewal}
        AND ${eop_claimcounts_triangle_treaty_policy_quarter.treaty} = ${eop_premium_triangle_treaty_quarter.treaty}
        AND ${eop_claimcounts_triangle_treaty_policy_quarter.renewal_version} = ${eop_premium_triangle_treaty_quarter.renewal_ver}
;;
    }
  }

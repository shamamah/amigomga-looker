connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_premium_triangle_treaty_quarter {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangles - Treaty Quarter"
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

  join: eop_claims_triangle_treaty_quarter {
    view_label: "Loss"
    type: left_outer
    relationship: many_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on:
         ${eop_claims_triangle_treaty_quarter.lag_year_quarter} = ${eop_premium_triangle_treaty_quarter.lag_year_quarter}
        AND ${eop_claims_triangle_treaty_quarter.coveragecode_id} = ${eop_premium_triangle_treaty_quarter.coveragecode_id}
        AND ${eop_claims_triangle_treaty_quarter.lob_id} = ${eop_premium_triangle_treaty_quarter.lob_id}
        AND ${eop_claims_triangle_treaty_quarter.new_renewal} = ${eop_premium_triangle_treaty_quarter.new_renewal}
       AND ${eop_claims_triangle_treaty_quarter.treaty} = ${eop_premium_triangle_treaty_quarter.treaty};;
# --  ${eop_claims_triangle_treaty_quarter.accident_quarter} = ${eop_premium_triangle_treaty_quarter.trans_year_quarter}
# --        AND ${eop_claims_triangle_treaty_quarter.lag_year_quarter} = ${eop_premium_triangle_treaty_quarter.lag_year_quarter}

    }

  }

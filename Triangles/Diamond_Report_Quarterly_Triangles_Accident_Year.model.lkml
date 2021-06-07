connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_premium_triangle_accident_quarterly {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangles - Accident Quarter"
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

  join: eop_claims_triangle_accident_quarter {
    view_label: "Loss"
    type: left_outer
    relationship: many_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on: ${eop_claims_triangle_accident_quarter.accident_quarter} = ${eop_premium_triangle_accident_quarterly.policy_year_quarter}
         AND ${eop_claims_triangle_accident_quarter.lag_year_quarter} = ${eop_premium_triangle_accident_quarterly.lag_year_quarter}
        AND ${eop_claims_triangle_accident_quarter.coveragecode_id} = ${eop_premium_triangle_accident_quarterly.coveragecode_id}
        AND ${eop_claims_triangle_accident_quarter.lob_id} = ${eop_premium_triangle_accident_quarterly.lob_id}
        AND ${eop_claims_triangle_accident_quarter.new_renewal} = ${eop_premium_triangle_accident_quarterly.new_renewal}
        AND ${eop_claims_triangle_accident_quarter.company_id} = ${eop_premium_triangle_accident_quarterly.company_id};;
#       AND ${eop_claims_triangle_quarter.liab_full} = ${eop_premium_triangle_quarter.liab_full}

    }

  }

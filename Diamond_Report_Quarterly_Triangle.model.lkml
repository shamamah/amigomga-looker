connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_premium_triangle_quarter {
  group_label: "Diamond Analytics (Triangles)"
  label: "Quarterly Triangles"
  view_label: "Premium"

join: eop_claims_triangle_quarter {
  view_label: "Loss"
  type: left_outer
  relationship: many_to_one
  # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
  sql_on: ${eop_claims_triangle_quarter.policy_year_quarter} = ${eop_premium_triangle_quarter.policy_year_quarter}
         AND ${eop_claims_triangle_quarter.lag_year_quarter} = ${eop_premium_triangle_quarter.lag_year_quarter}
        AND ${eop_claims_triangle_quarter.coveragecode_id} = ${eop_premium_triangle_quarter.coveragecode_id}
        AND ${eop_claims_triangle_quarter.lob_id} = ${eop_premium_triangle_quarter.lob_id}
;;


}

}

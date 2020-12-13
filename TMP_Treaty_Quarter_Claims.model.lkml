connection: "c76-reporting"

# include all the views
include: "*.view"

explore: eop_claims_triangle_treaty_quarter_solo {
  group_label: "Diamond Analytics (Triangles)"
  label: "Losses by Treaty Quarter"
  view_label: "Claims"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

#   join: eop_claims_triangle_treaty_month {
#       view_label: "Treaty Monthly Claims"
#       type: left_outer
#       relationship: one_to_one
#       # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
#       sql_on: ${eop_claims_triangle_treaty_month.lag_year_month} = ${eop_claimcounts_triangle_treaty_accident_month.lagmonth}
#         AND ${eop_claims_triangle_treaty_month.accident_month} = ${eop_claimcounts_triangle_treaty_accident_month.accidentmonth}
#         AND ${eop_claims_triangle_treaty_month.lob_id} = ${eop_claimcounts_triangle_treaty_accident_month.lob_id}
#         AND ${eop_claims_triangle_treaty_month.coveragecode_id} = ${eop_claimcounts_triangle_treaty_accident_month.coveragecode_id}
#         AND ${eop_claims_triangle_treaty_month.new_renewal} = ${eop_claimcounts_triangle_treaty_accident_month.new_ren}
#         AND ${eop_claims_triangle_treaty_month.treaty} = ${eop_claimcounts_triangle_treaty_accident_month.treaty};;
# #       AND ${eop_claims_triangle_quarter.liab_full} = ${eop_premium_triangle_quarter.liab_full}

#       }

}

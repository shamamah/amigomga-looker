connection: "c76-reporting"

include: "*.view"                # include all views in the views/ folder in this project

explore: eop_premium_triangle_accident_month {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangles - Accident Month"
  view_label: "Premium"
  # fields: [total_written_premium, total_earned_premium, total_unearned_premium]

  join: eop_claims_triangle_accident_month {
    view_label: "Loss"
    type: left_outer
    relationship: many_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on: ${eop_claims_triangle_accident_month.accident_month} = ${eop_premium_triangle_accident_month.policy_month}
         AND ${eop_claims_triangle_accident_month.lag_month} = ${eop_premium_triangle_accident_month.lag_month}
        AND ${eop_claims_triangle_accident_month.coveragecode_id} = ${eop_premium_triangle_accident_month.coveragecode_id}
        AND ${eop_claims_triangle_accident_month.lob_id} = ${eop_premium_triangle_accident_month.lob_id}
        AND ${eop_claims_triangle_accident_month.company_id} = ${eop_premium_triangle_accident_month.company_id}
        AND ${eop_claims_triangle_accident_month.new_renewal} = ${eop_premium_triangle_accident_month.new_renewal};;
#       AND ${eop_claims_triangle_quarter.liab_full} = ${eop_premium_triangle_quarter.liab_full}

    }

  join: eop_claimcounts_triangle_accident_month {
    view_label: "Loss Counts"
    type: left_outer
    relationship: one_to_one
    # sql_on: ${eop_claims_triangle_quarter.itd_claims_primarykey} = ${eop_premium_triangle_quarter.eop_primary} ;;
    sql_on: ${eop_premium_triangle_accident_month.policy_month} = ${eop_claimcounts_triangle_accident_month.accidentmonth}
         AND ${eop_premium_triangle_accident_month.lag_month} = ${eop_claimcounts_triangle_accident_month.lagmonth}
        AND ${eop_premium_triangle_accident_month.coveragecode_id} = ${eop_claimcounts_triangle_accident_month.coveragecode_id}
        AND ${eop_premium_triangle_accident_month.lob_id} = ${eop_claimcounts_triangle_accident_month.lob_id}
        AND ${eop_premium_triangle_accident_month.company_id} = ${eop_claimcounts_triangle_accident_month.company_id}
        AND ${eop_premium_triangle_accident_month.new_renewal} = ${eop_claimcounts_triangle_accident_month.new_ren};;
#       AND ${eop_claims_triangle_quarter.liab_full} = ${eop_premium_triangle_quarter.liab_full}

    }

  }

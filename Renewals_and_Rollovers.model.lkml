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
}

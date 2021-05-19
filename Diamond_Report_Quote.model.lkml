connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: dt_quote_activity{
  group_label: "Diamond Analytics (REPORT)"
  label: "Quote"
  view_label: "Quote"
}

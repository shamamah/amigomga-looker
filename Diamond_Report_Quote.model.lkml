connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

datagroup: quote_datagroup {
  label: "Product Datagroup"
  sql_trigger: SELECT max(pcadded_date) FROM policy;;
  max_cache_age: "24 hours"
}

persist_with: quote_datagroup

explore: dt_quote_activity{
  group_label: "Diamond Analytics (REPORT)"
  label: "Quote"
  view_label: "Quote"
}

connection: "c76-reporting"

# include all the views
include: "*.view"

explore: pdt_avg_premium_triangle {
  group_label: "Diamond Analytics (Triangles)"
  label: "Triangle Avg Premium and Frequency"
  view_label: "Premium"

join: pdt_claims_frequency_triangle {
  view_label: "Claims"
  type: left_outer
  sql_on: ${pdt_claims_frequency_triangle.primay_key} = ${pdt_avg_premium_triangle.primay_key};;
  relationship: one_to_one

}

}

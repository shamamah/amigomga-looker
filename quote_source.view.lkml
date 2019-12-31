view: quote_source {
  sql_table_name: dbo.QuoteSource ;;

  dimension: quotesource_id {
    hidden: yes
    type: number
    sql: ${TABLE}.quotesource_id ;;
  }

  dimension: dscr {
    label: "Source"
    type: string
    sql: ${TABLE}.dscr ;;
  }
}

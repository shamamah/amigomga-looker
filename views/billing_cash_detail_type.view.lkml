view: billing_cash_detail_type {
  sql_table_name: dbo.BillingCashDetailType ;;

  dimension: billingcashdetailtype_id {
    type: number
    hidden: yes
    sql: ${TABLE}.billingcashdetailtype_id ;;
  }

  dimension: dscr {
    label: "Detail Description"
    type: string
    sql: ${TABLE}.dscr ;;
  }


  dimension_group: pcadded {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pcadded_date ;;
  }


}

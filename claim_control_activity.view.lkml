view: claim_control_activity {
  sql_table_name: dbo.ClaimControlActivity ;;

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},${num}) ;;
  }

  dimension: claimactivitycode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimactivitycode_id ;;
  }

  dimension: claimcontrol_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: dscr {
    hidden: yes
    type: string
    label: "Description"
    sql: ${TABLE}.dscr ;;
  }

  dimension: num {
    hidden: yes
    type: number
    sql: ${TABLE}.num ;;
  }

  dimension_group: : claim_open_Date {
    label: "Open"
    view_label: "Claim"
    type: time
    timeframes: [date,month,quarter,year]
    sql: ${TABLE}.pcadded_date ;;
  }
}

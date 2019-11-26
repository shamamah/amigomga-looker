view: claim_pay_type {
  sql_table_name: dbo.ClaimPayType ;;

  dimension: claimpaytype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.claimpaytype_id ;;
  }

  dimension: dscr {
    label: "Payment Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: enabled {
    hidden: yes
    type: string
    sql: ${TABLE}.enabled ;;
  }

  dimension: is_payment {
    hidden: yes
    type: string
    sql: ${TABLE}.is_payment ;;
  }

  dimension: short_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.short_dscr ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

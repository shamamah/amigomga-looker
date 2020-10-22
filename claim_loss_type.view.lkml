view: claim_loss_type {
  sql_table_name: dbo.ClaimLossType ;;

  dimension: claimlosstype_id {
    label: "Loss Type Code"
    primary_key: yes
    hidden: no
    type: number
    sql: ${TABLE}.claimlosstype_id ;;
  }

  dimension: dscr {
    label: "Loss Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

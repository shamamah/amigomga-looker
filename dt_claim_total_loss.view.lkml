view: dt_claim_total_loss {
  derived_table: {
    sql: select distinct claimcontrol_id, dscr from claimcontrolvehicle ccv
      join ClaimLossIndicatorType clit ON clit.claimlossindicatortype_id = ccv.lossindicatortype_id
      where lossindicatortype_id = 2
       ;;
  }


  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: dscr {
    label: "Total Loss Indicator"
    type: string
    sql: ${TABLE}.dscr ;;
  }


}

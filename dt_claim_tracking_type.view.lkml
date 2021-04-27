view: dt_claim_tracking_type {
  derived_table: {
    sql: Select claimcontrol_id, ctt.dscr from claimcontroltrackingtype cctt
            JOIN claimtrackingtype ctt ON ctt.claimtrackingtype_id = cctt.claimtrackingtype_id
             ;;
  }

  dimension: claimcontrol_id {
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: dscr {
    label: "Tracking Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

}

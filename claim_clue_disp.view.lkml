view: claim_clue_disp {
  sql_table_name: dbo.ClaimClueDisp ;;

  dimension: claimcluedisp_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.claimcluedisp_id ;;
  }

  dimension: dscr {
    label: "Disposition"
    type: string
    sql: ${TABLE}.dscr ;;
  }
}

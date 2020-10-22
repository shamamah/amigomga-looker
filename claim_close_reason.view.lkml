view: claim_close_reason {
  sql_table_name: ClaimCloseReason;;


    dimension: claimclosereason_id {
      type: number
      hidden: yes
      primary_key: yes
      sql: ${TABLE}.claimclosereason_id ;;
    }

    dimension: dscr {
      label: "Close Reason"
      type: string
      sql: ${TABLE}.dscr ;;
    }

 }

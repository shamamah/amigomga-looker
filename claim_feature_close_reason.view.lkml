view: claim_feature_close_reason {
  sql_table_name: ClaimFeatureCloseReason;;

    dimension: claimfeatureclosereason_id {
      type: number
      hidden: yes
      primary_key: yes
      sql: ${TABLE}.claimfeatureclosereason_id ;;
    }

    dimension: dscr {
      label: "Feature Close Reason"
      type: string
      sql: ${TABLE}.dscr ;;
    }

 }

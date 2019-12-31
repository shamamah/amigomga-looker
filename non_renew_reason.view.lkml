view: non_renew_reason {
  sql_table_name: dbo.NonRenewReason ;;

  dimension: nonrenewreason_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.nonrenewreason_id ;;
  }

  dimension: dscr {
    label: "Non-Renew Reason"
    type: string
    sql: ${TABLE}.dscr ;;
  }
}

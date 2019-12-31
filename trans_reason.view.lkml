view: trans_reason {
  sql_table_name: dbo.TransReason ;;

  dimension: transreason_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.transreason_id ;;
  }

#   dimension: coverageverifiertranstype_id {
#     type: number
#     sql: ${TABLE}.coverageverifiertranstype_id ;;
#   }

  dimension: dscr {
    label: "Reason"
    type: string
    sql: ${TABLE}.dscr ;;
  }

#   dimension: ncci_code {
#     type: string
#     sql: ${TABLE}.ncci_code ;;
#   }

#   dimension: status {
#     type: string
#     sql: ${TABLE}.status ;;
#   }

#   dimension: transreason_id {
#     type: number
#     sql: ${TABLE}.transreason_id ;;
#   }

  dimension: transreasoncategory_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transreasoncategory_id ;;
  }

  dimension: transtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.transtype_id ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

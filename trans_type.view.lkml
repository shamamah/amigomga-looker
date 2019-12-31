view: trans_type {
  sql_table_name: dbo.TransType ;;

  dimension: transtype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.transtype_id ;;
  }

#   dimension: coverageverifiertranstype_id {
#     type: number
#     sql: ${TABLE}.coverageverifiertranstype_id ;;
#   }

  dimension: dscr {
    label: "Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: printreason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.printreason_id ;;
  }

  dimension: require_teff_time {
    hidden: yes
    type: string
    sql: ${TABLE}.require_teff_time ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: transtype {
    hidden: yes
    type: string
    sql: ${TABLE}.transtype ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

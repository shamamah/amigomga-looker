view: claim_catastrophe {
  sql_table_name: dbo.ClaimCatastrophe ;;

  dimension: claimcatastrophe_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcatastrophe_id ;;
  }

  dimension: dscr {
    type: string
    label: "CAT Description"
    sql: ${TABLE}.dscr ;;
  }

  dimension_group: enddate {
    label: "End Date"
    type: time
    timeframes: [date]
    sql: ${TABLE}.enddate ;;
  }

  dimension_group: startdate {
    label: "Begin Date"
    type: time
    timeframes: [date]
    sql: ${TABLE}.startdate ;;
  }

  dimension: user_code {
    label: "CAT Number"
    type: string
    hidden: no
    sql: ${TABLE}.user_code ;;
  }

  dimension: users_id {
    type: number
    hidden: yes
    sql: ${TABLE}.users_id ;;
  }

  dimension: year {
    label: "Year"
    type: number
    #hidden: yes
    sql: ${TABLE}.year ;;
  }

  dimension: year_display_order {
    type: number
    hidden: yes
    sql: ${TABLE}.year_display_order ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [users.users_id, users.login_name]
  }
}

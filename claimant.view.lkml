view: claimant {
  sql_table_name: dbo.Claimant ;;

  dimension: claimant_num {
    label: "Number"
    hidden: no
    type: number
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimcontrol_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimpayee_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimpayee_id ;;
  }

  dimension: contacted {
    label: "Is Contacted"
    type: string
    sql: Case When ${TABLE}.contacted=1 Then 'Yes' Else 'No' End ;;
  }

  dimension_group: contacted_date {
    label: "Contacted"
    type: time
    timeframes: [time,date,week,month,quarter,year]
    sql: Case When ${TABLE}.contacted_date<'1900-01-01' Then NULL Else ${TABLE}.contacted_date End ;;
  }
}

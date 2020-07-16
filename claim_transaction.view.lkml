view: claim_transaction {
  sql_table_name: dbo.ClaimTransaction ;;

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},' ',${claimant_num},' ',${claimfeature_num},' ',${claimtransaction_num}) ;;
  }

  dimension: claimcontrol_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension_group: pcadded_date {
    label: "Transaction Date"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension_group: eff_date {
    label: "Transaction Eff Date"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.eff_date;;
  }

  dimension_group: check_date {
    label: "Check Date"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.check_date;;
  }

  dimension: added_date {
    hidden: yes
    type: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: claimant_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: claimtransaction_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransaction_num ;;
  }

  dimension: claimtransactionstatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactionstatus_id ;;
  }

  dimension: claimtransactiontype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimtransactiontype_id ;;
  }

  dimension: claimpaytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimpaytype_id ;;
  }

  dimension: manual_check {
    label: "Is Manual Check"
    type: string
    sql: case when ${TABLE}.manual_check=1 then 'Yes' else 'No' end ;;
  }

  dimension: memo {
    label: "Memo"
    type: string
    sql: ${TABLE}.memo ;;
  }

  dimension_group: void {
    label: "Void"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: case when ${TABLE}.voided_date < '1900-01-01' then NULL else ${TABLE}.voided_date end ;;
  }
}

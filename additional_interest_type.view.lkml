view: additional_interest_type {
  sql_table_name: dbo.AdditionalInterestType ;;

  dimension: add_to_claim {
    hidden: yes
    type: string
    sql: ${TABLE}.add_to_claim ;;
  }

  dimension: add_to_claim_report {
    hidden: yes
    type: string
    sql: ${TABLE}.add_to_claim_report ;;
  }

  dimension: additionalinteresttype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.additionalinteresttype_id ;;
  }

  dimension: coverageverifierinterestedpartytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coverageverifierinterestedpartytype_id ;;
  }

  dimension: dscr {
    label: "Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: is_premium_finance_company {
    hidden: yes
    type: string
    sql: ${TABLE}.is_premium_finance_company ;;
  }

  dimension: ismortgagee {
    hidden: yes
    type: string
    sql: ${TABLE}.ismortgagee ;;
  }

  dimension_group: last_modified {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: pcadded {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: upload_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.upload_dscr ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

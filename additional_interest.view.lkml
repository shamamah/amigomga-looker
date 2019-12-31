view: additional_interest {
  sql_table_name: dbo.AdditionalInterest ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_id}, '  ', ${policyimage_num}, ' ', ${additionalinterest_num}) ;;
  }

  dimension_group: added {
    label: "Added"
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: added_policyimage_num {
    label: "Image Number Added"
    type: number
    sql: ${TABLE}.added_policyimage_num ;;
  }

  dimension: additionalinterest_num {
    label: "Number"
    type: number
    sql: ${TABLE}.additionalinterest_num ;;
  }

  dimension: additionalinterestlist_id {
    hidden: yes
    type: number
    sql: ${TABLE}.additionalinterestlist_id ;;
  }

  dimension: additionalinteresttype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.additionalinteresttype_id ;;
  }

  dimension: atima {
    hidden: yes
    type: string
    sql: ${TABLE}.atima ;;
  }

  dimension: bill_to {
    hidden: yes
    type: string
    sql: ${TABLE}.bill_to ;;
  }

  dimension: deleted_policyimage_num {
    label: "Image Number Deleted"
    type: number
    sql: ${TABLE}.deleted_policyimage_num ;;
  }

  dimension: description {
    hidden: yes
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  dimension: external_id {
    hidden: yes
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: has_waiver_of_subrogation {
    hidden: yes
    type: string
    sql: ${TABLE}.has_waiver_of_subrogation ;;
  }

  dimension: interestinproperty {
    hidden: yes
    type: string
    sql: ${TABLE}.interestinproperty ;;
  }

  dimension: isaoa {
    hidden: yes
    type: string
    sql: ${TABLE}.isaoa ;;
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

  dimension: loan_amount {
    hidden: yes
    type: string
    sql: ${TABLE}.loan_amount ;;
  }

  dimension: loan_number {
    hidden: yes
    type: string
    sql: ${TABLE}.loan_number ;;
  }

  dimension: other {
    hidden: yes
    type: string
    sql: ${TABLE}.other ;;
  }

  dimension_group: pcadded {
    hidden:yes
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

  dimension: policy_id {
    hidden:yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden:yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: policyleveladditionalinterestlist_num {
    hidden: yes
    type: number
    sql: ${TABLE}.policyleveladditionalinterestlist_num ;;
  }

  dimension_group: trustagreement {
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
    sql: ${TABLE}.trustagreement_date ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

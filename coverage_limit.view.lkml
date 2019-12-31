view: coverage_limit {
  sql_table_name: dbo.CoverageLimit ;;

  dimension: aggregate_limit {
    hidden: yes
    type: string
    sql: ${TABLE}.aggregate_limit ;;
  }

  dimension: claim_deduct_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.claim_deduct_dscr ;;
  }

  dimension: claim_deductible {
    hidden: yes
    type: string
    sql: ${TABLE}.claim_deductible ;;
  }

  dimension: claim_limit_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.claim_limit_dscr ;;
  }

  dimension: claim_limit_peroccur {
    hidden: yes
    type: string
    sql: ${TABLE}.claim_limit_peroccur ;;
  }

  dimension: claim_limit_perperson {
    hidden: yes
    type: string
    sql: ${TABLE}.claim_limit_perperson ;;
  }

  dimension: coveragelimit_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.coveragelimit_id ;;
  }

  dimension: deductible {
    hidden: yes
    type: string
    sql: ${TABLE}.deductible ;;
  }

  dimension: deductible_dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.deductible_dscr ;;
  }

  dimension: dscr {
    hidden: yes
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: is_no_coveragelimit {
    label: "No Limit (Y/N)"
    type: string
    sql: case when ${TABLE}.is_no_coveragelimit=1 then 'Yes' else 'No' end ;;
  }

  dimension: is_stacked {
    hidden: yes
    type: string
    sql: ${TABLE}.is_stacked ;;
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

  dimension: limit_dscr {
    label: "Limit"
    type: string
    sql: ${TABLE}.limit_dscr ;;
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

  dimension: peroccur_limit {
    label: "Per Occurrence Limit"
    type: string
    sql: case when ${TABLE}.peroccur_limit=-1 then 0 else ${TABLE}.peroccur_limit end ;;
  }

  dimension: perperson_limit {
    label: "Per Person Limit"
    type: string
    sql: case when ${TABLE}.perperson_limit=-1 then 0 else ${TABLE}.perperson_limit end ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

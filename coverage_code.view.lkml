view: coverage_code {
  sql_table_name: dbo.CoverageCode ;;

  dimension: basecoveragecode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.basecoveragecode_id ;;
  }

  dimension: cluecoverage_id {
    hidden: yes
    type: number
    sql: ${TABLE}.cluecoverage_id ;;
  }

  dimension: coveragecode {
    label: "Code"
    type: string
    sql: ${TABLE}.coveragecode ;;
  }

  dimension: coveragecode_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: coveragetype {
    label: "Liab, Phys, PIP"
    type: string
    sql: ${TABLE}.coveragetype ;;
  }

  dimension: dscr {
    label: "Description"
    type: string
    sql: ${TABLE}.dscr ;;
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

  dimension: report_to_clue {
    hidden: yes
    type: string
    sql: ${TABLE}.report_to_clue ;;
  }

  dimension: xmlnodename {
    hidden: yes
    type: string
    sql: ${TABLE}.xmlnodename ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [xmlnodename]
  }
}

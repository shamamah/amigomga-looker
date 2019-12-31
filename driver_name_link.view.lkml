view: driver_name_link {
  sql_table_name: dbo.DriverNameLink ;;

  dimension: compound_primary_key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_id}, '  ', ${policyimage_num}, ' ', ${driver_num}) ;;
  }

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  dimension: driver_num {
    hidden: yes
    type: number
    sql: ${TABLE}.driver_num ;;
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

  dimension: name_id {
    hidden: yes
    type: number
    sql: ${TABLE}.name_id ;;
  }

  dimension: packagepart_num {
    hidden: yes
    type: number
    sql: ${TABLE}.packagepart_num ;;
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

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

view: vehicle_type {
  sql_table_name: dbo.VehicleType ;;

  dimension: dscr {
    label: "Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: interfacecode {
    hidden: yes
    type: string
    sql: ${TABLE}.interfacecode ;;
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

  dimension: vehicletype_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.vehicletype_id ;;
  }

  dimension: vinrequired {
    hidden: yes
    type: string
    sql: ${TABLE}.vinrequired ;;
  }

  dimension: xmlinterface_code {
    hidden: yes
    type: string
    sql: ${TABLE}.xmlinterface_code ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}

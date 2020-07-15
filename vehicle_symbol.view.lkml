view: vehicle_symbol {
    sql_table_name: vehiclesymbol
        ;;

     measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: vehicle_num {
      type: number
      sql: ${TABLE}.vehicle_num ;;
    }

    dimension: vehiclesymbol_num {
      type: number
      sql: ${TABLE}.vehiclesymbol_num ;;
    }

    dimension: systemgenerated_symbol {
      type: string
      sql: ${TABLE}.systemgenerated_symbol ;;
    }

    dimension: useroverride_symbol {
      label: "Symbol"
      type: string
      sql: ${TABLE}.useroverride_symbol ;;
    }

    dimension: packagepart_num {
      type: number
      sql: ${TABLE}.packagepart_num ;;
    }

    dimension: detailstatuscode_id {
      type: number
      sql: ${TABLE}.detailstatuscode_id ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension_group: last_modified_date {
      type: time
      sql: ${TABLE}.last_modified_date ;;
    }

    dimension: vehiclesymbolcoveragetype_id {
      type: number
      sql: ${TABLE}.vehiclesymbolcoveragetype_id ;;
    }

    dimension: systemgenerated_symbol_vehicleinfolookuptype_id {
      type: number
      sql: ${TABLE}.systemgenerated_symbol_vehicleinfolookuptype_id ;;
    }

    set: detail {
      fields: [
        policy_id,
        policyimage_num,
        vehicle_num,
        vehiclesymbol_num,
        systemgenerated_symbol,
        useroverride_symbol,
        packagepart_num,
        detailstatuscode_id,
        pcadded_date_time,
        last_modified_date_time,
        vehiclesymbolcoveragetype_id,
        systemgenerated_symbol_vehicleinfolookuptype_id
      ]
    }
  }

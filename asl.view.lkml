view: asl {
  sql_table_name: asl;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: asl_id {
      type: number
      sql: ${TABLE}.asl_id ;;
    }

    dimension: asl {
      type: string
      sql: ${TABLE}.asl ;;
    }

    dimension: description {
      type: string
      sql: ${TABLE}.description ;;
    }

    dimension: status_id {
      type: number
      sql: ${TABLE}.status_id ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension_group: last_modified_date {
      type: time
      sql: ${TABLE}.last_modified_date ;;
    }

    set: detail {
      fields: [
        asl_id,
        asl,
        description,
        status_id,
        pcadded_date_time,
        last_modified_date_time
      ]
    }
  }

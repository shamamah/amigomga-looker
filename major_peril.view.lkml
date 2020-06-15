view: major_peril {
  sql_table_name: majorperil;;


    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: majorperil_id {
      type: number
      sql: ${TABLE}.majorperil_id ;;
    }

    dimension: majorperil {
      type: string
      sql: ${TABLE}.majorperil ;;
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
        majorperil_id,
        majorperil,
        description,
        status_id,
        pcadded_date_time,
        last_modified_date_time
      ]
    }
  }

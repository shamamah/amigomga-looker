view: policy_image_name_link {
  sql_table_name:  policyimagenamelink;;

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

    dimension: nameaddresssource_id {
      type: number
      sql: ${TABLE}.nameaddresssource_id ;;
    }

    dimension: name_id {
      type: number
      sql: ${TABLE}.name_id ;;
    }

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
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
        policy_id,
        policyimage_num,
        nameaddresssource_id,
        name_id,
        added_date,
        pcadded_date_time,
        last_modified_date_time
      ]
    }
  }

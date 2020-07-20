view: claim_feature_personnel {
    sql_table_name: claimfeaturepersonnel
        ;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: claimcontrol_id {
      type: number
      sql: ${TABLE}.claimcontrol_id ;;
    }

    dimension: claimant_num {
      type: number
      sql: ${TABLE}.claimant_num ;;
    }

    dimension: claimfeature_num {
      type: number
      sql: ${TABLE}.claimfeature_num ;;
    }

    dimension: claimpersonnel_id {
      type: number
      sql: ${TABLE}.claimpersonnel_id ;;
    }

    dimension: claimfeaturepersonnelkey {
      type: string
      primary_key: yes
      sql: CONCAT(${TABLE}.claimcontrol_id, ' ', ${TABLE}.claimant_num, ' ',  ${TABLE}.claimfeature_num, ' ', ${TABLE}.claimpersonnel_id) ;;
    }

    dimension: claimpersonneltype_id {
      type: number
      sql: ${TABLE}.claimpersonneltype_id ;;
    }

    dimension: claimadjustertype_id {
      type: number
      sql: ${TABLE}.claimadjustertype_id ;;
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

    dimension: prev_claimpersonnel_id {
      type: number
      sql: ${TABLE}.prev_claimpersonnel_id ;;
    }

    set: detail {
      fields: [
        claimcontrol_id,
        claimant_num,
        claimfeature_num,
        claimpersonnel_id,
        claimpersonneltype_id,
        claimadjustertype_id,
        added_date,
        pcadded_date_time,
        last_modified_date_time,
        prev_claimpersonnel_id
      ]
    }
  }

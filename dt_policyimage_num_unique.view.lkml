view: dt_policyimage_num_unique {
     derived_table: {
      sql: SELECT PIM.policy_id, PIM.renewal_ver, agency_id, PIM.Version_id, PIM.policyimage_num
              FROM PolicyImage PIM
        JOIN (Select policy_id, renewal_ver, Version_id, MAX(policyimage_num) AS policyimage_num
          FROM PolicyImage
          WHERE policy_id >=-1
              AND PolicyStatusCode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
            GROUP BY policy_id, renewal_ver, Version_id) PIM1
            ON PIM.policy_id = PIM1.POlicy_id
            AND PIM.renewal_ver = PIM1.Renewal_ver
            AND PIM.version_id = PIM1.Version_id
            AND PIM.policyimage_num = PIM1.policyimage_num
        WHERE PIM.policy_id >=-1
        --AND transtype_id in (2,4)
        AND PolicyStatusCode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
 ;;
    }

  dimension: unique_primary_key {
    type: number
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.policyimage_num);;
  }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.renewal_ver ;;
    }

    dimension: policyimage_num {
      label: "min_policyimage_num"
      type: number
      hidden: yes
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: agency_id {
      type:  number
      hidden: yes
      sql: ${TABLE}.agency_id;;
    }

    dimension: version_id {
      type:  number
      hidden: yes
      sql: ${TABLE}.Version_id;;
    }

  }

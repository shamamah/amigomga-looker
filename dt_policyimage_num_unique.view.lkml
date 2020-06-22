view: dt_policyimage_num_unique {
     derived_table: {
      sql: SELECT policy_id, renewal_ver, MAX(policyimage_num) AS policyimage_num
              FROM PolicyImage
        WHERE policy_id >=-1
        AND PolicyStatusCode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
              GROUP BY policy_id, renewal_ver
 ;;
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

  }
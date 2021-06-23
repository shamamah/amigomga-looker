view: dt_policy_new_renew {
  derived_table: {
    sql: Select pim.Policy_id, pim.policyimage_num,
        CASE WHEN pim.renewal_ver = 1 and x.policy_id is NULL
          THEN 'New Business'
          ELSE 'Renewal'
        END as NEW_RENEW
    FROM Policyimage pim
    LEFT JOIN Policy x
      ON x.policy_id = pim.policy_id
      AND x.rewrittenfrom_policy <> ''
    WHERE pim.policy_id > -1
    AND pim.policystatuscode_id not in (4, 5, 7, 8, 12, 13, 14)
     ;;
  }

  dimension: policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.Policy_id ;;
  }

  dimension: policyimage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: new_renew {
    label: "NEW/RENEW"
    type: string
    sql: ${TABLE}.NEW_RENEW ;;
  }

}

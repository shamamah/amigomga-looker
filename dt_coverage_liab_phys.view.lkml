view: dt_coverage_liab_phys {
  derived_table: {
      sql: SELECT Distinct policy, PIM.policy_id, PIM.policyimage_num, PIM.Renewal_ver, CASE WHEN coveragecode_id is NULL THEN 'Liab' ELSE 'Phys' END as [Liab_Phys]
              FROM PolicyImage PIM
              INNER JOIN dbo.[Version] V
                  ON PIM.version_id = V.version_id
              LEFT JOIN (Select Policy_id, PolicyImage_num, cc.coveragecode_id, SUM(premium_fullterm) as prem
                          FROM Coverage c
                          JOIN dbo.coveragecode cc
                              ON cc.coveragecode_id = c.coveragecode_id
                              AND cc.coveragetype = 'PhysicalDamage'
                          GROUP by Policy_id, PolicyImage_num, cc.coveragecode_id
                          HAVING SUM(premium_fullterm) <> 0
                                or SUM(manuallimitamount) > 0
                                or SUM(premium_written) <> 0
                                or SUM(premium_chg_written) <> 0) cc1
                  ON pim.policy_id = cc1.policy_id
                  AND pim.policyimage_num = cc1.policyimage_num
              WHERE  policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
              AND PIM.Policy_ID > -1 ;;

      sql_trigger_value: SELECT CAST(added_date as DATE) from policyimage ;;
    indexes: ["added_date"]

    }


    dimension: policy {
      type: string
      hidden: yes
      sql: ${TABLE}.policy ;;
    }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      hidden: yes
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: primary_key {
      hidden: yes
      type: string
      primary_key: yes
      sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.policyimage_num, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.policy);;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.Renewal_ver ;;
    }

    dimension: liab_phys {
      label: "Liab Only/Full Coverage"
      type: string
       sql: ${TABLE}.Liab_Phys ;;
    }


  }

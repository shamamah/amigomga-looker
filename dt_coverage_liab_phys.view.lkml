view: dt_coverage_liab_phys {
  derived_table: {
      sql: Select Distinct policy, PIM.policy_id, PIM.policyimage_num, PIM.Renewal_ver, CASE WHEN coveragecode_id is NULL THEN 'Liab' ELSE 'Phys' END as [Liab_Phys]  from PolicyImage PIM
        INNER JOIN dbo.[Version] V
          ON PIM.version_id = V.version_id
        LEFT JOIN (Select Policy_id, PolicyImage_num, cc.coveragecode_id, SUM(premium_diff_chg_written) as prem
          FROM Coverage c
          JOIN dbo.coveragecode cc
            on cc.coveragecode_id = c.coveragecode_id
            and cc.coveragetype = 'PhysicalDamage'
          group by Policy_id, PolicyImage_num, cc.coveragecode_id
          HAVING SUM(premium_diff_chg_written) > 0) cc1
           ON pim.policy_id = cc1.policy_id
           AND pim.policyimage_num = cc1.policyimage_num
      WHERE  policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
 ;;
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
      sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.policyimage_num);;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.Renewal_ver ;;
    }

    dimension: liab_phys {
      label: "Liab/Phys"
      type: string
       sql: ${TABLE}.Liab_Phys ;;
    }


  }

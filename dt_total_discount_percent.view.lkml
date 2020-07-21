view: dt_total_discount_percent {
  derived_table: {
      sql: SELECT pim.policy, pim.policy_id, pim.policyimage_num, pim.renewal_ver,
            SUM(cast(value as decimal (4,2))) as TotalDiscountPct
        FROM (Select policy_id, renewal_ver, Max(policyimage_num) as Policyimage_num from policyImage
            where policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
            --and policy_id = 320409
            group by policy_id, renewal_ver) z
        JOIN policyImage PIM
              ON pim.policy_id = z.policy_id
              AND z.Policyimage_num = pim.policyimage_num
              AND z.renewal_ver = pim.renewal_ver
        JOIN (Select Distinct policy_id, policyimage_num, dscr, value from CoverageAdditionalInfo) ca
              ON ca.policy_id = z.policy_id
              and ca.policyimage_num = z.policyimage_num
              and dscr like '%_percentage'
              and dscr not in ('Multi Car Discount_Percentage', 'Renewal Discount_Percentage')
              and cast(value as decimal (4,2)) < 1
        GROUP BY pim.policy, pim.policy_id, pim.policyimage_num, pim.renewal_ver;;
    }

    measure: count {
      type: count
      hidden: yes
    }

    dimension: policy {
      type: string
      sql: ${TABLE}.policy ;;
      hidden: yes
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.policy_id ;;
      hidden: yes
    }

    dimension: policyimage_num {
      type: number
      sql: ${TABLE}.policyimage_num ;;
      hidden: yes
    }


    dimension: renewal_ver {
      type: number
      sql: ${TABLE}.renewal_ver ;;
      hidden: yes
    }

    dimension: total_discount_pct{
      type: number
      value_format_name: percent_0
      sql: ${TABLE}.TotalDiscountPct ;;
    }

    set: detail {
      fields: [policy, policy_id, policyimage_num, renewal_ver]
    }
  }

view: dt_discount_indicator {
    derived_table: {
      sql: select pim.policy_id, pim.policyimage_num, DiscountType, CASE WHEN ca.DiscountInd is NULL THEN pim.Discountind
                                                                          ELSE ca.discountind end as discountind
                FROM
                (select pim.policy_id, pim.policyimage_num, DiscountType, dscr, discountind
                FROM policyImage PIM
                CROSS JOIN
                (Select distinct REPLACE(dscr, '_Amount', '') as discountType, dscr, 'No' as discountind
                    from CoverageAdditionalInfo
                    where dscr like '%amount%') CAI
                where
                    PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14) ) PIM
              LEFT OUTER JOIN
                      (Select distinct policy_id, policyimage_num, dscr,
                         CASE WHEN CAST(value as money) > 0 then 'Yes' else 'No' end as Discountind
                        from CoverageAdditionalInfo ca
                          where dscr like '%amount%'
                        ) ca
                ON ca.policy_id = PIM.policy_id
                and ca.policyimage_num = pim.policyimage_num
                and ca.dscr = pim.dscr
         ;;

      }
        measure: count {
          type: count
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

        dimension: discount_type {
          label: "Discount Type"
          type: string
          sql: ${TABLE}.DiscountType ;;
        }

        dimension: discountind {
          label: "Discount Applied"
          type: string
          sql: ${TABLE}.discountind ;;
        }


  }

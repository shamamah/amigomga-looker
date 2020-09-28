view: dt_discount_indicator {
    derived_table: {
      sql:Select pim.policy_id, pim.renewal_ver, DiscountType, CASE WHEN ca.DiscountInd is NULL THEN pim.Discountind
                                                                          ELSE ca.discountind end as discountind
                FROM
                (select pim.policy_id, pim.renewal_ver, DiscountType, dscr, discountind
                FROM policyImage PIM
                CROSS JOIN
                (Select distinct REPLACE(dscr, '_Amount', '') as discountType, dscr, 'No' as discountind
                    from CoverageAdditionalInfo
                    where dscr in ('Transfer Discount_Amount',
                  'Homeowners Discount_Amount',
                  'Punitive Damages Waiver_Amount',
                  'Multi Car Discount_Amount',
                  'Good Student Discount_Amount',
                  'Renewal Discount_Amount',
                  'Good Driver Discount_Amount',
                  'Defensive Driver Discount_Amount')
              ) CAI
                where
                    PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                    AND PIM.Version_id = 1
                    AND PIM.TransType_id in (2,4)) PIM
              LEFT OUTER JOIN
                      (Select distinct pim.policy_id, pim.renewal_ver, dscr,
                         CASE WHEN CAST(value as money) > 0 then 'Yes' else 'No' end as Discountind
                        from CoverageAdditionalInfo ca
              JOIN policyimage PIM
                  ON PIM.policy_id = ca.policy_id
                  AND PIM.policyimage_num = ca.policyimage_num
                  AND PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                  AND PIM.Version_id = 1
                  AND PIM.TransType_id in (2,4)
              WHERE dscr like '%amount%'
                        ) ca
                ON ca.policy_id = PIM.policy_id
                AND ca.renewal_ver = pim.renewal_ver
                AND ca.dscr = pim.dscr
         ;;
              sql_trigger_value: Select max(added_date) from CoverageAdditionalInfo ;;
              indexes: ["policy_id"]
      }
        measure: count {
          type: count
        }

        dimension: primary_key  {
          type: string
          primary_key: yes
          sql: CONCAT(${policy_id}, ' ', ${renewal_ver}, ' ', ${discount_type}) ;;
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

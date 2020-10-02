view: dt_proof_of_prior {
  derived_table: {
    sql:Select pim.Version_id, pim.policy_id, DiscountType, CASE WHEN ca.DiscountInd is NULL THEN pim.Discountind
                                                                          ELSE ca.discountind end as discountind
FROM    (select pim.policy_id, pim.version_id, DiscountType, dscr, discountind, SUM(ISNULL(Cast(cai.value as money),0)) as RenewalDiscountApplied
                FROM policyImage PIM
                CROSS JOIN
                (Select distinct REPLACE(dscr, '_Amount', '') as discountType, dscr, 'No' as discountind, value
                    from CoverageAdditionalInfo
                    where dscr = 'Transfer Discount_Amount'
        ) CAI
                where
                    PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                    AND PIM.Version_id = 1
                    --AND PIM.TransType_id = 2
        group by pim.policy_id, pim.version_id, DiscountType, dscr, discountind) PIM
LEFT OUTER JOIN
      (Select distinct pim.policy_id, pim.version_id, dscr,
                  CASE WHEN CAST(value as money) > 0 then 'Yes' else 'No' end as Discountind
                  FROM CoverageAdditionalInfo ca
              JOIN policyimage PIM
                  ON PIM.policy_id = ca.policy_id
                  AND PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                  AND PIM.Version_id = 1
                  --AND PIM.TransType_id = 2
              WHERE dscr = 'Transfer Discount_Amount') ca
                ON ca.policy_id = PIM.policy_id
                AND ca.dscr = pim.dscr

UNION

select Version_id, pim.policy_id, 'Transfer Discount', CASE WHEN c1.policy_id is NULL THEN 'Yes'
                                                 ELSE 'No' end as discountind
FROM PolicyImage pim
LEFT JOIN (Select policy_id, Policyimage_num, count(1) as CNT from Coverage
      where calc like '%_G)%' --- AMERICA
      AND coveragecode_id = 1
      group by policy_id, Policyimage_num) c1
    ON c1.policy_id = PIM.policy_id
    AND c1.policyimage_num = PIM.policyimage_num
WHERE PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                  AND PIM.Version_id = 2
          AND PIM.Transtype_id = 2


UNION

select Version_id, pim.policy_id, 'Transfer Discount', CASE WHEN c1.policy_id is NULL THEN 'No'
                                                 ELSE 'Yes' end as discountind
FROM PolicyImage pim
LEFT JOIN (Select policy_id, Policyimage_num, count(1) as CNT from Coverage
      where calc like '%* Transfer Discount 0.9%' --- USA
      AND coveragecode_id = 1
      group by policy_id, Policyimage_num) c1
    ON c1.policy_id = PIM.policy_id
    AND c1.policyimage_num = PIM.policyimage_num
WHERE PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                  AND PIM.Version_id = 3
          AND PIM.Transtype_id = 2
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
    hidden: yes
    sql: CONCAT(${policy_id}, ' ', ${discount_type}) ;;
  }
  dimension: policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_id ;;
  }
  dimension: version_id {
    type: number
    hidden: yes
    sql: ${TABLE}.version_id ;;
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

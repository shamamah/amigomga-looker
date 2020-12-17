view: dt_proof_of_prior {
  derived_table: {
    sql:select l.lob_id, pim.policy_id, pim.renewal_ver,
  CASE WHEN l.lob_id = 1 and RenewalDiscountApplied is NULL THEN 'No Prior'
    WHEN l.lob_id = 2 and c1.CNT is not NULL THEN 'No Prior'
    WHEN l.lob_id = 3 and c2.CNT is NULL THEN 'No Prior'
  ELSE 'Prior' END as Prior,
ISNULL(display_name, 'No Data') as PriorCompany
from policyimage pim
join (Select policy_id, renewal_ver, min(policyimage_num) minnum from policyimage
    where transtype_id in (2,4)
    group by policy_id, renewal_ver) pim1
    ON pim1.policy_id = pim.policy_id
    and pim1.minnum = pim.policyimage_num
join Version v ON v.version_id = pim.version_id
join LOB l ON l.lob_id = v.lob_id
Left JOIN (Select policy_id, SUM(ISNULL(Cast(cai.value as money),0)) as RenewalDiscountApplied
      from ProductionBackup.dbo.CoverageAdditionalInfo cai
      where cai.dscr = 'Transfer Discount_Amount'
      group by policy_id) a
      ON a.policy_id = PIM.policy_id
       and l.lob_id = 1
LEFT JOIN (Select policy_id, count(1) as CNT from Coverage
      where calc like '%_G)%' --- AMERICA
      group by policy_id) c1
    ON c1.policy_id = PIM.policy_id
    AND l.lob_id = 2
LEFT JOIN (Select policy_id, count(1) as CNT from Coverage
      where calc like '%* Transfer Discount 0.9%' --- AMERICA
      group by policy_id) c2
    ON c2.policy_id = PIM.policy_id
    AND l.lob_id = 3
left join (Select pc.policy_id, pc.policyimage_num, display_name
      from PriorCarrier pc
      left join  [dbo].[PriorCarrierNameLink] pcn
        ON pcn.policy_id = pc.policy_id
        AND pcn.policyimage_num = pc.policyimage_num
        and pcn.priorcarrier_num = pc.priorcarrier_num
      left Join name n
        ON n.name_id = pcn.name_id) pc
ON pim.policy_id = pc.policy_id
  and pim.policyimage_num = pc.policyimage_num
where  PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)

         ;;

  }

  dimension: primary_key  {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${policy_id}, ' ', ${renewal_ver}) ;;
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

  dimension: lob_id {
    type: number
    hidden: yes
    sql: ${TABLE}.lob_id ;;
  }
  dimension: prior {
    label: "Prior Status"
    type: string
    sql: ${TABLE}.prior ;;
  }

  dimension: prior_company {
    label: "Prior Company"
    type: string
    sql: ${TABLE}.priorcompany ;;
  }


}

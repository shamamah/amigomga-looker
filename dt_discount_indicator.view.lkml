view: dt_discount_indicator {
  derived_table: {
    sql: select pim.policy, pim.policy_id, pim.renewal_ver, Dscr as DiscountType, CASE WHEN Checkboxselected = 1 THEN 'Yes'
                                                                        ELSE 'No' end as discountind
          from modifier m
          join ModifierType mt ON mt.modifiertype_id = m.modifiertype_id
          join policyimage pim ON m.policy_id = pim.policy_id
            and pim.policyimage_num = m.policyimage_num
            and pim.policystatuscode_id = 1
          join (select policy_id, policyimage_num, modifiertype_id,
              unit_num, max(modifier_num) maxnum from modifier
              group by policy_id, policyimage_num, modifiertype_id,
              unit_num) x
              ON x.policy_id = m.policy_id
              AND x.policyimage_num = m.policyimage_num
              AND x.modifiertype_id = m.modifiertype_id
              AND x.unit_num = m.unit_num
              AND x.maxnum = m.modifier_num
    ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
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

  dimension: policy {
    link: {
      label: "Open in Diamond"
      url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Policy/{{ value }}"
      icon_url: "http://www.insuresoft.com/favicon.ico"
    }
    type: string
    hidden: yes
    sql: ${TABLE}.policy ;;
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

  set: detail {
  fields:  [policy,
    renewal_ver,
    discount_type
  ]
  }
}

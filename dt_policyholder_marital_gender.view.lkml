view: dt_policyholder_marital_gender {
  derived_table: {
    sql: select pim.policy_id, pim.policyimage_num, n.display_name, CASE WHEN ms.dscr <> 'Married' THEN 'Single' ELSE ms.dscr END as Marital_Status, s.dscr as Gender
      from policyimage pim
      join driver d ON d.policy_id = pim.policy_id
        and d.policyimage_num = pim.policyimage_num
        and relationshiptype_id = 8
      join drivernamelink pinl ON d.policy_id = pinl.policy_id
        and d.policyimage_num = pinl.policyimage_num
        and pinl.driver_num = d.driver_num
      left join name n ON n.name_id = pinl.name_id
      left join MaritalStatus ms ON ms.maritalstatus_id = n.maritalstatus_id
      left join Sex s ON s.sex_id = n.sex_id
      Where pim.policy_id > -1
      AND pim.policystatuscode_id not in (4, 5, 7, 8, 12, 13, 14)
      ;;
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

  dimension: display_name {
    type: string
    hidden: yes
    sql: ${TABLE}.display_name ;;
  }

  dimension: marital_status {
    label: "Marital Status"
    type: string
    sql: ${TABLE}.Marital_Status ;;
  }

  dimension: gender {
    label: "Gender"
    type: string
    sql: ${TABLE}.Gender ;;
  }

}

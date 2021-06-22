view: dt_driver_count {
  derived_table: {
    sql: Select pim.policy_id, pim.policyimage_num, count(1) as drivercount, Case when fdl.policy_id is NULL then 'USDL' ELSE 'FDL' END as FDL_USDL
            from policyimage pim
            join driver d ON d.policy_id = pim.policy_id
              and d.policyimage_num = pim.policyimage_num
              and d.detailstatuscode_id = 1
              and d.DriverExcludeType_id = 1 -- Rated Driver
      left join (select dnl.policy_id, dnl.policyimage_num, count(1) as cnt
            from DriverNameLink dnl
            Join Name n ON n.name_id = dnl.name_id
              AND dlstate_id not between 1 and 60 AND
                dlstate_id not in (285, 297)
            group by dnl.policy_id, dnl.policyimage_num) fdl
              ON fdl.policy_id = pim.policy_id
              AND fdl.policyimage_num = pim.policyimage_num
      Where pim.policy_id > -1
      AND pim.policystatuscode_id not in (4, 5, 7, 8, 12, 13, 14)
            group by pim.policy_id, pim.policyimage_num
      ,
      Case when fdl.policy_id is NULL then 'USDL' ELSE 'FDL' END;;
  }


  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql:  CONCAT(${TABLE}.policy_id, '_', ${TABLE}.policyimage_num);;
  }

  dimension: drivercount {
    label: "Driver Count"
    type: number
    sql: ${TABLE}.drivercount ;;
  }

  dimension: fdl_usdl {
    label: "FDL_USDL"
    type: string
    sql: ${TABLE}.fdl_usdl ;;
  }


}

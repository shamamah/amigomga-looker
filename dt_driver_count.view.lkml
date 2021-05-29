view: dt_driver_count {
  derived_table: {
    sql: Select pim.policy_id, pim.policyimage_num, count(1) as drivercount
            from policyimage pim
            join driver d ON d.policy_id = pim.policy_id
              and d.policyimage_num = pim.policyimage_num
              and d.detailstatuscode_id = 1
              and d.DriverExcludeType_id = 1 -- Rated Driver
            group by pim.policy_id, pim.policyimage_num
             ;;
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


}

view: dt_vehicle_count {
   derived_table: {
    sql: Select pim.policy_id, pim.policyimage_num, count(1) as vehiclecount
            from policyimage pim
            join vehicle v ON v.policy_id = pim.policy_id
              and v.policyimage_num = pim.policyimage_num
              and v.detailstatuscode_id = 1
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

  dimension: vehiclecount {
    label: "Vehicle Count"
    type: number
    sql: ${TABLE}.vehiclecount ;;
  }

  dimension: multi_car {
    label: "Multi Car"
    type: string
    sql: CASE WHEN ${TABLE}.vehiclecount > 1 THEN 'Yes' ELSE 'No' END ;;
  }

}

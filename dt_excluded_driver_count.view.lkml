view: dt_excluded_driver_count {
  derived_table: {
    sql: Select pim.policy_id, pim.policyimage_num, SUM(ISNULL(cnt, 0)) as drivercount
            from policyimage pim
            left join (Select policy_id, policyimage_num, count(1) as cnt from driver
              where detailstatuscode_id = 1
              and DriverExcludeType_id = 3 -- Excluded Driver
            GROUP BY policy_id, policyimage_num) d
        ON d.policy_id = pim.policy_id
              and d.policyimage_num = pim.policyimage_num
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
    label: "Excluded Driver Count"
    type: number
    sql: ${TABLE}.drivercount ;;
  }

  dimension: excluded_flag {
    label: "Excluded Driver Flag"
    type: string
    sql: CASE WHEN ${TABLE}.drivercount > 0 THEN 'Yes' ELSE 'No' END;;
  }
}

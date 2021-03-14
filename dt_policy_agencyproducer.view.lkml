view: dt_policy_agencyproducer {
  derived_table: {
    sql: select pim.policy_id as 'policy_id', pim.policyimage_num, n.display_name as 'agencyproducer_name', p.phone_num
        from dbo.policyimage pim
            inner join dbo.AgencyProducerNameLink apnl on apnl.agencyproducer_id = pim.agencyproducer_id
            inner join dbo.[Name] n on n.name_id = apnl.name_id
            inner join dbo.AgencyPhoneLink appl on appl.agency_id = pim.agency_id
           inner join dbo.[Phone] p on p.phone_id = appl.phone_id ;;
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

  dimension: agencyproducer_name {
    label: "Producer"
    type: string
    sql: ${TABLE}.agencyproducer_name ;;
  }

  dimension: agency_phone {
    label: "Phone"
    type: string
    sql: ${TABLE}.phone_num;;
  }
}

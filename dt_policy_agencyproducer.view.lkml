view: dt_policy_agencyproducer {
  derived_table: {
    sql: select pim.policy_id as 'policy_id', n.display_name as 'agencyproducer_name'
        from dbo.policyimage pim
            inner join dbo.AgencyProducerNameLink apnl on apnl.agencyproducer_id = pim.agencyproducer_id
            inner join dbo.[Name] n on n.name_id = apnl.name_id ;;
  }

  dimension: policy_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: agencyproducer_name {
    label: "Producer"
    type: string
    sql: ${TABLE}.agencyproducer_name ;;
  }
}

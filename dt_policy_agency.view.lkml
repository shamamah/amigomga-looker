view: dt_policy_agency {
  derived_table: {
    sql:

    select pim.policy_id as 'policy_id', pim.policyimage_num, n.display_name as 'agency_name', a.display_address as 'agency_address',
          ag.code as 'agency_code', left(a.zip, 5) as 'zip_code', p.phone_num
        from dbo.policyimage pim
            inner join dbo.AgencyNameLink anl on anl.agency_id = pim.agency_id
            inner join dbo.[Name] n on n.name_id = anl.name_id
            inner join dbo.AgencyAddressLink aal on aal.agency_id = pim.agency_id
                  AND aal.[nameaddresssource_id] = 8
            inner join dbo.[Address] a on a.address_id = aal.address_id
            inner join dbo.[Agency] ag on ag.agency_id = pim.agency_id
            inner join dbo.AgencyPhoneLink appl on appl.agency_id = pim.agency_id
                and appl.[nameaddresssource_id] = 8
            inner join dbo.[Phone] p on p.phone_id = appl.phone_id
                  and phonetype_id = 2;;
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

  dimension: pkey {
    type: string
    primary_key: yes
    sql: CONCAT(${policy_id}, ' ', ${policyimage_num}) ;;
  }

  dimension: agency_code {
    label: "Agency Code"
    type: string
    sql: ${TABLE}.agency_code ;;
  }

  dimension: agency_name {
    label: "Agency Name"
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: agency_address {
    label: "Agency Address"
    type: string
    sql: ${TABLE}.agency_address ;;
  }

  dimension: zip_code {
    label: "Zip Code"
    type: string
    sql: ${TABLE}.zip_code ;;
  }

  dimension: phone_num {
    label: "Phone"
    type: string
    sql: ${TABLE}.phone_num ;;
  }
}

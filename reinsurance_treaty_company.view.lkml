view: reinsurance_treaty_company {
  derived_table: {
    sql:  Select 1 as ID, 2 as treaty_id, 'General Reinsurance Corporation' as companyname, .50 as PercentLiable, '2020-05-01' as added_date
              UNION ALL
          Select 2 as ID, 2 as treaty_id, 'Clear Spring' as companyname, .10 as PercentLiable, '2020-05-01' as added_date
              UNION ALL
          Select 3 as ID, 2 as treaty_id, 'Thirdpoint Re' as companyname, .40 as PercentLiable, '2020-05-01' as added_date
              UNION ALL
          Select 4 as ID, 1 as treaty_id, 'Corinthian Re' as companyname, .40 as PercentLiable, '2020-05-01' as added_date
              UNION ALL
          Select 5 as ID, 1 as treaty_id, 'Clear Spring' as companyname, .30 as PercentLiable, '2020-05-01' as added_date
              UNION ALL
          Select 6 as ID, 1 as treaty_id, 'Topsail Re' as companyname, .20 as PercentLiable, '2020-05-01' as added_date
              UNION ALL
          Select 7 as ID, 1 as treaty_id, 'BroadReach Re' as companyname, .10 as PercentLiable, '2020-05-01' as added_date;;
  }


  dimension: id {
    label: "TreatyCompany id"
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: treaty_id {
    label: "Treaty ID"
    type: number
    sql: ${TABLE}.treaty_id;;
  }

  dimension: companyname {
    label: "Company Name"
    type: string
    sql: ${TABLE}.companyname;;
  }

  dimension: percent_liable {
    type: number
    hidden: yes
    sql: ${TABLE}.PercentLiable;;
  }


}

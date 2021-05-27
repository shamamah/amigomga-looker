view: reinsurance_treaty {
    derived_table: {
      sql: Select 1 as ID, 1 as treatynumber, 'Georgia 5/1/2019' as treatyname, 1 as treatylob, 1 as companystatelob_id, '2019-05-01 00:00:00' as EffectiveDate, '2020-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 2 as ID, 1 as treatynumber, 'Georgia 5/1/2019' as treatyname, 2 as treatylob, 2 as companystatelob_id, '2019-05-01 00:00:00' as EffectiveDate, '2020-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 3 as ID, 2 as treatynumber, 'Georgia 5/1/2020' as treatyname, 1 as treatylob, 1 as companystatelob_id, '2020-05-01 00:00:00' as EffectiveDate, '2021-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 4 as ID, 2 as treatynumber, 'Georgia 5/1/2020' as treatyname, 2 as treatylob, 2 as companystatelob_id, '2020-05-01 00:00:00' as EffectiveDate, '2021-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 5 as ID, 1 as treatynumber, 'Alabama 6/1/2020' as treatyname, 3 as treatylob, 3 as companystatelob_id, '2020-06-01 00:00:00' as EffectiveDate, '2021-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 1 as ID, 1 as treatynumber, 'Georgia 5/1/2021 CM' as treatyname, 1 as treatylob, 6 as companystatelob_id, '2021-05-01 00:00:00' as EffectiveDate, '2099-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 2 as ID, 1 as treatynumber, 'Georgia 5/1/2021 CM' as treatyname, 2 as treatylob, 7 as companystatelob_id, '2021-05-01 00:00:00' as EffectiveDate, '2099-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 3 as ID, 2 as treatynumber, 'Georgia 5/1/2021 CM' as treatyname, 1 as treatylob, 8 as companystatelob_id, '2021-05-01 00:00:00' as EffectiveDate, '2099-04-30 23:59:59' as ExpirationDate
               ;;
    }


    dimension: id {
      label: "Treaty id"
      type: number
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.id ;;
    }

    dimension: treatynumber {
      label: "Treaty Number"
      type: number
      sql: ${TABLE}.treatynumber ;;
    }

    dimension: treatyname {
      label: "Treaty Name"
      type: string
      sql: CONCAT(${TABLE}.treatyname, ' (', ${TABLE}.treatynumber, ')') ;;
    }

    dimension: treatylob {
      hidden: yes
      sql: ${TABLE}.treatylob ;;
    }

    dimension: company_state_lob_id {
      hidden: yes
      sql: ${TABLE}.companystatelob_id ;;
    }

    dimension: effective_date {
      type: date
      hidden: yes
      sql: ${TABLE}.EffectiveDate ;;
    }

    dimension: expiration_date {
      type: date
      hidden: yes
      sql: ${TABLE}.ExpirationDate ;;
    }

    }

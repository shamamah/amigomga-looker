view: reinsurance_treaty {
    derived_table: {
      sql: Select 1 as ID, 1 as treatynumber, 'Georgia 5/1/2019' as treatyname, '2019-05-01 00:00:00' as EffectiveDate, '2020-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 2 as ID, 2 as treatynumber, 'Georgia 5/1/2020' as treatyname, '2020-05-01 00:00:00' as EffectiveDate, '2099-04-30 23:59:59' as ExpirationDate
               ;;
    }


    dimension: id {
      label: "Treaty id"
      type: number
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
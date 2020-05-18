view: reinsurance_treaty {
    derived_table: {
      sql: Select 1 as Treatynumber, 'Georgia 5/1/2019' as TreatyName, '2019-05-01 00:00:00' as EffectiveDate, '2020-04-30 23:59:59' as ExpirationDate
              UNION ALL
              Select 2 as Treatynumber, 'Georgia 5/1/2020' as TreatyName, '2020-05-01 00:00:00' as EffectiveDate, '2099-04-30 23:59:59' as ExpirationDate
               ;;
    }


    dimension: treatynumber {
      label: "Treaty Number"
      type: number
      sql: ${TABLE}.Treatynumber ;;
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

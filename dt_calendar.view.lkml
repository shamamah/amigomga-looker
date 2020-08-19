view: dt_calendar {
   derived_table: {
      sql: select distinct added_date as dtDate from policyimage;;

    }

    dimension_group: dt_date {
      type: time
      sql: ${TABLE}.dtDate ;;
    }


  }

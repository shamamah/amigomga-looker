view: policy_pif_trans_lkup {
  derived_table: {
    sql:  Select 1 as id, 'Daily Trans' as transgroup, 1 as transgroup_id, 2 as transtype_id, 'New Business' as transtypedscr,
              'NB' as transtypesht, 1 as transtypesort
            UNION ALL
          Select 2, 'Daily Trans', 1, 4, 'Renewal', 'RN', 2
            UNION ALL
          Select 3, 'Daily Trans', 1, 3, 'Endorsement', 'ED', 3
            UNION ALL
          Select 4, 'Daily Trans', 1, 1, 'Cancellation', 'CN', 4
            UNION ALL
          Select 5, 'Daily Trans', 1, 5, 'Reinstatement', 'RI', 5
            UNION ALL
          Select 6, 'Daily Trans', 1, 0, 'Expired', 'EX', 6
            UNION ALL
          Select 7, 'Daily Trans', 1, 10, 'Deny Application', 'DA', 7
            UNION ALL
          Select 8, 'Daily Trans', 1, 7, 'Cancel-Rewrite', 'CR', 8 ;;
      }


      dimension: id {
        type: number
        hidden: yes
        sql: ${TABLE}.id ;;
      }

      dimension: transgroup {
        type: string
        hidden: yes
        sql: ${TABLE}.transgroup ;;
      }

      dimension: transgroup_id {
        type: number
        hidden: yes
        sql: ${TABLE}.transgroup_id ;;
      }

      dimension: transtype_id {
        type: number
        hidden: yes
        sql: ${TABLE}.transtype_id ;;
      }

      dimension: transtype_dscr {
        type: string
        sql: ${TABLE}.transtypedscr ;;
      }

      dimension: transtype_sht {
        type: string
        sql: ${TABLE}.transtypesht ;;
      }

      dimension: transtype_sort {
        type: number
        sql: ${TABLE}.transtypesort ;;
      }



  }

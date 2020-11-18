view: web_workflow_type {
  sql_table_name: [WebWorkflowType]
        ;;


    dimension: webworkflowtype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.webworkflowtype_id ;;
    }

    dimension: dscr {
      label: "Quote Type"
      type: string
      sql: ${TABLE}.dscr ;;
    }


  }

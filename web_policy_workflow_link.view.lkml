view: web_policy_workflow_link {
  sql_table_name: [WebPolicyWorkFlowLink];;


    dimension: webpolicyworkflowlink_id {
      type: number
      hidden: yes
      sql: ${TABLE}.webpolicyworkflowlink_id ;;
    }

    dimension: policy_number {
      label: "Quote Number"
      type: string
      sql: ${TABLE}.policy_number ;;
    }


    dimension: highest_visited {
      type: number
      sql: ${TABLE}.highest_visited ;;
    }

    dimension: statuscode_id {
      type: number
      sql: ${TABLE}.statuscode_id ;;
    }

    dimension: webworkflowtype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.webworkflowtype_id ;;
    }

  }

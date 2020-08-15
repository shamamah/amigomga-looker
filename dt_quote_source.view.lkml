view: dt_quote_source {
    derived_table: {
      sql: Select p.policy_id, webworkflowtype_id, CASE WHEN qs.dSCR is NULL and POT.dscr = 'Comparative Rating' then 'AA'
              WHEN qs.dSCR = 'N/A' and POT.dscr = 'Comparative Rating' then 'AA'
              WHEN POT.dscr = 'Diamond' THEN POT.Dscr ELSE qs.dSCR END as QuoteSource
        from policy p
        INNER JOIN PolicyOriginType POT WITH (NOLOCK)
              ON P.policyorigintype_id = POT.policyorigintype_id
            LEFT JOIN WebPolicyWorkFlowLink wp
              ON wp.policy_number = p.current_policy
              AND wp.webworkflowtype_id <> 0
            LEFT JOIN QuoteSource QS
              ON QS.QuoteSource_ID = p.quotesource_id
         ;;
    }


    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: webworkflowtype_id {
      type: number
      hidden: yes
      sql: ${TABLE}.webworkflowtype_id ;;
    }

    dimension: quote_source {
      label: "Quote Source"
      type: string
      sql: ${TABLE}.QuoteSource ;;
    }


  }

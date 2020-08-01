view: dt_claimcount_mgmt {
  derived_table: {
      sql: Select row_number() over (order by claim_number, claimfeature_num, Claimant_num, ProcessingDate) as id,
        ProcessingDate,
        Reported_date,
        Company_id,
        LOB_id,
        State_id,
        claim_number,
        policy_id,
        Policyimage_num,
        FeatDscr,
        claimfeature_num,
        Claimant_num,
        claimcontrol_id,
        ActionType,
        ClosedType,
        FirstClose,
        FirstOpen,
        Outstanding,
        policy,
        eff_date,
        paid
        from (Select
                CAST(cfa.Added_date as Datetime) ProcessingDate,
                cc.Reported_Date,
                Company_id,
                LOB_id,
                State_id,
                cc.claim_number,
                PolImg.policy_id,
                PolImg.Policyimage_num,
                ClmFeat.coverage_dscr + ' ' + ClmFeat.subcoverage_dscr AS FeatDscr,
                CFA.claimfeature_num,
                CFA.Claimant_num,
                cc.claimcontrol_id,
                CASE WHEN CFA.claimactivitycode_id = 2  THEN 'Closed'
                        ELSE 'Open' END as ActionType,
        CASE WHEN CFA.claimactivitycode_id = 2 THEN
            CASE WHEN z.claimcontrol_id is NULL THEN 'CWOP'
                ELSE 'CWP' END
        END as ClosedType,
        CASE WHEN CFA.claimactivitycode_id = 2 and cd.claimcontrol_id is not NULL THEN 1
            ELSE 0 END AS FirstClose,
        CASE WHEN CFA.claimactivitycode_id = 1 and od.claimcontrol_id is not NULL THEN 1
            ELSE 0 END AS FirstOpen,
        CASE WHEN CFA.claimactivitycode_id = 1 THEN 1 ELSE -1 END as Outstanding,
                policy,
                eff_date,
                CASE WHEN z.claimcontrol_id is not NULL THEN 1 ELSE 0 END as paid
                FROM ClaimFeature ClmFeat WITH(NOLOCK)
                INNER JOIN ClaimControl CC WITH(NOLOCK)
                  ON ClmFeat.claimcontrol_id = CC.claimcontrol_id
                INNER JOIN ClaimFeatureActivity CFA WITH(NOLOCK)
                  ON ClmFeat.claimcontrol_id = CFA.claimcontrol_id
                  AND ClmFeat.claimant_num = CFA.claimant_num
                  AND ClmFeat.claimfeature_num = CFA.claimfeature_num
                  AND claimactivitycode_id IN (1, 2)
                LEFT OUTER JOIN
                  (Select min(added_date) added_date, claimcontrol_id, claimant_num, claimfeature_num, sum(amount) amount
                    from Claimtransaction
                     WHERE amount > 0
           and claimtransactioncategory_id = 2
           group by claimcontrol_id, claimant_num, claimfeature_num) z
                      ON z.claimcontrol_id = CFA.claimcontrol_id
                      AND z.claimant_num = CFA.claimant_num
                      AND z.claimfeature_num = CFA.claimfeature_num
                      AND z.added_date <= cfa.Added_date
        LEFT OUTER JOIN dbo.ClaimFeatureActivity od
            ON cfa.claimcontrol_id = od.claimcontrol_id
            AND cfa.claimant_num = od.claimant_num
            AND cfa.claimfeature_num = od.claimfeature_num
            AND cfa.num = od.num
            AND od.claimactivitycode_id = 1
            AND cfa.num = (SELECT MIN(num)
              FROM dbo.ClaimFeatureActivity CCA
              WHERE CCA.claimcontrol_id = cfa.claimcontrol_id
                AND cfa.claimant_num = CCA.claimant_num
                AND cfa.claimfeature_num = CCA.claimfeature_num
                --AND CFA.added_date = CCA.added_date
                AND CCA.claimactivitycode_id = 1)
                AND cc.claimcontrol_id >= -1
                AND cc.policy_id >= -1
        LEFT OUTER JOIN dbo.ClaimFeatureActivity cd
            ON cfa.claimcontrol_id = cd.claimcontrol_id
            AND cfa.claimant_num = cd.claimant_num
            AND cfa.claimfeature_num = cd.claimfeature_num
            AND cfa.num = cd.num
            AND cd.claimactivitycode_id = 2
            AND cfa.num = (SELECT MIN(num)
              FROM dbo.ClaimFeatureActivity CCA
              WHERE CCA.claimcontrol_id = cfa.claimcontrol_id
                AND cfa.claimant_num = CCA.claimant_num
                AND cfa.claimfeature_num = CCA.claimfeature_num
                --AND CFA.added_date = CCA.added_date
                AND CCA.claimactivitycode_id = 2)
                AND cc.claimcontrol_id >= -1
                AND cc.policy_id >= -1
                INNER JOIN PolicyImage PolImg WITH(NOLOCK)
                  ON CC.policy_id = PolImg.policy_id
                    AND CC.policyimage_num = PolImg.policyimage_num
                INNER JOIN [Version] V WITH (NOLOCK)
                  ON V.version_id = PolImg.version_id

                UNION ALL

                Select
                CAST(CAST(ClmFeat.Reported_date as Date) as Datetime) ProcessingDate,
                cc.Reported_Date,
                Company_id,
                LOB_id,
                State_id,
                cc.claim_number,
                PolImg.policy_id,
                PolImg.Policyimage_num,
                ClmFeat.coverage_dscr + ' ' + ClmFeat.subcoverage_dscr AS FeatDscr,
                ClmFeat.claimfeature_num,
                ClmFeat.Claimant_num,
                CC.claimcontrol_id,
                'Reported' as ActionType,
                NULL,
                0,
                0,
                0 as Outstanding,
                policy,
                eff_date,
                0 as paid
                FROM ClaimFeature ClmFeat WITH(NOLOCK)
                INNER JOIN ClaimControl CC WITH(NOLOCK)
                  ON ClmFeat.claimcontrol_id = CC.claimcontrol_id
                INNER JOIN PolicyImage PolImg WITH(NOLOCK)
                  ON CC.policy_id = PolImg.policy_id
                    AND CC.policyimage_num = PolImg.policyimage_num
                INNER JOIN [Version] V WITH (NOLOCK)
                  ON V.version_id = PolImg.version_id) a;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: action_type {
      label: "Feature Status"
      type: string
      sql: ${TABLE}.ActionType;;
    }

    dimension: closed_type {
      label: "Closed Type"
      type: string
      sql: ${TABLE}.ClosedType;;
    }

    dimension: first_close {
      hidden: yes
      type: number
      sql: ${TABLE}.FirstClose;;
    }

    dimension: first_open {
      hidden: yes
      type: number
      sql: ${TABLE}.FirstOpen;;
    }

    measure: closed_count {
      label: "Closed Pay"
      type: count
      filters: [action_type: "Closed", closed_type: "CWP", first_close: "1"]
      drill_fields: [detail*]
    }

    measure: closed_count1 {
      label: "Closed w/o Pay"
      type: count
      filters: [action_type: "Closed", closed_type: "CWOP", first_close: "1"]
      drill_fields: [detail*]
    }

    measure: closed_count2 {
      label: "Reported"
      type: count
      filters: [action_type: "Reported"]
      drill_fields: [detail*]
    }

    measure: open_count {
      label: "Opened"
      type: count
      filters: [action_type: "Open", first_open: "1"]
      drill_fields: [detail*]
    }

    measure: closed_count3 {
      label: "Paid"
      type: sum
      sql: ${TABLE}.paid;;
      drill_fields: [detail*]
    }

    dimension: id {
      type: number
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.id ;;
    }

    dimension_group: processingdate {
      type: time
      timeframes: [date,week,month,quarter,year]
      sql: ${TABLE}.processingdate ;;
    }

    dimension: company_id {
      type: number
      hidden: yes
      sql: ${TABLE}.company_id ;;
    }

    dimension: lob_id {
      type: number
      hidden: yes
      sql: ${TABLE}.LOB_id ;;
    }

    dimension: state_id {
      type: number
      hidden: yes
      sql: ${TABLE}.State_id ;;
    }

    dimension: claim_number {
      link: {
        label: "Open in Diamond"
        url: "https://c76-prod.diamondasaservice.com/DiamondWeb/Employee/Claim/{{ value }}"
        icon_url: "http://www.insuresoft.com/favicon.ico"
      }
      type: string
      sql: ${TABLE}.claim_number ;;
    }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      hidden: yes
      sql: ${TABLE}.Policyimage_num ;;
    }

    dimension: feat_dscr {
      type: string
      sql: ${TABLE}.FeatDscr ;;
    }

    dimension: claimfeature_num {
      type: number
      hidden: yes
      sql: ${TABLE}.claimfeature_num ;;
    }

    dimension: claimant_num {
      type: number
      hidden: yes
      sql: ${TABLE}.Claimant_num ;;
    }

    dimension: claimcontrol_id {
      type: number
      hidden: yes
      sql: ${TABLE}.claimcontrol_id ;;
    }

    dimension: claim_age {
      type: number
      sql: DATEDIFF(day,${TABLE}.reported_date, GETDATE()) ;;
    }

    dimension: age_bucket {
      type: tier
      style: integer
      tiers: [31, 61, 91, 121, 151, 181]
      sql: ${claim_age} ;;
      drill_fields: [detail*]
    }

    measure: outstanding {
      type: sum
      sql: ${TABLE}.Outstanding ;;
      drill_fields: [detail*]

    }

    dimension: policy {
      type: string
      hidden: yes
      sql: ${TABLE}.policy ;;
    }

    dimension: eff_date {
      type: string
      hidden: yes
      sql: ${TABLE}.eff_date ;;
    }

    set: detail {
      fields: [
        policy,
        eff_date,
        claim_number,
        feat_dscr,
        claimant_num,
        claimfeature_num,
        claim_feature.coverage_dscr,
        v_claimtransaction_adjust2.indemnity_paid,
        v_claimtransaction_adjust2.indemnity_reserve
      ]
    }
  }
view: dt_claimcount {
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
        Outstanding,
        policy,
        eff_date
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
                CASE WHEN CFA.claimactivitycode_id = 2 AND z.claimcontrol_id is not NULL THEN 'Closed Pay'
                  WHEN CFA.claimactivitycode_id = 2 AND z.claimcontrol_id is NULL THEN 'Closed w/o Pay'
                   ELSE 'Open' END as ActionType,
                CASE WHEN CFA.claimactivitycode_id = 1 THEN 1 ELSE 0 END as Outstanding,
                policy,
                eff_date
                FROM ClaimFeature ClmFeat WITH(NOLOCK)
                INNER JOIN ClaimControl CC WITH(NOLOCK)
                  ON ClmFeat.claimcontrol_id = CC.claimcontrol_id
                INNER JOIN ClaimFeatureActivity CFA WITH(NOLOCK)
                  ON ClmFeat.claimcontrol_id = CFA.claimcontrol_id
                  AND ClmFeat.claimant_num = CFA.claimant_num
                  AND ClmFeat.claimfeature_num = CFA.claimfeature_num
                LEFT OUTER JOIN
                  (Select min(cx.added_date) added_date, cx.claimcontrol_id, claimant_num, claimfeature_num
                    from ClaimFinancials cx
                    join ClaimFeatureEod CFE
                      ON CFE.claimcontrol_id = cx.claimcontrol_id
                      AND CFE.claimfinancials_num = cx.claimfinancials_num
                    WHERE cx.indemnity_paid > 0
                    GROUP BY cx.claimcontrol_id, claimant_num, claimfeature_num) z
                      ON z.claimcontrol_id = CFA.claimcontrol_id
                      AND z.claimant_num = CFA.claimant_num
                      AND z.claimfeature_num = CFA.claimfeature_num
                      AND z.added_date <= cfa.Added_date
                INNER JOIN PolicyImage PolImg WITH(NOLOCK)
                  ON CC.policy_id = PolImg.policy_id
                    AND CC.policyimage_num = PolImg.policyimage_num
                INNER JOIN [Version] V WITH (NOLOCK)
                  ON V.version_id = PolImg.version_id
                WHERE     CFA.num = (
                          SELECT MAX(num)
                          FROM ClaimFeatureActivity WITH(NOLOCK)
                          WHERE claimcontrol_id = CFA.claimcontrol_id
                            AND claimant_num = CFA.claimant_num
                            AND claimfeature_num = CFA.claimfeature_num
                            AND claimactivitycode_id IN (1, 2))

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
                0 as Outstanding,
                policy,
                eff_date
                FROM ClaimFeature ClmFeat WITH(NOLOCK)
                INNER JOIN ClaimControl CC WITH(NOLOCK)
                  ON ClmFeat.claimcontrol_id = CC.claimcontrol_id
                INNER JOIN PolicyImage PolImg WITH(NOLOCK)
                  ON CC.policy_id = PolImg.policy_id
                    AND CC.policyimage_num = PolImg.policyimage_num
                INNER JOIN [Version] V WITH (NOLOCK)
                  ON V.version_id = PolImg.version_id) a
         ;;
    }

    measure: count {
      type: count_distinct
      sql: ${claimcontrol_id} ;;
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

    dimension: action_type {
      label: "Claim Status"
      type: string
      sql: ${TABLE}.ActionType;;
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
        action_type
        ]
    }
  }

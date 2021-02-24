view: test_dt_claimcount_mgmt {
  derived_table: {
    sql: select
            ID,
            CASE WHEN cc.StatusDate < '2019-07-01' THEN '2019-07-01' ELSE cc.StatusDate END as ProcessingDate,
            CASE WHEN rpd.statusdate < '2019-07-01' THEN '2019-07-01' ELSE rpd.statusdate END as Reported_Date,
            CompanyID as Company_id,
            LOBID as LOB_id,
            StateID as State_id,
            ClaimNumber as claim_number,
            policy_id,
            Policyimage_num,
            Coverage as FeatDscr,
            cc.claimfeature_num,
            cc.Claimant_num,
            cc.claimcontrol_id,
            FeatureStatus as ActionType,
            PaidStatus as ClosedType,
            CASE WHEN cl1.ClaimControl_ID is not null THEN 1 ELSE 0 end as FirstClose,
            CASE WHEN cl2.ClaimControl_ID is not null THEN 1 ELSE 0 end as LastClose,
            CASE WHEN rpd.ClaimControl_ID is not NULL then 1 else 0 end as firstopen,
            NULL as monthlyClose,
            DATEDIFF(d, rpd.statusdate, cc.statusdate) as ActivityAge,
            Outstanding,
            eff_date,
            CASE WHEN LossDate < '2019-07-01' THEN '2019-07-01' ELSE LossDate END as Lossdate,
            COALESCE(ct.Amount, cf.indemnity_paid, 0) as paid
      FROM customer_reports.dbo.claimcounts cc
      -- Reported Date
      LEFT JOIN (select claimfeature_num, Claimant_num, claimcontrol_id, statusdate
              FROM customer_reports.dbo.ClaimCounts where FeatureStatus = 'Open') rpd
          ON cc.claimfeature_num = rpd.claimfeature_num
            and cc.Claimant_num = rpd.Claimant_num
            and cc.claimcontrol_id = rpd.claimcontrol_id
      -- First Closed
      LEFT JOIN (select claimfeature_num, Claimant_num, claimcontrol_id, min(statusdate) mindate
                from customer_reports.dbo.claimcounts where FeatureStatus = 'Closed'
                group by claimfeature_num, Claimant_num, claimcontrol_id) cl1
              ON cc.claimfeature_num = cl1.claimfeature_num
              and cc.Claimant_num = cl1.Claimant_num
              and cc.claimcontrol_id = cl1.claimcontrol_id
              and cc.StatusDate = cl1.mindate
      -- Last Close
      LEFT JOIN (select claimfeature_num, Claimant_num, claimcontrol_id, max(statusdate) maxdate
                from customer_reports.dbo.claimcounts where FeatureStatus = 'Closed'
                group by claimfeature_num, Claimant_num, claimcontrol_id) cl2
              ON cc.claimfeature_num = cl2.claimfeature_num
              and cc.Claimant_num = cl2.Claimant_num
              and cc.claimcontrol_id = cl2.claimcontrol_id
              and cc.StatusDate = cl2.maxdate
      -- Payment Data for CWP's
      LEFT JOIN ClaimfeatureEOD eod
        ON cc.ClaimControl_ID = eod.claimcontrol_id
        AND cc.Claimant_num = eod.claimant_num
        and cc.ClaimFeature_num = eod.claimfeature_num
        and YEAR(cc.StatusDate)*100+Month(cc.StatusDate) = eod.year_month_key
        AND eod.claimeoplevel_id = 1
      LEFT JOIN ClaimFinancials cf
        ON cf.claimcontrol_id = eod.claimcontrol_id
        AND cf.claimfinancials_num = eod.claimfinancials_num
      LEFT JOIN (Select YEAR(check_date)*100+MONTH(Check_date) as Trans_Month,
          claimcontrol_id, claimant_num, claimfeature_num, SUM(Amount) as Amount
            from claimtransaction
            where claimtransactioncategory_id = 2
            and check_number <> ''
            and claimtransactionstatus_id = 1
            group by YEAR(check_date)*100+MONTH(Check_date), claimcontrol_id,
              claimant_num, claimfeature_num) ct
              ON cc.claimcontrol_id = ct.claimcontrol_id
              AND cc.claimant_num = ct.claimant_num
              AND cc.claimfeature_num = ct.claimfeature_num
              AND Year(cc.StatusDate)*100+Month(cc.statusdate) = ct.Trans_Month;;
  }

  # measure: count {
  #   type: count
  #   drill_fields: [detail*]
  # }

  dimension: action_type {
    label: "Feature Status"
    # hidden:  yes
    type: string
    sql: ${TABLE}.ActionType;;
  }

  dimension: closed_type {
    label: "Closed Type"
    hidden: yes
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

  dimension: monthly_close {
    hidden: yes
    type: number
    sql: ${TABLE}.monthlyClose;;
  }

  dimension: last_close {
    hidden: yes
    type: number
    sql: ${TABLE}.lastClose;;
  }

  measure: reopen_count {
    label: "Reopen"
    type: count
    filters: [action_type: "reopen"]
    drill_fields: [detail*]
  }

  measure: all_closed {
    label: "All Closed"
    type: count
    filters: [action_type: "closed"]
    drill_fields: [detail*]
  }


  measure: closed_count {
    label: "Closed w/Pay"
    type: count
    filters: [action_type: "Closed", closed_type: "CWP"]
    drill_fields: [detail*]
  }

  measure: closed_count1 {
    label: "Closed w/o Pay"
    type: count
    filters: [action_type: "Closed", closed_type: "CWOP"]
    drill_fields: [detail*]
  }

  measure: last_close_pay {
    label: "Last Closed w/Pay"
    type: count
    filters: [action_type: "Closed", closed_type: "CWP", last_close: "1"]
    drill_fields: [detail*]
  }

  measure: last_close_wopay {
    label: "Last Closed w/o Pay"
    type: count
    filters: [action_type: "Closed", closed_type: "CWOP", last_close: "1"]
    drill_fields: [detail*]
  }

  measure: closed_count2 {
    label: "Reported"
    type: count
    filters: [action_type: "Open"]
    drill_fields: [detail*]
  }

  # measure: open_count {
  #   label: "First Open"
  #   type: count
  #   filters: [action_type: "Open", first_open: "1"]
  #   drill_fields: [detail*]
  # }

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

  dimension: yr_mnth {
    type: number
    sql: YEAR(${processingdate_date}) * 100 + MONTH(${processingdate_date});;
  }

  dimension_group: processingdate {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.processingdate ;;
  }

  dimension_group: lossdate {
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.lossdate ;;
  }

  dimension_group: reporteddate {
    label: "Reported Date"
    type: time
    timeframes: [date,week,month,quarter,year]
    sql: ${TABLE}.reported_date ;;
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

  dimension: activity_age {
    type: number
    sql: ${TABLE}.ActivityAge;;
  }

  dimension: closed_bucket {
    type: tier
    style: integer
    tiers: [31, 61, 91, 121, 151, 181]
    sql: ${activity_age} ;;
    drill_fields: [detail*]
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
    # drill_fields: [detail*]

  }

  dimension: eff_date {
    type: string
    hidden: yes
    sql: ${TABLE}.eff_date ;;
  }

  set: detail {
    fields: [
      reporteddate_date,
      lossdate_date,
      claim_number,
      claimant_num,
      action_type,
      processingdate_date,
      feat_dscr,
      closed_count3,
      v_claimtransaction_adjust2.indemnity_reserve
    ]
  }
}

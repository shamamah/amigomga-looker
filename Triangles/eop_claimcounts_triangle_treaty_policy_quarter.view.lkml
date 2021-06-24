view: eop_claimcounts_triangle_treaty_policy_quarter {
  derived_table: {
    sql: SELECT z.PeriodTrans as treaty_quarter,
            CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) / 3  < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date)  / 3  END as policy_quarter,
            DATEDIFF(m, t.eff_date, ProcessingDate)  / 3 -
            CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) / 3  < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date) / 3   END as lag_quarter,
            DATEDIFF(m, '2019-05-01', ProcessingDate) / 3  as trans_quarter,
          z.company_id,
          z.state_id,
          z.lob_id,
          CASE WHEN z.lob_id = 1 AND coveragecode_id = 9 THEN 8 ELSE coveragecode_id END as coveragecode_id,
          CASE WHEN z.lob_id = 1 AND FeatDscr = 'UM PD' THEN 'UM/UIM BI' ELSE FeatDscr END as caption,
      --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
          CASE WHEN z.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
          Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
        count(1) as Reported,
        Sum(CASE WHEN ActionType = 'Closed' THEN 1 ELSE 0 END) as Closed,
        Sum(CASE WHEN ClosedType = 'CWOP' and ActionType = 'Closed' THEN 1 ELSE 0 END) as ClosedNoPay,
        Sum(CASE WHEN ClosedType = 'CWP' and ActionType = 'Closed' THEN 1 ELSE 0 END) as ClosedPay,
        Sum(CASE WHEN ActionType = 'Open' THEN 1 ELSE 0 END) as Outstanding,
    Sum(CASE WHEN ActionType = 'Reopen' THEN 1 ELSE 0 END) as Reopen,
          z.Renewal_ver as RenewalVersion

       From (Select row_number() over (order by claim_number, claimfeature_num, Claimant_num, ProcessingDate) as id,
        PeriodTrans,
              ProcessingDate,
              Reported_date,
        Loss_date,
              Company_id,
              LOB_id,
              State_id,
              claim_number,
              policy_id,
              Policyimage_num,
              FeatDscr,
          coveragecode_id,
              claimfeature_num,
              Claimant_num,
              claimcontrol_id,
              ActionType,
              ClosedType,
              FirstClose,
              FirstOpen,
              monthlyClose,
              ActivityAge,
              --Outstanding,
              policy,
        renewal_ver,
              eff_date,
              paid
              from (Select
            PeriodTrans,
            CAST(LEFT(PeriodTrans, 4) as varchar(4)) + '-' + CAST(RIGHT(PeriodTrans, 2) as varchar(2)) + '-01' as ProcessingDate,
            NULL AS Reported_Date,
            LossDate as Loss_date,
            Companyid as company_id,
            LOBid as Lob_id,
            Stateid as State_id,
            claimnumber as Claim_Number,
            policy_id,
            Policyimage_num,
            Coverage as FeatDscr, --+ ' ' + ClmFeat.subcoverage_dscr
            coverage_id as coveragecode_id,
            claimfeature_num,
            Claimant_num,
            claimcontrol_id,
            FeatureStatus as ActionType,
            PaidStatus as ClosedType,
            0 AS FirstClose,
            0 AS FirstOpen,
            0 AS monthlyClose,
            0 as ActivityAge,
--            Outstanding as Outstanding,
            '' as policy,
            renewal_ver,
            eff_date,
            0 as paid
    FROM Customer_Reports.dbo.ClaimCountsRolling
    WHERE PeriodTrans <> YEAR(GETDATE())*100+MONTH(GETDATE())) a) z
  JOIN policyimage PIM
      ON PIM.policy_id = z.policy_id
      AND pim.policyimage_num = z.policyimage_num
  Join version v ON v.version_id = pim.version_id
    JOIN customer_reports.dbo.treaty t ON
        t.lob_id = z.lob_id
        AND v.companystatelob_id = t.CompanyStateLob_ID
        AND z.eff_date between t.eff_date and t.exp_date
    JOIN
      (SELECT lob_id, periodtrans from customer_reports.dbo.TreatyQuarter
          UNION ALL
        -- check for mid-period
      SELECT lob_id, maxperiod from customer_reports.dbo.TreatyQuarter tq
        JOIN (SELECT lobid, max(periodtrans) maxperiod from Customer_Reports.dbo.ClaimCountsRolling
            GROUP by lobid) m ON m.maxperiod between year(qstartdate)*100+month(qstartdate) and year(qstartdate)*100+month(qstartdate)+1
            AND m.lobid = tq.lob_id) tq
        ON tq.lob_id = z.lob_id
        AND tq.periodtrans = z.periodtrans
    GROUP BY
      z.PeriodTrans ,
      CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) / 3  < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date)  / 3  END ,
      DATEDIFF(m, t.eff_date, ProcessingDate)  / 3 -
      CASE WHEN DATEDIFF(m, t.eff_date, z.eff_date) / 3  < 0 THEN 0 ELSE DATEDIFF(m, t.eff_date, z.eff_date) / 3   END ,
      DATEDIFF(m, '2019-05-01', ProcessingDate) / 3  ,
      z.company_id,
          z.state_id,
          z.lob_id,
          CASE WHEN z.lob_id = 1 AND coveragecode_id = 9 THEN 8 ELSE coveragecode_id END,
          CASE WHEN z.lob_id = 1 AND FeatDscr = 'UM PD' THEN 'UM/UIM BI' ELSE FeatDscr END ,
      --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
          CASE WHEN z.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
      z.Renewal_ver,
      Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
       ;;
  }

  dimension: unique_key  {
    type: string
    hidden: yes
    primary_key: yes
    sql: CONCAT(${policy_quarter},'_',${lag_quarter},'_',${treaty_quarter},'_',${trans_quarter},'_',${coveragecode_id},'_',${new_ren},'_',${lob_id},'_',${treaty},'_',${renewal_version}) ;;
  }

  dimension: trans_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.trans_quarter ;;
  }

  dimension: lag_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.lag_quarter ;;
  }

  dimension: policy_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_quarter ;;
  }

  dimension: treaty_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.treaty_quarter ;;
  }

  dimension: company_id {
    type: number
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: state_id {
    type: number
    hidden: yes
    sql: ${TABLE}.state_id ;;
  }

  dimension: lob_id {
    type: number
    hidden: yes
    sql: ${TABLE}.lob_id ;;
  }

  dimension: coveragecode_id {
    type: number
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: caption {
    type: string
    hidden: yes
    sql: ${TABLE}.caption ;;
  }

  dimension: new_ren {
    type: string
    hidden: yes
    sql: ${TABLE}.NewRen ;;
  }

  dimension: renewal_version {
    type: string
    hidden: yes
    sql: ${TABLE}.RenewalVersion ;;
  }
  dimension: treaty {
    type: string
    hidden: yes
    sql: ${TABLE}.treaty ;;
  }

  measure: reported {
    label: "Reported_Dev"
    type: sum
    sql: ${TABLE}.Reported ;;
    drill_fields: [detail*]
  }

  measure: closed {
    label: "Closed_Dev"
    type: sum
    sql: ${TABLE}.Closed ;;
    drill_fields: [detail*]
  }

  measure: closed_no_pay {
    label: "Closed_CWOP_Dev"
    type: sum
    sql: ${TABLE}.ClosedNoPay ;;
    drill_fields: [detail*]
  }

  measure: closed_pay {
    label: "Closed_CWP_Dev"
    type: sum
    sql: ${TABLE}.ClosedPay ;;
    drill_fields: [detail*]
  }

  measure: outstanding {
    label: "Outstanding_Dev"
    type: sum
    sql: ${TABLE}.Outstanding ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      treaty_quarter,
      lag_quarter,
      policy_quarter,
      company_id,
      state_id,
      lob_id,
      coveragecode_id,
      caption,
      new_ren,
      reported,
      closed,
      closed_no_pay,
      closed_pay,
      outstanding
    ]
  }


}

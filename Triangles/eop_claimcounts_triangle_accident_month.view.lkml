view: eop_claimcounts_triangle_accident_month {
  derived_table: {
      sql: Select
        YEAR(ProcessingDate)*100+MONTH(ProcessingDate) as transmonth,
          CAST('M' + RIGHT('00' + CAST(DATEDIFF(m, CASE WHEN Lossdate < '2019-05-01' THEN '2019-05-01' ELSE Lossdate END, ProcessingDate) + 1 as varchar(3)), 3) as varchar(4)) as lagmonth,
          CASE WHEN YEAR(Lossdate)*100+MONTH(Lossdate) < 201905 THEN 201905 ELSE YEAR(Lossdate)*100+MONTH(Lossdate) END As accidentmonth,
          company_id,
          state_id,
          lob_id,
          CASE WHEN lob_id = 1 AND coveragecode_id = 9 THEN 8 ELSE coveragecode_id END as coveragecode_id,
          CASE WHEN lob_id = 1 AND FeatDscr = 'UM PD' THEN 'UM/UIM BI' ELSE FeatDscr END as caption,
      --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
          CASE WHEN renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
      --          Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
      Sum(CASE WHEN ActionType = 'Open' THEN 1 ELSE 0 END) as Reported,
            Sum(CASE WHEN ActionType = 'Reopen' THEN 1 ELSE 0 END) as Reopen,
            Sum(CASE WHEN ActionType = 'Closed' THEN 1 ELSE 0 END) as Closed,
            Sum(CASE WHEN ClosedType = 'CWOP' and ActionType = 'Closed' THEN 1 ELSE 0 END) as ClosedNoPay,
            Sum(CASE WHEN ClosedType = 'CWP' and ActionType = 'Closed' THEN 1 ELSE 0 END) as ClosedPay,
            SUM(Outstanding) as Outstanding


       From (select
            ID,
      PeriodTrans as Treaty_Month,
            CASE WHEN cc.StatusDate < '2019-07-01' THEN '2019-07-01' ELSE cc.StatusDate END as ProcessingDate,
            CASE WHEN rpd.statusdate < '2019-07-01' THEN '2019-07-01' ELSE rpd.statusdate END as Reported_Date,
            CompanyID as Company_id,
            LOBID as LOB_id,
            StateID as State_id,
            ClaimNumber as claim_number,
            policy_id,
            Policyimage_num,
            Coverage as FeatDscr,
      Coverage_ID as coveragecode_id,
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
      renewal_ver,
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
              AND Year(cc.StatusDate)*100+Month(cc.statusdate) = ct.Trans_Month) z


      GROUP BY
        YEAR(ProcessingDate)*100+MONTH(ProcessingDate),
    CAST('M' + RIGHT('00' + CAST(DATEDIFF(m, CASE WHEN Lossdate < '2019-05-01' THEN '2019-05-01' ELSE Lossdate END, ProcessingDate) + 1 as varchar(3)), 3) as varchar(4)),
          CASE WHEN YEAR(Lossdate)*100+MONTH(Lossdate) < 201905 THEN 201905 ELSE YEAR(Lossdate)*100+MONTH(Lossdate) END,
      company_id,
          state_id,
          lob_id,
          CASE WHEN lob_id = 1 AND coveragecode_id = 9 THEN 8 ELSE coveragecode_id END,
          CASE WHEN lob_id = 1 AND FeatDscr = 'UM PD' THEN 'UM/UIM BI' ELSE FeatDscr END ,
      --          CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
          CASE WHEN renewal_ver = 1 THEN 'New' ELSE 'Renew' END
       ;;
    }

    dimension: unique_key  {
      type: string
      hidden: yes
      primary_key: yes
      sql: CONCAT(${accidentmonth},'_',${transmonth},'_',${lagmonth},'_',${coveragecode_id},'_',${new_ren},'_',${lob_id}) ;;
    }

    dimension: transmonth {
      type: number
      hidden: yes
      sql: ${TABLE}.transmonth ;;
    }

    dimension: lagmonth {
      type: string
      hidden: yes
      sql: ${TABLE}.lagmonth ;;
    }

    dimension: accidentmonth {
      type: number
      hidden: yes
      sql: ${TABLE}.accidentmonth ;;
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

    measure: reported {
      type: sum
      sql: ${TABLE}.Reported ;;
      drill_fields: [detail*]
    }

    measure: closed {
      type: sum
      sql: ${TABLE}.Closed ;;
      drill_fields: [detail*]
    }

    measure: closed_no_pay {
      type: sum
      sql: ${TABLE}.ClosedNoPay ;;
      drill_fields: [detail*]
    }

    measure: closed_pay {
      type: sum
      sql: ${TABLE}.ClosedPay ;;
      drill_fields: [detail*]
    }

    measure: outstanding {
      type: sum
      sql: ${TABLE}.outstanding ;;
      drill_fields: [detail*]
    }

    measure: reopened {
      type: sum
      sql: ${TABLE}.reopen ;;
      drill_fields: [detail*]
    }

    set: detail {
      fields: [
        transmonth,
        lagmonth,
        accidentmonth,
        company_id,
        state_id,
        lob_id,
        coveragecode_id,
        caption,
        new_ren,
        reported,
        closed,
        closed_no_pay,
        closed_pay
      ]
    }


}

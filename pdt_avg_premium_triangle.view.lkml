view: pdt_avg_premium_triangle {
  derived_table: {
    sql: SELECT
        EOP.TransMonth,
        EOP.policy,
        EffMonth,
        MonthlyLag,
        EOP.renewal_ver,
        new_renew,
        liabonly_Full,
        Coverage,
        CN.commercial_name1,
        S.[state],
        LOB.lobname,
        ASL.[description] AS ASL,
        MP.[description] AS MP,
        SUM(EOP.premium_earned_mtd) AS premium_earned_mtd,
        RunningTotal as ITDPremiumTotal,
        MP.majorperil,
        EOP.Eff_Date as policy_effdate,
    Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty
      FROM (SELECT
          EOP.[year] * 100 + EOP.[month] as TransMonth,
          EOP.policy,
          YEAR(EOP.Eff_Date) * 100 + MONTH(EOP.Eff_Date) as EffMonth,
          'M' + RIGHT('00' + CAST(DATEDIFF(m, EOP.Eff_Date, Cast(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(2)), 2) as MonthlyLag,
          EOP.renewal_ver,
          CASE WHEN EOP.renewal_ver > 1 THEN 'Renew' ELSE 'New' END as New_Renew,
          CASE WHEN cc1.policy_id is NULL THEN 'LiabOnly' Else 'FullCov' END as LiabOnly_Full,
          cc.Coveragecode as Coverage,
          EOP.Eff_Date,
          EOP.majorperil_id,
          EOP.asl_id,
          V.company_id,
          V.state_id,
          V.lob_id,
          SUM(EOP.premium_earned_mtd) AS premium_earned_mtd,
          RunningTotal
        FROM EOPMonthlyPremiums EOP WITH(NOLOCK)
        JOIN PolicyImage PIM ON Pim.Policy_id = eop.policy_id
          and EOP.policyimage_num= PIM.policyimage_num
          and transtype_id in (2,3,4)
        INNER JOIN dbo.[Version] V WITH(NOLOCK)
          ON EOP.version_id = V.version_id
        LEFT JOIN (Select Policy_id, PolicyImage_num, cc.coveragecode_id, SUM(premium_diff_chg_written) as prem
        FROM Coverage c
                JOIN dbo.coveragecode cc
                on cc.coveragecode_id = c.coveragecode_id
                  and cc.coveragetype = 'PhysicalDamage'
              group by Policy_id, PolicyImage_num, cc.coveragecode_id
              HAVING SUM(premium_diff_chg_written) > 0) cc1
                    ON eop.policy_id = cc1.policy_id
                    AND eop.policyimage_num = cc1.policyimage_num
                    AND EOP.coveragecode_id = cc1.coveragecode_id
        LEFT JOIN dbo.coveragecode cc
          ON cc.coveragecode_id = eop.coveragecode_id
        JOIN (SELECT distinct EOP.[year] * 100 + EOP.[month] as TransMonth,
          EOP.policy_id,
          YEAR(EOP.Eff_Date) * 100 + MONTH(EOP.Eff_Date) as EffMonth,
          EOP.Renewal_ver,
          CoverageCode,
              SUM(premium_written_mtd) OVER ( PARTITION BY EOP.policy_id, EOP.Renewal_ver, coveragecode
                              ORDER BY EOP.policy_id,  EOP.Renewal_ver, coveragecode, EOP.[year] * 100 + EOP.[month] ) AS RunningTotal
          FROM dbo.EOPMonthlyPremiums EOP
          JOIN dbo.PolicyImage PIM ON Pim.Policy_id = eop.policy_id
            and EOP.policyimage_num= PIM.policyimage_num
            and transtype_id in (2,3,4)
          JOIN dbo.coveragecode cc
            ON cc.coveragecode_id = eop.coveragecode_id) x
          ON x.policy_id = eop.policy_id
            AND x.Transmonth = EOP.[year] * 100 + EOP.[month]
            AND x.renewal_ver = eop.renewal_ver
            AND x.coveragecode= cc.coveragecode
        --WHERE EOP.[year] * 100 + EOP.[month] between YEAR(EOP.Eff_Date) * 100 + MONTH(EOP.Eff_Date) and  YEAR(EOP.Exp_Date) * 100 + MONTH(EOP.Exp_Date)
        GROUP BY
          EOP.[year] * 100 + EOP.[month],
          EOP.policy,
          YEAR(EOP.Eff_Date) * 100 + MONTH(EOP.Eff_Date),
          'M' + RIGHT('00' + CAST(DATEDIFF(m, EOP.Eff_Date, Cast(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(2)), 2),
          EOP.renewal_ver,
          CASE WHEN EOP.renewal_ver > 1 THEN 'Renew' ELSE 'New' END,
          CASE WHEN cc1.policy_id is NULL THEN 'LiabOnly' Else 'FullCov' END,
          cc.Coveragecode,
          EOP.Eff_Date,
          EOP.majorperil_id,
          EOP.asl_id,
          V.company_id,
          V.state_id,
          V.lob_id, RunningTotal) EOP
      INNER JOIN dbo.ASL ASL WITH(NOLOCK)
          ON EOP.asl_id = ASL.asl_id
      INNER JOIN dbo.MajorPeril MP WITH(NOLOCK)
          ON EOP.majorperil_id = MP.majorperil_id
      INNER JOIN dbo.LOB LOB WITH (NOLOCK)
        ON EOP.lob_id = LOB.lob_id
    INNER JOIN Customer_Reports.dbo.Treaty t
    ON eop.eff_date between t.eff_date and t.exp_date
    AND lob.lob_id = t.lob_id
      INNER JOIN dbo.[State] S WITH (NOLOCK)
        ON EOP.state_id = S.state_id
      INNER JOIN dbo.CompanyNameLink CNL WITH (NOLOCK)
        ON EOP.company_id = CNL.company_id
      INNER JOIN dbo.[Name] CN WITH (NOLOCK)
        ON CNL.name_id = CN.name_id
          AND CNL.nameaddresssource_id = 7

      GROUP BY   EOP.TransMonth,
        EOP.policy,
        EffMonth,
        MonthlyLag,
        MP.majorperil,
        renewal_ver,
        new_renew,
        liabonly_Full,
        Coverage,
        ASL.[description],
        MP.[description],
        CN.commercial_name1,
        S.[state],
        LOB.lobname,
        RunningTotal,
        EOP.Eff_date,
        Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')';;

      sql_trigger_value: SELECT MAX([year] * 100 + [month]) FROM EOPMonthlyPremiums;;
      indexes: ["policy", "transmonth", "renewal_ver", "coverage"]
  }

    measure: unique_policy {
        label: "Policy Count"
        type: count_distinct
        sql: ${TABLE}.policy ;;
    }

    dimension: primay_key {
      type: string
      hidden: yes
      sql: CONCAT(${TABLE}.policy, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coverage, ' ', ${TABLE}.transmonth) ;;
    }

    dimension: trans_month {
      type: number
      hidden: yes
      value_format_name: id
      sql: ${TABLE}.TransMonth ;;
    }

    dimension: policy {
      type: string
      hidden: yes
      sql: ${TABLE}.policy ;;
    }

    dimension: eff_month {
      label: "Policy Eff Month"
      type: number
      value_format_name: id
      sql: ${TABLE}.EffMonth ;;
    }

    dimension: monthly_lag {
      label: "Lag"
      type: string
      sql: ${TABLE}.MonthlyLag ;;
    }

    dimension: renewal_ver {
      type: number
      hidden: yes
      sql: ${TABLE}.renewal_ver ;;
    }

    dimension: new_renew {
      label: "New/Renew"
      type: string
      sql: ${TABLE}.new_renew ;;
    }

    dimension: liabonly_full {
      label: "Liab/Full Coverage"
      type: string
      sql: ${TABLE}.liabonly_Full ;;
    }

    dimension: coverage {
      label: "Coverage"
      type: string
      sql: ${TABLE}.Coverage ;;
    }

    dimension: treaty {
      label: "Treaty Name"
      type: string
      sql: ${TABLE}.Treaty ;;
    }

    dimension: commercial_name1 {
      label: "Agency"
      type: string
      sql: ${TABLE}.commercial_name1 ;;
    }

    dimension: state {
      label: "State"
      type: string
      sql: ${TABLE}.state ;;
    }

    dimension: lobname {
      label: "Product"
      type: string
      sql: ${TABLE}.lobname ;;
    }

    dimension: asl {
      label: "ASL"
      type: string
      sql: ${TABLE}.ASL ;;
    }

    dimension: mp {
      type: string
      hidden: yes
      sql: ${TABLE}.MP ;;
    }

    dimension: premium_earned_mtd {
      hidden: yes
      type: string
      sql: ${TABLE}.premium_earned_mtd ;;
    }

    measure: itdpremium_total {
      label: "Written Premium ITD"
      type: sum
      sql: ${TABLE}.ITDPremiumTotal ;;
    }

    dimension: majorperil {
      type: string
      hidden: yes
      sql: ${TABLE}.majorperil ;;
    }

    dimension: policy_effdate {
      type: date
      hidden: yes
      sql: ${TABLE}.policy_effdate ;;
    }

    set: detail {
      fields: [
        trans_month,
        policy,
        eff_month,
        monthly_lag,
        renewal_ver,
        new_renew,
        liabonly_full,
        coverage,
        commercial_name1,
        state,
        lobname,
        asl,
        mp,
        premium_earned_mtd,
        itdpremium_total,
        majorperil,
        policy_effdate
      ]
    }
  }

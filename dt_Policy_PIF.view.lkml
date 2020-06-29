view: dt_policy_pif {
    derived_table: {
      sql: Select
            Left(policy, 3) as Company,
            pim.Policy_id,
            pim.policyimage_num,
            Policy,
            pim.Renewal_ver,
            Eff_date,
            Exp_date,
            cast(pim.trans_date as Date) TransDate,
            CASE WHEN TransType_id in (1,7) THEN 'CN'
              WHEN TransType_id = 2 THEN 'NB'
              WHEN TransType_id = 4 THEN 'RN' --and policystatuscode_id not in (9, 10)
              WHEN TransType_id = 3 THEN 'ED'
              WHEN TransType_id = 5 THEN 'RI'
            END as TransType,
            CAST(Trans_date + 1 - (@@DATEFIRST + DATEPART(WEEKDAY,Trans_date)) % 7 AS DATE) as TransWeek,
            DATEPART(MM, Trans_date) as TransMonth,
            YEAR(pim.Trans_Date) TransYear,
            cast(pim.teff_date as Date) TransEffDate,
            cast(pim.texp_date as Date) TransExpDate,
            premium_chg_written,
            0 as CashCollected,
            0 as ispif,
            CASE WHEN TransType_id in (1,7) and policystatuscode_id not in (9,10) THEN -1
              WHEN TransType_id = 2 THEN 1
              WHEN TransType_id = 4 and policystatuscode_id not in (9,10, 11) --Premium_fullterm > 0
                                            THEN 1
              --WHEN TransType_id = 4 and Premium_fullterm = 0  THEN -1  --and policystatuscode_id not in (9, 10)
              --WHEN TransType_id = 3 THEN 0
              WHEN TransType_id = 5 and  policystatuscode_id not in (9,10)--Premium_fullterm > 0
                                            THEN 1
              --WHEN TransType_id = 5 and Premium_fullterm = 0  THEN -1
              ELSE 0
            END as Inforce,
            GETDATE() CreatedDate
            from ProductionBackup.dbo.policyimage pim
            INNER JOIN ProductionBackup.dbo.Policy P WITH(NOLOCK)
              ON P.policy_id = PIM.policy_id
            INNER JOIN ProductionBackup.dbo.Agency A WITH (NOLOCK)
              ON A.agency_id = pim.agency_id
              AND A.Code not in ('53000', '53143')
            where PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
            and transtype_id in (1,2,3,4,5,7)

            UNION ALL

            Select
            Left(pim.policy, 3) as Company,
            pim.policy_id,
            pim.policyimage_num,
            pim.Policy,
            pim.Renewal_ver,
            Eff_date,
            Exp_date,
            cast(exp_date as Date),
            'EX' TransType,
            --CAST(exp_date as date),
            CAST(cast(exp_date as Datetime) + 1 - (@@DATEFIRST + DATEPART(WEEKDAY,cast(exp_date as Datetime))) % 7 AS DATE) as TransWeek,
            DATEPART(MM, exp_date) as TransMonth,
            YEAR(exp_date),
            cast(exp_date as Date) TransEffDate,
            cast(exp_date as Date) TransExpDate,
            SUM(-PIM.premium_written),
            0,
            0,
            -1 Inforce,
            GETDATE()
            From ProductionBackup.dbo.policyimage pim
            join (Select policy_id, renewal_ver, agency_id, Version_id, Max(PolicyImage_num) as MaxNum
                FROM ProductionBackup.dbo.PolicyImage
                group by policy_id, renewal_ver, agency_id, Version_id) PIM1
                  ON Pim1.policy_id = PIM.policy_id
                  AND Pim1.renewal_ver = PIM.renewal_ver
                  AND pim1.maxnum = pim.policyimage_num
            join (Select policy_id, policy, renewal_ver, sum(inforce) as inforce
                FROM (Select pim.policy_id, policy, renewal_ver,
                  CASE  WHEN TransType_id in (1,7) and policystatuscode_id not in (9,10) THEN -1
                      WHEN TransType_id = 2 THEN 1
                      WHEN TransType_id = 4 and policystatuscode_id not in (9,10, 11) THEN 1  --Premium_fullterm > 0
                      WHEN TransType_id = 5 and  policystatuscode_id not in (9,10) THEN 1 --Premium_fullterm > 0
                  ELSE 0 END as Inforce
                  FROM ProductionBackup.dbo.policyimage pim
                    INNER JOIN ProductionBackup.dbo.Policy P WITH(NOLOCK)
                      ON P.policy_id = PIM.policy_id
                    INNER JOIN ProductionBackup.dbo.Agency A WITH (NOLOCK)
                      ON A.agency_id = pim.agency_id
                      AND A.Code not in ('53000', '53143')
                  WHERE PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
                      and transtype_id in (1,2,3,4,5,7)) z
                  group by policy_id, policy, renewal_ver having sum(inforce) = 1
                ) a
                ON a.policy = pim.policy
                AND a.renewal_ver = pim.renewal_ver
                AND a.policy_id = pim.policy_id

            WHERE pim.exp_date < CAST(GETDATE() as Date)
            GROUP BY
            Left(pim.policy, 3),
            pim.policy_id,
            pim.policyimage_num,
            pim.Policy,
            pim.Renewal_ver,
            Eff_date,
            Exp_date,
            cast(exp_date as Date),
            CAST(cast(exp_date as Datetime) + 1 - (@@DATEFIRST + DATEPART(WEEKDAY,cast(exp_date as Datetime))) % 7 AS DATE),
            DATEPART(MM, exp_date),
            YEAR(exp_date),
            cast(exp_date as Date),
            cast(exp_date as Date)
               ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: primarykey {
      primary_key: yes
      hidden: yes
      sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.policyimage_num, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.transdate, ' ', ${TABLE}.transtype, ' ', ${TABLE}.inforce);;
    }

    dimension: policy_id {
      type: number
      hidden: yes
      sql: ${TABLE}.Policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      hidden: yes
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: policy {
      type: string
      sql: ${TABLE}.Policy ;;
    }

    dimension: renewal_ver {
      type: number
      sql: ${TABLE}.Renewal_ver ;;
    }

    dimension: eff_date {
      label: "Policy Eff Date"
      type: date
      sql: ${TABLE}.Eff_date ;;
    }

    dimension: exp_date {
      label: "Policy Exp Date"
      type: date
      sql: ${TABLE}.Exp_date ;;
    }

    dimension_group: trans_date {
      label: "Transaction Time Increment"
      type: time
      timeframes: [date, week, month, year]
      sql: ${TABLE}.TransDate ;;
    }

    dimension: trans_type {
      type: string
      hidden: yes
      sql: ${TABLE}.TransType ;;
    }

    dimension: trans_week {
      type: date
      hidden: yes
      sql: ${TABLE}.TransWeek ;;
    }

    dimension: trans_month {
      type: number
      hidden: yes
      sql: ${TABLE}.TransMonth ;;
    }

    dimension: trans_year {
      type: number
      hidden: yes
      sql: ${TABLE}.TransYear ;;
    }

    dimension: tran_eff_date {
      label: "Effective Date of Transaction"
      type: date
      sql: ${TABLE}.TransEffDate ;;
    }

    dimension: tran_exp_date {
      type: date
      sql: ${TABLE}.TransExpDate ;;
    }

    measure: written_premium {
      type: sum
      sql: ${TABLE}.premium_chg_written ;;
    }

    dimension: cash_collected {
      type: number
      sql: ${TABLE}.CashCollected ;;
    }

    measure: inforce {
      type: sum
      sql: ${TABLE}.Inforce ;;
    }

    set: detail {
      fields: [
        policy_id,
        policyimage_num,
        policy,
        renewal_ver,
        eff_date,
        exp_date,
        tran_eff_date,
        written_premium,
        cash_collected,
        inforce
      ]
    }
  }

view: dt_quote {
  derived_table: {
      sql: Select
            Left(policy, 3) as Company,
            pim.Policy_id,
            pim.policyimage_num,
            pim.version_id,
            Policy,
            Quote,
            pim.Renewal_ver,
            pim.agency_id,
            Eff_date,
            Exp_date,
            cast(cast(pim.trans_date as Date) as Datetime) TransDate,
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
            CASE WHEN version_id = 1 -- BLUE
                THEN CASE WHEN TransType_id in (1,7) and policystatuscode_id not in (9,10) THEN -1
                  WHEN TransType_id = 2 THEN 1
                  WHEN TransType_id = 4 and policystatuscode_id not in (9,10, 11) --Premium_fullterm > 0
                                                THEN 1
                  --WHEN TransType_id = 4 and Premium_fullterm = 0  THEN -1  --and policystatuscode_id not in (9, 10)
                  --WHEN TransType_id = 3 THEN 0
                  WHEN TransType_id = 5 and  policystatuscode_id not in (9,10)--Premium_fullterm > 0
                                                THEN 1
                  --WHEN TransType_id = 5 and Premium_fullterm = 0  THEN -1
                  ELSE 0
                  END
                ELSE
                  CASE WHEN TransType_id in (1,7) and policystatuscode_id not in (9) THEN -1
                  WHEN TransType_id = 2 THEN 1
                  WHEN TransType_id = 4 and policystatuscode_id not in (9) --Premium_fullterm > 0
                                                THEN 1
                  --WHEN TransType_id = 4 and Premium_fullterm = 0  THEN -1  --and policystatuscode_id not in (9, 10)
                  --WHEN TransType_id = 3 THEN 0
                  WHEN TransType_id = 5 and  policystatuscode_id not in (9)--Premium_fullterm > 0
                                                THEN 1
                  --WHEN TransType_id = 5 and Premium_fullterm = 0  THEN -1
                  ELSE 0
                  END
                END as Inforce,
            GETDATE() CreatedDate
            from ProductionBackup.dbo.policyimage pim
            INNER JOIN ProductionBackup.dbo.Policy P WITH(NOLOCK)
              ON P.policy_id = PIM.policy_id
            INNER JOIN ProductionBackup.dbo.Agency A WITH (NOLOCK)
              ON A.agency_id = pim.agency_id
              AND A.Code not in ('53000', '53143')
            where PIM.policystatuscode_id IN (12)
            and transtype_id in (1,2,3,4,5,7)


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

    dimension: quote {
      type: string
      sql: ${TABLE}.Quote ;;
    }

    dimension: renewal_ver {
      type: number
      sql: ${TABLE}.Renewal_ver ;;
    }

    dimension: agency_id {
      type: number
      hidden: yes
      sql: ${TABLE}.agency_id ;;
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
      timeframes: [date, month, quarter, year, week]
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
      label: "Expiration Date of Transaction"
      type: date
      sql: ${TABLE}.TransExpDate ;;
    }

    measure: written_premium {
      label: "Trans Writ Prem"
      type: sum
      sql: ${TABLE}.premium_chg_written ;;
    }

    measure: written_premium_total {
      label: "Total Writ Prem"
      type: sum
      sql: ${TABLE}.premium_chg_written ;;
      filters: [trans_type: "NB, RN"]
    }

    measure: avgwritten_premium {
      label: "Avg Written Premium"
      type: average
      sql: ${TABLE}.premium_chg_written ;;
    }

    dimension: cash_collected {
      type: number
      sql: ${TABLE}.CashCollected ;;
    }

  dimension: version {
    type: number
    sql: ${TABLE}.version_id ;;
  }

    set: detail {
      fields: [
        policy,
        eff_date,
        exp_date,
        written_premium
      ]
    }
  }

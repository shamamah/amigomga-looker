view: dt_policy_pif {
    derived_table: {
      sql: Select
              pim.Policy_id,
              pim.policyimage_num,
              Policy,
              pim.Renewal_ver,
              Eff_date ,
              Exp_date ,
              cast(pim.trans_date as Date) as Trans_date,
              CASE WHEN TransType_id in (1,7) THEN 'CN'
                WHEN TransType_id = 2 THEN 'NB'
                WHEN TransType_id = 4 THEN 'RN' --and policystatuscode_id not in (9, 10)
                WHEN TransType_id = 3 THEN 'ED'
                WHEN TransType_id = 5 THEN 'RI'
              END as TransType,
              CAST(Trans_date + 1 - (@@DATEFIRST + DATEPART(WEEKDAY,Trans_date)) % 7 AS DATE) as TransWeek,
              DATEPART(MM, Trans_date) as TransMonth,
              YEAR(pim.Trans_Date) TransYear,
              cast(pim.teff_date as Date) TranEff_date,
              premium_chg_written written_premium,
              0 Cash_collected,
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
              END as Inforce
              from policyimage pim
              INNER JOIN Policy P WITH(NOLOCK)
                ON P.policy_id = PIM.policy_id
              INNER JOIN Agency A WITH (NOLOCK)
                ON A.agency_id = pim.agency_id
                AND A.Code not in ('53000', '53143')
              where PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
              --and teff_date < CAST(GETDATE() as Date)
              and transtype_id in (1,2,3,4,5,7)
              --and trans_date >= '2020-04-22'
               ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.Policy_id ;;
    }

    dimension: policyimage_num {
      type: number
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
      type: date
      sql: ${TABLE}.Eff_date ;;
    }

    dimension: exp_date {
      type: date
      sql: ${TABLE}.Exp_date ;;
    }

    dimension: trans_date {
      type: date
      sql: ${TABLE}.Trans_date ;;
    }

    dimension: trans_type {
      type: string
      sql: ${TABLE}.TransType ;;
    }

    dimension: trans_week {
      type: date
      sql: ${TABLE}.TransWeek ;;
    }

    dimension: trans_month {
      type: number
      sql: ${TABLE}.TransMonth ;;
    }

    dimension: trans_year {
      type: number
      sql: ${TABLE}.TransYear ;;
    }

    dimension: tran_eff_date {
      type: date
      sql: ${TABLE}.TranEff_date ;;
    }

    dimension: written_premium {
      type: string
      sql: ${TABLE}.written_premium ;;
    }

    dimension: cash_collected {
      type: number
      sql: ${TABLE}.Cash_collected ;;
    }

    dimension: inforce {
      type: number
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
        trans_date,
        trans_type,
        trans_week,
        trans_month,
        trans_year,
        tran_eff_date,
        written_premium,
        cash_collected,
        inforce
      ]
    }
  }

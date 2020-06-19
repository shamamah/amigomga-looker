view: dt_premiums_jp {
  derived_table: {
    sql: SELECT
    CASE WHEN ISDATE(eff_date) = 0 THEN
        CASE WHEN eff_date like '%-02-%' THEN CAST(left(eff_date, 8) + '28' as datetime) ELSE CAST(left(eff_date, 8) + '30' as datetime) END
          ELSE CAST(eff_date as datetime) END as eff_date,
        Year,
        Month,
        company_id,
        state_id,
        lob_id,
        coveragecode_id,
        caption,
        policy_id,
--        Policyimage_num,
        renewal_ver,
        unit_num,
        SUM(TotalEarnedPremium) as TotalEarnedPremium,
        SUM(TotalWrittenPremium) as TotalWrittenPremium
        FROM (SELECT
                CAST(YEAR as varchar(4)) + '-' + RIGHT('00' + CAST(MONTH as Varchar(2)), 2) + '-' + RIGHT('00' + CAST(DAY(accounting_date) as varchar(2)), 2) as Eff_date,
                year,
                month,
                V.company_id,
                V.state_id,
                V.lob_id,
                EMP.coveragecode_id,
                CCV.caption,
                policy_id,
    --            Policyimage_num,
                renewal_ver,
                unit_num,
                SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
                SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPMonthlyPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY
            CAST(YEAR as varchar(4)) + '-' + RIGHT('00' + CAST(MONTH as Varchar(2)), 2) + '-' + RIGHT('00' + CAST(DAY(accounting_date) as varchar(2)), 2),
            YEAR,
            MONTH,
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
 --           Policyimage_num,
            renewal_ver,
            unit_num


          UNION ALL

          SELECT
            CAST(YEAR(GETDATE()-1) as varchar(4)) + '-' + RIGHT('00' + CAST(MONTH(GETDATE()-1) as Varchar(2)), 2) + '-' + RIGHT('00' + CAST(DAY(accounting_date) as varchar(2)), 2) as Eff_date,
            YEAR(GETDATE()-1) as YEAR,
            MONTH(GETDATE()-1) as MONTH,
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
--            Policyimage_num,
            renewal_ver,
            unit_num,
            SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
            SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN .CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY
            CAST(YEAR(GETDATE()-1) as varchar(4)) + '-' + RIGHT('00' + CAST(MONTH(GETDATE()-1) as Varchar(2)), 2) + '-' + RIGHT('00' + CAST(DAY(accounting_date) as varchar(2)), 2),
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
 --           Policyimage_num,
            renewal_ver,
            unit_num) xx
      Group by
        CASE WHEN ISDATE(eff_date) = 0 THEN
          CASE WHEN eff_date like '%-02-%' THEN CAST(left(eff_date, 8) + '28' as datetime) ELSE CAST(left(eff_date, 8) + '30' as datetime) END
          ELSE CAST(eff_date as datetime) END,
        YEAR,
        MONTH,
        company_id,
        state_id,
        lob_id,
        coveragecode_id,
        caption,
        policy_id,
--          Policyimage_num,
        renewal_ver,
        unit_num
 ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.unit_num, ' ', ${TABLE}.year, ' ', ${TABLE}.month, ' ', CAST(${TABLE}.eff_date as DATE));;
  }

  measure: total_earned_premium {
    label: "Total Earned Premium"
    type: sum
    sql: ${TABLE}.totalearnedpremium ;;
  }

  measure: total_written_premium {
    label: "Total Written Premium"
    type: sum
    sql: ${TABLE}.totalwrittenpremium ;;
  }

  measure: count {
    label: "Policy Count"
    type: count_distinct
    sql: ${TABLE}.policy_id ;;
  }


  measure: avgEarned {
    label: "Avg Earned"
    type: average
    value_format: "0.##"
    sql: ${TABLE}.totalearnedpremium ;;
  }


  dimension_group: eff_date {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.eff_date;;

  }


  dimension: new_renewal {
    label: "New vs. Renewal"
    type: string
    sql: CASE WHEN ${TABLE}.renewal_ver=1 THEN 'New' ELSE 'Renewal' END ;;
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

  dimension: unit_num {
    type: number
    hidden: yes
    sql: ${TABLE}.unit_num ;;
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

  dimension: policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_id ;;
  }


  dimension: renewal_ver {
    type: number
    hidden: yes
    sql: ${TABLE}.renewal_ver ;;
  }

}

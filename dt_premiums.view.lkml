view: dt_premiums {

  derived_table: {
    sql: SELECT
        year,
        month,
        company_id,
        state_id,
        lob_id,
        coveragecode_id,
        caption,
        policy_id,
 --       Policyimage_num,
        renewal_ver,
        unit_num,
        policy,
        eff_date,
        SUM(TotalEarnedPremium) as TotalEarnedPremium,
        SUM(TotalWrittenPremium) as TotalWrittenPremium
        FROM (SELECT
                EMP.YEAR,
                EMP.Month,
                V.company_id,
                V.state_id,
                V.lob_id,
                EMP.coveragecode_id,
                CCV.caption,
                policy_id,
--                Policyimage_num,
                renewal_ver,
                unit_num,
                policy,
                emp.eff_date,
                SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
                SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPMonthlyPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY
            EMP.year,
            EMP.month,
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
--            Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            emp.eff_date


          UNION ALL

          SELECT
            YEAR(GETDATE()-1) as year,
            MONTH(GETDATE()-1) as month,
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
 --           Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            emp.eff_date,
            SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
            SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN .CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY
            V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
  --          Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            emp.eff_date) xx
      Group by
            Year,
            Month,
            company_id,
            state_id,
            lob_id,
            coveragecode_id,
            caption,
            policy_id,
     --       Policyimage_num,
            renewal_ver,
            unit_num,
            policy,
            eff_date
 ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.unit_num, ' ', ${TABLE}.year, ' ', ${TABLE}.month) ;;
  }

  measure: total_earned_premium {
    label: "Total Earned Premium"
    type: sum
    sql: ${TABLE}.totalearnedpremium ;;
    drill_fields: [detail*]
  }

  measure: total_written_premium {
    label: "Total Written Premium"
    type: sum
    sql: ${TABLE}.totalwrittenpremium ;;
    drill_fields: [detail*]
  }


  measure: avgEarned {
    label: "Avg Earned"
    type: average
    value_format: "0.##"
    sql: ${TABLE}.totalearnedpremium ;;
  }

  measure: avgWritten {
    label: "Avg Written"
    type: average
    value_format: "0.##"
    sql: ${TABLE}.totalwrittenpremium ;;
  }


  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension_group: first_of_month {
    label: "First of Month"
    type: time
    sql: cast(cast(${TABLE}.year as varchar(4))+'-'+RIGHT(CAST('00' + ${TABLE}.month as varchar(4)),2)+'-01' as datetime) ;;
    timeframes: [month]
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
      total_earned_premium,
      total_written_premium
    ]
  }

}

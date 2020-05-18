view: dt_itd_premiums {
  derived_table: {
    sql: SELECT company_id,
        state_id,
        lob_id,
        coveragecode_id,
        caption,
        policy_id,
--        Policyimage_num,
        renewal_ver,
        SUM(TotalEarnedPremium) as TotalEarnedPremium,
        SUM(TotalWrittenPremium) as TotalWrittenPremium
        FROM (SELECT V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
--            Policyimage_num,
            renewal_ver,
            SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
            SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPMonthlyPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
 --           Policyimage_num,
            renewal_ver


          UNION ALL

          SELECT V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
--            Policyimage_num,
            renewal_ver,
            SUM(EMP.premium_earned_mtd) AS TotalEarnedPremium,
            SUM(EMP.premium_written_mtd) AS TotalWrittenPremium
          FROM EOPPremiums EMP WITH(NOLOCK)
          INNER JOIN [Version] V WITH(NOLOCK)
            ON V.version_id = EMP.version_id
          INNER JOIN .CoverageCodeVersion CCV WITH(NOLOCK)
            ON EMP.coveragecode_id = CCV.coveragecode_id
              AND V.version_id = CCV.version_id
          GROUP BY V.company_id,
            V.state_id,
            V.lob_id,
            EMP.coveragecode_id,
            CCV.caption,
            policy_id,
 --           Policyimage_num,
            renewal_ver) xx
          Group by company_id,
            state_id,
            lob_id,
            coveragecode_id,
            caption,
            policy_id,
  --          Policyimage_num,
            renewal_ver
 ;;
}


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.policy_id, ' ', ${TABLE}.renewal_ver, ' ', ${TABLE}.coveragecode_id) ;;
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

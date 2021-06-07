view: eop_premium_triangle_quarter {
  derived_table: {

    sql:  SELECT
        CONCAT(year, CASE WHEN month in (1,2,3) THEN '1'
                                        WHEN month in (4,5,6) THEN '2'
                                        WHEN month in (7,8,9) THEN '3'
                                        WHEN month in (10,11,12) THEN '4'
                                        END) as w_quarter,
        CAST('Q' + CAST(DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(1)) as varchar(2)) as QuarterID,
        CONCAT(YEAR(xx.eff_date), CASE WHEN MONTH(xx.eff_date) in (1,2,3) THEN '1'
                                        WHEN MONTH(xx.eff_date) in (4,5,6) THEN '2'
                                        WHEN MONTH(xx.eff_date) in (7,8,9) THEN '3'
                                        WHEN MONTH(xx.eff_date) in (10,11,12) THEN '4'
                                        END) As Policy_Quarter,

        company_id,
        state_id,
        xx.lob_id,
        lobname,
        coveragecode_id,
        caption,
 --       CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
        CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
        Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')' as Treaty,
        SUM(TotalEarnedPremium) as EarnedPremium,
        SUM(TotalWrittenPremium) as WrittenPremium,
    SUM(TotalUnearnedPremium) as UnearnedPremium
    FROM  Customer_Reports.dbo.Treaty t
    LEFT JOIN (SELECT
                  YEAR,
                  Month,
                  company_id,
                  companystatelob_id,
                  state_id,
                  lob_id,
                  coveragecode_id,
                  caption,
                  policy_id,
                  renewal_ver,
                  unit_num,
                  policy,
                  eff_date,
                  TotalEarnedPremium,
                  TotalWrittenPremium,
                  TotalUnearnedPremium
                  FROM Customer_Reports.dbo.PolicyPremium
                  ) xx
        ON t.lob_id = xx.lob_id
        AND xx.eff_date between t.eff_date and t.exp_date
        AND xx.companystatelob_id = t.companystatelob_id
     INNER JOIN LOB l
            ON l.lob_id = xx.lob_id
      LEFT JOIN (Select c.Policy_id, pim.renewal_ver, SUM(c.premium_fullterm) as prem from PolicyImage PIM
      JOIN ProductionBackup.dbo.Coverage c
        ON c.policy_id = pim.policy_id
        AND pim.policystatuscode_id not in (4, 5, 7, 8, 12, 13, 14)
      JOIN ProductionBackup.dbo.coveragecode cc
        on cc.coveragecode_id = c.coveragecode_id
        and cc.coveragetype = 'PhysicalDamage'
            GROUP by c.Policy_id, pim.renewal_ver
            HAVING SUM(c.premium_fullterm) > 0) cc1
              ON xx.policy_id = cc1.policy_id
              AND xx.renewal_ver = cc1.renewal_ver

      Group by
            CONCAT(year, CASE WHEN month in (1,2,3) THEN '1'
                                        WHEN month in (4,5,6) THEN '2'
                                        WHEN month in (7,8,9) THEN '3'
                                        WHEN month in (10,11,12) THEN '4'
                                        END),
      CAST('Q' + CAST(DATEDIFF(q, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(1)) as varchar(2)),
      CONCAT(YEAR(xx.eff_date), CASE WHEN MONTH(xx.eff_date) in (1,2,3) THEN '1'
                                        WHEN MONTH(xx.eff_date) in (4,5,6) THEN '2'
                                        WHEN MONTH(xx.eff_date) in (7,8,9) THEN '3'
                                        WHEN MONTH(xx.eff_date) in (10,11,12) THEN '4'
                                        END),

        company_id,
        state_id,
        xx.lob_id,
        lobname,
        coveragecode_id,
        caption,
--        ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
        CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
        Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
 ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.w_quarter, ' ', ${TABLE}.quarterID, ' ', ${TABLE}.Policy_quarter, ' ', ${TABLE}.NewRen, ' ', ${TABLE}.treaty)
    ;;
    }

  measure: total_earned_premium {
    label: "Earned Premium"
    type: sum
    sql: ${TABLE}.earnedpremium ;;

  }

  measure: total_written_premium {
    label: "Written Premium"
    type: sum
    sql: ${TABLE}.writtenpremium ;;
  }

  measure: total_unearned_premium {
    label: "Unearned Premium"
    type: sum
    sql: ${TABLE}.unearnedpremium ;;
  }


  # dimension: new_renewal {
  #   label: "New vs. Renewal"
  #   type: string
  #   sql: ${TABLE}.NewRen;;
  # }

  dimension: policy_year_quarter {
    label: "_Policy Year_QTR"
    type:  string
    sql: ${TABLE}.Policy_Quarter;;
  }

  dimension: lag_year_quarter {
    label: "_Lag Year_QTR"
    type: string
    sql: ${TABLE}.quarterID;;
  }

  dimension: trans_year_quarter {
    label: "_Trans Year_QTR (YYYYQ)"
    type: string
    sql: ${TABLE}.w_quarter ;;
  }
  # dimension: liab_full {
  #   type: string
  #   sql: ${TABLE}.LiabOnly_Full;;

  # }

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

  dimension: lobname {
    label: "Program Name (LOB)"
    type: string
    sql: ${TABLE}.lobname ;;
  }

  dimension: treaty {
    label: "Treaty Name"
    type: string
    sql: ${TABLE}.Treaty ;;
  }

  dimension: new_renewal {
    label: "New_Renew"
    type: string
    sql: ${TABLE}.NewRen ;;
  }
  dimension: coveragecode_id {
    type: number
    hidden: yes
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: caption {
    label: "Coverage"
    type: string
    sql: ${TABLE}.caption ;;
  }

}

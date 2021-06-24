view: eop_premium_triangle_accident_month {
  derived_table: {
    sql:  SELECT
        Year*100+month as Transmonth,
        'M' + RIGHT('00' + CAST(DATEDIFF(m, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(3)), 3) as Lagmonth,
        YEAR(xx.eff_date)*100+MONTH(xx.eff_date) as policymonth,
        xx.company_id,
        xx.state_id,
        xx.lob_id,
        lobname,
        coveragecode_id,
        caption,
 --       CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END as LiabOnly_Full,
        CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END as NewRen,
        n.display_name as CompanyName,
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
    JOIN ProductionBackup.dbo.CompanyLob cl
        ON cl.company_id = xx.company_id
        AND cl.lob_id = xx.lob_id
       JOIN ProductionBackup.dbo.CompanyNameLink cnl
        ON cnl.company_id = cl.company_id
       JOIN ProductionBackup.dbo.Name n
        ON n.name_id = cnl.name_id
    INNER JOIN LOB l
            ON l.lob_id = xx.lob_id
    LEFT JOIN (Select c.Policy_id, pim.renewal_ver, SUM(c.premium_fullterm) as prem
                FROM PolicyImage PIM
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
    GROUP BY
      Year*100+month,
      'M' + RIGHT('00' + CAST(DATEDIFF(m, xx.eff_date, CAST(year as varchar(4)) + '-' + CAST(RIGHT('00' + CAST(month as varchar(2)), 2) as varchar(2)) + '-01') + 1 as varchar(3)), 3),
      YEAR(xx.eff_date)*100+MONTH(xx.eff_date),
      xx.company_id,
      xx.state_id,
      xx.lob_id,
      lobname,
      coveragecode_id,
      caption,
--        ,CASE WHEN cc1.policy_id is NULL THEN 'Liab' Else 'Phys' END
      CASE WHEN xx.renewal_ver = 1 THEN 'New' ELSE 'Renew' END,
      n.display_name
--        Treaty_Name + ' (' + CAST(Treaty_num as varchar(2)) + ')'
 ;;
  }


  dimension: itd_premiums_primarykey {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.lob_id, ' ', ${TABLE}.coveragecode_id, ' ', ${TABLE}.transmonth, ' ', ${TABLE}.lagmonth, ' ', ${TABLE}.policymonth, ' ', ${TABLE}.NewRen)
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

  dimension: policy_month {
    label: "_Accident Month"
    type:  string
    sql: ${TABLE}.policymonth;;
  }

  dimension: lag_month {
    label: "_Lag Month"
    type: string
    sql: ${TABLE}.lagmonth;;
  }

  dimension: trans_month {
    label: "_Trans Month"
    type: string
    sql: ${TABLE}.transmonth ;;
  }

  dimension: company_name {
    label: "Company Name"
    type: string
    sql: ${TABLE}.companyname ;;
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

  # dimension: treaty {
  #   label: "Treaty Name"
  #   type: string
  #   sql: ${TABLE}.Treaty ;;
  # }

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

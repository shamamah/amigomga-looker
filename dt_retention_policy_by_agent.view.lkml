view: dt_retention_policy_by_agent {
  derived_table: {
    sql: Select 'About to Cancel' as GroupHeading,
        A1.Code,
        AN.display_name,
        pim.policy,
        CAST(p.cancel_date as Date) as Action_date,
        pim.exp_date
        ,n.first_name + ' ' + n.last_name as CustomerName
        ,phone_num as [Contact Phone]
        from PolicyImage PIM
        INNER JOIN Agency A1 ON A1.Agency_Id = PIM.Agency_ID
        INNER JOIN dbo.AgencyNameLink ANL WITH (NOLOCK)
        ON ANL.agency_id = PIM.agency_id
      INNER JOIN dbo.[Name] AN WITH (NOLOCK)
        ON AN.name_id = ANL.name_id
        join policy p on p.policy_id = pim.policy_id
        join billingnotice bn ON bn.policy_id = pim.policy_id
        and bn.policyimage_num = pim.policyimage_num
        join BillingNoticeType bt ON bt.billingnoticetype_id = bn.billingnoticetype_id
        left join billingcash bc ON bc.policy_id = pim.policy_id
        and bc.added_date >= bn.request_date

      join (Select Policy_id, driver_num, name_id, ROW_NUMBER() OVER(PARTITION BY POlicy_ID, Driver_num
              Order by POlicy_id, Driver_num, Name_ID desc) as Rownumber
        from DriverNameLink where driver_num = 1
        --and policy_id = 977
        ) dnl ON dnl.policy_id = p.policy_id
          and rownumber = 1
      join [name] n ON n.name_id = dnl.name_id
      left join (Select policy_id, phone_num,
          ROW_Number() OVER(Partition By POlicy_id  order by policy_id, phonetype_id) as Rownbr
          from Phone) ph on ph.policy_id = p.policy_id
              and ph.Rownbr = 1
      where request_date between DATEADD(d, 0, CAST(GETDATE() - 13 as Date)) and DATEADD(d, 0, CAST(GETDATE() - 11 as Date))
        and bc.policy_id is NULL
        and ((bn.billingnoticetype_id in (1) and pim.policystatuscode_id = 1)
          OR (bn.billingnoticetype_id = 17 and pim.policystatuscode_id <> 1))

      UNION

      SELECT 'About to Renew' as GroupHeading,
        A.Code,
        AN.display_name,
        P.current_policy,
        PIM.exp_date as RenewalDate,
        PIM.exp_date,
        PH1.display_name AS policyholder1_displayname,
        phone_num as [Contact Phone]
      FROM dbo.Policy P WITH (NOLOCK)
      INNER JOIN dbo.PolicyImage PIM WITH (NOLOCK)
        ON PIM.policy_id = P.policy_id
          AND PIM.policyimage_num = P.activeimage_num
      INNER JOIN dbo.[Name] PH1 WITH (NOLOCK)
        ON PH1.policy_id = PIM.policy_id
          AND PH1.policyimage_num = PIM.policyimage_num
          AND PH1.nameaddresssource_id = 3
      INNER JOIN dbo.[Version] V WITH (NOLOCK)
        ON V.version_id = PIM.version_id
      INNER JOIN dbo.CompanyStateLOB CSL WITH (NOLOCK)
        ON CSL.companystatelob_id = V.companystatelob_id
      INNER JOIN dbo.CompanyState CS WITH (NOLOCK)
          ON CS.companystate_id = CSL.companystate_id
      INNER JOIN dbo.CompanyLOB CL WITH (NOLOCK)
          ON CL.companylob_id = CSL.companylob_id
      INNER JOIN dbo.Company C WITH (NOLOCK)
          ON C.company_id = CS.company_id
      INNER JOIN dbo.LOB LOB WITH (NOLOCK)
          ON LOB.lob_id = CL.lob_id
      INNER JOIN dbo.[State] S WITH (NOLOCK)
          ON S.state_id = CS.state_id
      INNER JOIN dbo.CompanyNameLink CNL WITH (NOLOCK)
          ON CNL.company_id = C.company_id
      INNER JOIN dbo.[Name] CN WITH (NOLOCK)
          ON CN.name_id = CNL.name_id
          AND CNL.nameaddresssource_id = 7
      INNER JOIN dbo.Agency A WITH (NOLOCK)
        ON A.agency_id = PIM.agency_id
      INNER JOIN dbo.AgencyNameLink ANL WITH (NOLOCK)
        ON ANL.agency_id = A.agency_id
      INNER JOIN dbo.[Name] AN WITH (NOLOCK)
        ON AN.name_id = ANL.name_id
      left join (Select policy_id, phone_num,
          ROW_Number() OVER(Partition By POlicy_id  order by policy_id, phonetype_id) as Rownbr
          from Phone) ph on ph.policy_id = p.policy_id
              and ph.Rownbr = 1
      INNER JOIN dbo.PolicyImage PIRen WITH (NOLOCK)
        ON PIRen.policy_id = P.policy_id
          AND PIRen.policyimage_num = P.lastimage_num

      WHERE
        ANL.nameaddresssource_id = 8
        AND PIM.policystatuscode_id = 1
        AND PIM.exp_date BETWEEN DATEADD(d, 0, CAST(GETDATE() as Date)) and DATEADD(d, 0, CAST(GETDATE() + 2 as Date))
        AND (PIM.Renewal_ver = CASE
                        WHEN PIRen.transtype_id = 8 THEN PIM.renewal_ver  --Renewal Underwriting
                        ELSE PIRen.Renewal_Ver
                      END)
          AND CASE
              WHEN P.policycurrentstatus_id = 3 AND PIRen.transtype_id = 15 AND PIRen.teff_date = PIM.exp_date THEN 1 -- Returns ABT policies
              WHEN P.policycurrentstatus_id <> 3 THEN 1
            END = 1

      UNION

      Select 'Expired 15 Days' as GroupHeading,
            A1.Code,
            AN.display_name,
            pim.policy,
            CAST(pim.exp_date as Date) as Action_Date,
            pim.exp_date
            ,n.first_name + ' ' + n.last_name as CustomerName
            ,phone_num as [Contact Phone]
            from PolicyImage PIM
      INNER JOIN (Select Policy_id, Renewal_ver, Policyimage_num from
              (Select Policy_id, Renewal_ver, Max(policyimage_num) policyimage_num
                  from policyimage
                  Group by Policy_id, Renewal_ver) a)z
            ON z.policy_id = PIM.policy_id
            AND z.renewal_ver = PIM.Renewal_ver
            AND z.policyimage_num = PIM.policyimage_num
            INNER JOIN Agency A1 ON A1.Agency_Id = PIM.Agency_ID
            INNER JOIN dbo.AgencyNameLink ANL WITH (NOLOCK)
            ON ANL.agency_id = PIM.agency_id
          INNER JOIN dbo.[Name] AN WITH (NOLOCK)
            ON AN.name_id = ANL.name_id
            join policy p on p.policy_id = pim.policy_id
          join (Select Policy_id, driver_num, name_id, ROW_NUMBER() OVER(PARTITION BY POlicy_ID, Driver_num
                  Order by POlicy_id, Driver_num, Name_ID desc) as Rownumber
            from DriverNameLink where driver_num = 1
            ) dnl ON dnl.policy_id = p.policy_id
              and rownumber = 1
          join [name] n ON n.name_id = dnl.name_id
          left join (Select policy_id, phone_num,
              ROW_Number() OVER(Partition By POlicy_id  order by policy_id, phonetype_id) as Rownbr
              from Phone) ph on ph.policy_id = p.policy_id
                  and ph.Rownbr = 1
          left join policyimage pim2
            ON pim2.policy_id = pim.policy_id
              AND pim2.transtype_id = 4
              and pim2.eff_date > pim.exp_date
      where pim.exp_date = DATEADD(d, 0, CAST(GETDATE()-15 as Date))
      AND PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
      AND PIM.Transtype_id <> 1
      and pim2.policy_id is NULL
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: group_heading {
    label: "Action Category"
    type: string
    sql: ${TABLE}.GroupHeading ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.Code ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: policy {
    type: string
    sql: ${TABLE}.policy ;;
  }

  dimension: action_date {
    type: date
    sql: ${TABLE}.Action_date ;;
  }

  dimension: exp_date {
    type: date
    sql: ${TABLE}.exp_date ;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.CustomerName ;;
  }

  dimension: contact_phone {
    type: string
    label: "Contact Phone"
    sql: ${TABLE}."Contact Phone" ;;
  }

  set: detail {
    fields: [
      group_heading,
      code,
      display_name,
      policy,
      action_date,
      exp_date,
      customer_name,
      contact_phone
    ]
  }
}

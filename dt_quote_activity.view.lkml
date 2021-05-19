view: dt_quote_activity {
  derived_table: {
    sql: SELECT
        PIM.policy
        ,
        PIM.eff_date,
        PIM.quote,
        PIM.agency_id,
        AN.commercial_name1 AS agency_name,
        A.code AS agency_code,
        POT.dscr AS policy_origin_type_dscr,
        CASE WHEN qs.dSCR is NULL and POT.dscr = 'Comparative Rating' then 'AA'
          WHEN qs.dSCR = 'N/A' and POT.dscr = 'Comparative Rating' then 'AA'
          WHEN POT.dscr = 'Diamond' THEN POT.Dscr ELSE qs.dSCR END as QuoteSource ,
        L.lobname,
        CASE WHEN l.lob_id = 1 Then 'Amigo Blue'
          WHEN l.lob_id = 2 Then 'Amigo America'
          WHEN l.lob_id = 3 THEN 'Amigo USA'
          ELSE 'Other' END as ShortLOB,
        CAST(PIM.Trans_Date as Date) as Trans_Date,
          CASE
            WHEN PIM.policystatuscode_id IN (1, 2, 3, 20) THEN 1 --In-Force, Future, History, Expired
            ELSE 0
          END
         AS bound,
         CASE WHEN wp.policy_number is not NULL THEN 1 ELSE 0 END as BridgedQuote,
         v.company_id,
         n.display_name as Companyname
      FROM ProductionBackup.dbo.PolicyImage PIM WITH (NOLOCK)
        INNER JOIN ProductionBackup.dbo.[Policy] P WITH (NOLOCK)
          ON PIM.policy_id = P.policy_id
        INNER JOIN ProductionBackup.dbo.Agency A WITH (NOLOCK)
          ON PIM.agency_id = A.agency_id
          AND A.Code not in ('53000', '53143')
        INNER JOIN ProductionBackup.dbo.AgencyNameLink ANL WITH (NOLOCK)
          ON A.agency_id = ANL.agency_id
            AND ANL.nameaddresssource_id = 8 --Agency
        INNER JOIN ProductionBackup.dbo.[Name] AN WITH (NOLOCK)
          ON ANL.name_id = AN.name_id
        INNER JOIN ProductionBackup.dbo.[Version] V
          ON PIM.version_id = V.version_id
        INNER JOIN ProductionBackup.dbo.CompanyStateLOB csb
          ON v.companystatelob_id = csb.companystatelob_id
        INNER JOIN ProductionBackup.dbo.CompanyNameLink cnl
          ON cnl.company_id = v.company_id
        INNER JOIN ProductionBackup.dbo.Name n
          ON n.name_id = cnl.name_id
        INNER JOIN ProductionBackup.dbo.Lob L WITH (NOLOCK)
          ON V.lob_id = L.lob_id
        INNER JOIN ProductionBackup.dbo.PolicyStatusCode PSC WITH (NOLOCK)
          ON PIM.policystatuscode_id = PSC.policystatuscode_id
        INNER JOIN ProductionBackup.dbo.PolicyOriginType POT WITH (NOLOCK)
          ON P.policyorigintype_id = POT.policyorigintype_id
        LEFT JOIN ProductionBackup.dbo.WebPolicyWorkFlowLink wp
          ON wp.policy_number = pim.policy
          AND wp.webworkflowtype_id <> 0
        LEFT JOIN ProductionBackup.dbo.QuoteSource QS
          ON QS.QuoteSource_ID = p.quotesource_id
      WHERE PIM.transtype_id = 2 --New Business
        and cast(PIM.trans_date as date) >= DATEADD(d, -150, CAST(GETDATE() as Date))

     ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: policy {
    type: string
    sql: ${TABLE}.policy ;;
  }

  dimension: eff_date {
    type: date
    sql: ${TABLE}.eff_date ;;
  }

  dimension: quote {
    type: string
    sql: ${TABLE}.quote ;;
  }

  dimension: agency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.agency_id ;;
  }

  dimension: agency_name {
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: agency_code {
    type: string
    sql: ${TABLE}.agency_code ;;
  }

  dimension: policy_origin_type_dscr {
    type: string
    sql: ${TABLE}.policy_origin_type_dscr ;;
  }

  dimension: quote_source {
    type: string
    sql: ${TABLE}.QuoteSource ;;
  }

  dimension: lobname {
    type: string
    sql: ${TABLE}.lobname ;;
  }

  dimension: short_lob {
    type: string
    sql: ${TABLE}.ShortLOB ;;
  }

  dimension_group: trans_date {
    type: time
    sql: ${TABLE}.Trans_Date ;;
  }

  dimension: bound {
    type: number
    sql: ${TABLE}.bound ;;
  }

  dimension: bridged_quote {
    type: number
    sql: ${TABLE}.BridgedQuote ;;
  }

  dimension: company_id {
    type: number
    hidden: yes
    sql: ${TABLE}.company_id ;;
  }

  dimension: companyname {
    type: string
    sql: ${TABLE}.Companyname ;;
  }

  set: detail {
    fields: [
      policy,
      eff_date,
      quote,
      agency_id,
      agency_name,
      agency_code,
      policy_origin_type_dscr,
      quote_source,
      lobname,
      short_lob,
      bound,
      bridged_quote,
      company_id,
      companyname
    ]
  }
}

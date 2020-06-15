view: dt_claim_coverage {
  derived_table: {
    sql:

    select cc.claimcontrol_id as 'claimcontrol_id'
        ,cc.claimcoverage_num as 'claimcoverage_num'
        ,cc.claimexposure_id
        ,cc.claimsubexposure_num
        ,cc.coveragecode_id
        ,ce.dscr as 'Exposure'
        ,cd.dscr as 'Coverage'
        ,cc.limit_dscr as 'Limit'
        ,cc.deductible_dscr as 'Deductible'
      from claimcoverage cc
        left join ClaimExposure ce on ce.claimexposure_id = cc.claimexposure_id
        left join CoverageCode cd on cd.coveragecode_id = cc.coveragecode_id
      where 1=1
        and cd.dscr <> 'N/A'
        and cc.claimsubexposure_num < 2 ;;
  }

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},' ', ${claimcoverage_num}) ;;
  }

  dimension: claimcontrol_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: coveragecode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coveragecode_id ;;
  }

  dimension: claimexposure_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimexposure_id ;;
  }

  dimension: claimsubexposure_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimsubexposure_num ;;
  }

  dimension: claimcoverage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.claimcoverage_num ;;
  }

  dimension: exposure {
    label: "Exposure"
    type: string
    sql: ${TABLE}.Exposure ;;
  }

  dimension: coverage {
    label: "Coverage"
    type: string
    sql: ${TABLE}.Coverage ;;
  }

  dimension: coverage_with_number {
    label: "Coverage (with Number)"
    type: string
    sql: CONCAT(IIF(${claimcoverage_num}<10,'[0','['),${claimcoverage_num},'] ',${TABLE}.Coverage);;
  }

  dimension: limit {
    label: "Limit"
    type: string
    sql: ${TABLE}.Limit ;;
  }

  dimension: deductible {
    label: "Deductible"
    type: string
    sql: ${TABLE}.Deductible ;;
  }

  measure: count {
    label: "Count"
    type: count
    drill_fields: [coverage_detail*]
  }

  set: coverage_detail {
    fields: [
      claim_control.claim_number,
      coverage_with_number,
      limit,
      deductible
    ]
  }
}

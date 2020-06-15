view: dt_company_coverages {
  derived_table: {
    sql: SELECT DISTINCT V.company_id,
          V.state_id,
          V.lob_id,
          V.version_id,
          asl_id,
          majorperil_id,
          coveragecode_id,
          caption
        FROM CoverageCodeVersion WITH (NOLOCK)
        INNER JOIN [Version] V WITH (NOLOCK)
          ON CoverageCodeVersion.version_id = V.version_id
       ;;
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

  dimension: asl_id {
    type: number
    hidden: yes
    sql: ${TABLE}.asl_id ;;
  }

  dimension: majorperil_id {
    type: number
    hidden: yes
    sql: ${TABLE}.majorperil_id ;;
  }

  dimension: version_id {
    type: number
    hidden: yes
    sql: ${TABLE}.version_id ;;
  }

  dimension: caption {
    type: string
    sql: ${TABLE}.caption ;;
  }

}

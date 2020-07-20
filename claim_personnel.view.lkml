view: claim_personnel {
  sql_table_name: claimpersonnel
        ;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: claimpersonnel_id {
      type: number
      primary_key: yes
      sql: ${TABLE}.claimpersonnel_id ;;
    }

    dimension: claimpersonneltype_id {
      type: number
      sql: ${TABLE}.claimpersonneltype_id ;;
    }

    dimension: dscr {
      type: string
      sql: ${TABLE}.dscr ;;
    }

    dimension: enabled {
      type: string
      sql: ${TABLE}.enabled ;;
    }

    dimension: initials {
      type: string
      sql: ${TABLE}.initials ;;
    }

    dimension: users_id {
      type: number
      sql: ${TABLE}.users_id ;;
    }

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension: claimadjustertype_id {
      type: number
      sql: ${TABLE}.claimadjustertype_id ;;
    }

    dimension_group: last_modified_date {
      type: time
      sql: ${TABLE}.last_modified_date ;;
    }

    dimension: claimoffice_id {
      type: number
      sql: ${TABLE}.claimoffice_id ;;
    }

    dimension: reports_to_claimpersonnel_id {
      type: number
      sql: ${TABLE}.reports_to_claimpersonnel_id ;;
    }

    dimension: out_of_office {
      type: string
      sql: ${TABLE}.out_of_office ;;
    }

    dimension: max_claims_per_month {
      type: number
      sql: ${TABLE}.max_claims_per_month ;;
    }

    dimension: max_claims_per_week {
      type: number
      sql: ${TABLE}.max_claims_per_week ;;
    }

    dimension: max_claims_per_day {
      type: number
      sql: ${TABLE}.max_claims_per_day ;;
    }

    dimension: week_days {
      type: number
      sql: ${TABLE}.week_days ;;
    }

    dimension_group: core_hours_end {
      type: time
      sql: ${TABLE}.core_hours_end ;;
    }

    dimension_group: core_hours_start {
      type: time
      sql: ${TABLE}.core_hours_start ;;
    }

    dimension: is_default_subro_adjuster {
      type: string
      sql: ${TABLE}.is_default_subro_adjuster ;;
    }

    dimension: policies {
      type: string
      sql: ${TABLE}.policies ;;
    }

    dimension: external_account_types {
      type: string
      sql: ${TABLE}.external_account_types ;;
    }

    dimension: out_of_office_end_date {
      type: date
      sql: ${TABLE}.out_of_office_end_date ;;
    }

    dimension: out_of_office_start_date {
      type: date
      sql: ${TABLE}.out_of_office_start_date ;;
    }

    dimension: out_of_office_date_range {
      type: string
      sql: ${TABLE}.out_of_office_date_range ;;
    }

    dimension: is_default_supervisor {
      type: string
      sql: ${TABLE}.is_default_supervisor ;;
    }

    set: detail {
      fields: [
        claimpersonnel_id,
        claimpersonneltype_id,
        dscr,
        enabled,
        initials,
        users_id,
        added_date,
        pcadded_date_time,
        claimadjustertype_id,
        last_modified_date_time,
        claimoffice_id,
        reports_to_claimpersonnel_id,
        out_of_office,
        max_claims_per_month,
        max_claims_per_week,
        max_claims_per_day,
        week_days,
        core_hours_end_time,
        core_hours_start_time,
        is_default_subro_adjuster,
        policies,
        external_account_types,
        out_of_office_end_date,
        out_of_office_start_date,
        out_of_office_date_range,
        is_default_supervisor
      ]
    }
  }

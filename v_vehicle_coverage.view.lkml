view: v_vehicle_coverage {
    sql_table_name: vvehiclecoverage
        ;;


    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: limitdscr {
      type: string
      sql: ${TABLE}.limitdscr ;;
    }

    dimension: covdscr {
      type: string
      sql: ${TABLE}.covdscr ;;
    }

    dimension: coverage_exposure_dscr {
      type: string
      sql: ${TABLE}.coverage_exposure_dscr ;;
    }

    dimension: data_type {
      type: string
      sql: ${TABLE}.data_type ;;
    }

    dimension: vehicle_num {
      type: number
      sql: ${TABLE}.vehicle_num ;;
    }

    dimension: coveragecodedatatype_id {
      type: number
      sql: ${TABLE}.coveragecodedatatype_id ;;
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: coverage_num {
      type: number
      sql: ${TABLE}.coverage_num ;;
    }

    dimension: eff_date {
      type: date
      sql: ${TABLE}.eff_date ;;
    }

    dimension: exp_date {
      type: date
      sql: ${TABLE}.exp_date ;;
    }

    dimension: premium_fullterm {
      type: string
      sql: ${TABLE}.premium_fullterm ;;
    }

    dimension: premium_written {
      type: string
      sql: ${TABLE}.premium_written ;;
    }

    dimension: premium_chg_written {
      type: string
      sql: ${TABLE}.premium_chg_written ;;
    }

    dimension: premium_prev_chg_written {
      type: string
      sql: ${TABLE}.premium_prev_chg_written ;;
    }

    dimension: premium_diff_chg_written {
      type: string
      sql: ${TABLE}.premium_diff_chg_written ;;
    }

    dimension: coveragecode_id {
      type: number
      sql: ${TABLE}.coveragecode_id ;;
    }

    dimension: coveragelimit_id {
      type: number
      sql: ${TABLE}.coveragelimit_id ;;
    }

    dimension: manuallimitamount {
      type: string
      sql: ${TABLE}.manuallimitamount ;;
    }

    dimension: calc {
      type: string
      sql: ${TABLE}.calc ;;
    }

    dimension: checkbox {
      type: string
      sql: ${TABLE}.checkbox ;;
    }

    dimension_group: manualdate {
      type: time
      sql: ${TABLE}.manualdate ;;
    }

    dimension: packagepart_num {
      type: number
      sql: ${TABLE}.packagepart_num ;;
    }

    set: detail {
      fields: [
        limitdscr,
        covdscr,
        coverage_exposure_dscr,
        data_type,
        vehicle_num,
        coveragecodedatatype_id,
        policy_id,
        policyimage_num,
        coverage_num,
        eff_date,
        exp_date,
        premium_fullterm,
        premium_written,
        premium_chg_written,
        premium_prev_chg_written,
        premium_diff_chg_written,
        coveragecode_id,
        coveragelimit_id,
        manuallimitamount,
        calc,
        checkbox,
        manualdate_time,
        packagepart_num
      ]
    }
  }

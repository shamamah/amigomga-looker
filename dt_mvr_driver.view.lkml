view: dt_mvr_driver {
  derived_table: {
    sql: select p.policy_id, p.policyimage_num, p.renewal_ver
        --into  #pols
        from policyimage p
        join driver d ON p.policy_id = d.policy_id
        and p.policyimage_num = d.policyimage_num
        and d.driverexcludetype_id = 1 -- Rated
        join drivernamelink dal ON dal.policy_id = d.policy_id
        and dal.policyimage_num = d.policyimage_num
        and dal.driver_num = d.driver_num
        join name n ON n.name_id = dal.name_id
        and dlstate_id < 52
        left join (SELECT xt.policy_id, driver_num, policy, xt.request_id, sent_date, xt.dln
               FROM [dbo].[IIXTransmission] xt
                JOIN [dbo].[DriverIIXTransmissionLink] pt ON pt.request_id = xt.request_id
                join dbo.Policyimage p ON xt.policy_id = p.policy_id
                    and xt.policyimage_num = p.policyimage_num
                    and p.transtype_id = 2
                --and eff_date between '2020-04-23' and '2020-11-30 23:59:59'
                where p.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
            ) x on x.policy_id = d.policy_id
              and x.driver_num = d.driver_num
        where
              p.transtype_id = 2 -- NB
              and p.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
              and x.policy is null
       ;;
  }

  measure: count {
    type: count
  }

  dimension: policy_id {
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: renewal_ver {
    type: number
    sql: ${TABLE}.renewal_ver ;;
  }

  # dimension: eff_date {
  #   type: date
  #   sql: ${TABLE}.eff_date ;;
  # }

  # dimension: driver_num {
  #   type: number
  #   sql: ${TABLE}.driver_num ;;
  # }

  # dimension: dlstate_id {
  #   type: number
  #   sql: ${TABLE}.dlstate_id ;;
  # }

  # set: detail {
  #   fields: [
  #     policy_id,
  #     policyimage_num,
  #     transtype_id,
  #     eff_date,
  #     driver_num,
  #     dlstate_id
  #   ]
  # }
}

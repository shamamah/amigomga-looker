view: v_claim_detail_claimant {

  sql_table_name: dbo.vClaimDetail_Claimant ;;
  view_label: "Claimant"

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},${claimant_num}) ;;
  }

  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    label: "Number"
    type: number
    hidden: yes
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: name {
    label: "Name (WS)"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: display_name {
    type: string
    label: "Name"
    sql: ${TABLE}.display_name ;;
  }

  dimension: city_state {
    label: "City, State"
    view_label: "Claimant Address"
    type: string
    sql: ${TABLE}.city_state ;;
  }

  dimension: display_address {
    type: string
    label: "Address"
    view_label: "Claimant Address"
    sql: ${TABLE}.display_address ;;
  }

  dimension: city {
    view_label: "Claimant Address"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    view_label: "Claimant Address"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: in_litigation {
    hidden: yes
    type: string
    label: "Is Litigated"
    sql: case when ${TABLE}.in_litigation=1 then 'Yes' else 'No' end ;;
  }

  dimension: claimanttypedscr {
    type: string
    label: "Type"
    sql: ${TABLE}.claimanttypedscr ;;
  }

  dimension: claimanttypecode {
    type: string
    hidden: yes
    sql: ${TABLE}.claimanttypecode ;;
  }

  dimension: relationshiptypedscr {
    type: string
    label: "Relationship"
    sql: ${TABLE}.relationshiptypedscr ;;
  }

  dimension: relationshiptypecode {
    hidden: yes
    type: string
    sql: ${TABLE}.relationshiptypecode ;;
  }

  dimension: status_dscr {
    label: "Status"
    type: string
    sql: ${TABLE}.status_dscr ;;
  }

  dimension: is_represented {
    hidden: yes
    type: string
    label: "Is Represented"
    sql: case when ${TABLE}.is_represented=1 then 'Yes' else 'No' end ;;
  }

  dimension: is_litigated_represented {
    type: string
    label: "Is Litigated/Represented"
    sql: case when (${is_represented} = 'Yes' OR ${in_litigation} = 'Yes') then 'Yes' else 'No' end ;;
  }

  measure: count {
    type: count
    drill_fields: [claimant_stats*]
  }

  measure: litigated_represented_count {
    label: "Represented Count"
    type: count
    drill_fields: [claimant_stats*]
    filters: {
      field: is_litigated_represented
      value: "Yes"
    }
  }

  set: claimant_stats {
    fields: [
      claim_control.claim_number,
      policy.current_policy,
      claimant_num,
      name,
      relationshiptypedscr,
      status_dscr,
      claimanttypedscr,
      display_address,
      city_state
    ]
  }
}

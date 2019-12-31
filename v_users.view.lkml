view: v_users {
  sql_table_name: dbo.vUsers ;;

  dimension: users_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.users_id ;;
  }

  dimension: acd_adjuster_code {
    hidden: yes
    type: string
    sql: ${TABLE}.acd_adjuster_code ;;
  }

  dimension: active {
    hidden: yes
    type: string
    sql: ${TABLE}.active ;;
  }

  dimension_group: added {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.added_date ;;
  }

  dimension: associate_user_with_all_agencies {
    hidden: yes
    type: string
    sql: ${TABLE}.associate_user_with_all_agencies ;;
  }

  dimension: claimsdashboardtemplate_id {
    hidden: yes
    type: number
    sql: ${TABLE}.claimsdashboardtemplate_id ;;
  }

  dimension: display_name {
    label: "User Name"
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: failed_login_attempt_count {
    hidden: yes
    type: number
    sql: ${TABLE}.failed_login_attempt_count ;;
  }

  dimension: initials {
    hidden: yes
    type: string
    sql: ${TABLE}.initials ;;
  }

  dimension: is_external_user {
    hidden: yes
    type: string
    sql: ${TABLE}.is_external_user ;;
  }

  dimension: is_locked {
    hidden: yes
    type: string
    sql: ${TABLE}.is_locked ;;
  }

  dimension_group: last_failed_login {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_failed_login_date ;;
  }

  dimension_group: last_modified {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension: last_name {
    hidden: yes
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension_group: last_successful_login {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_successful_login_date ;;
  }

  dimension: login_domain {
    hidden: yes
    type: string
    sql: ${TABLE}.login_domain ;;
  }

  dimension: login_name {
    hidden: yes
    type: string
    sql: ${TABLE}.login_name ;;
  }

  dimension: mitchell_adjuster_code {
    hidden: yes
    type: string
    sql: ${TABLE}.mitchell_adjuster_code ;;
  }

  dimension: name_id {
    hidden: yes
    type: number
    sql: ${TABLE}.name_id ;;
  }

  dimension: notifyuw {
    hidden: yes
    type: string
    sql: ${TABLE}.notifyuw ;;
  }

  dimension: password {
    hidden: yes
    type: string
    sql: ${TABLE}.password ;;
  }

  dimension_group: password_expires {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.password_expires_date ;;
  }

  dimension: password_must_be_changed {
    hidden: yes
    type: string
    sql: ${TABLE}.password_must_be_changed ;;
  }

  dimension: password_never_expires {
    hidden: yes
    type: string
    sql: ${TABLE}.password_never_expires ;;
  }

  dimension: password_salt {
    hidden: yes
    type: string
    sql: ${TABLE}.password_salt ;;
  }

  dimension: passwordhashtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.passwordhashtype_id ;;
  }

  dimension_group: pcadded {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pcadded_date ;;
  }

  dimension: suid {
    hidden: yes
    type: string
    sql: ${TABLE}.suid ;;
  }

  dimension: supervisor {
    hidden: yes
    type: string
    sql: ${TABLE}.supervisor ;;
  }

  dimension: use_claimsdashboard_as_startup {
    hidden: yes
    type: string
    sql: ${TABLE}.use_claimsdashboard_as_startup ;;
  }

  dimension: user_code {
    hidden: yes
    type: string
    sql: ${TABLE}.user_code ;;
  }

  dimension: user_emailaddr {
    hidden: yes
    type: string
    sql: ${TABLE}.user_emailaddr ;;
  }

  dimension: usercategory_id {
    hidden: yes
    type: number
    sql: ${TABLE}.usercategory_id ;;
  }

  dimension: xactware_user_identifier {
    hidden: yes
    type: string
    sql: ${TABLE}.xactware_user_identifier ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [display_name, login_name, last_name]
  }
}

view: driver_name {
  sql_table_name: dbo.Name ;;

  dimension: name_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.name_id ;;
  }

  dimension: active_military {
    hidden: yes
    type: string
    sql: ${TABLE}.active_military ;;
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

  dimension: age {
    label: "Age"
    type: number
    sql: DATEDIFF(year, ${birth_date}, GETDATE()) ;;
  }

  dimension: best_contact_time_details {
    hidden: yes
    type: string
    sql: ${TABLE}.best_contact_time_details ;;
  }

  dimension_group: birth {
    label: "Birth"
    type: time
    timeframes: [date,year]
    sql: ${TABLE}.birth_date ;;
  }

  dimension: commercial_name1 {
    hidden: yes
    type: string
    sql: ${TABLE}.commercial_name1 ;;
  }

  dimension: commercial_name2 {
    hidden: yes
    type: string
    sql: ${TABLE}.commercial_name2 ;;
  }

  dimension: commercialweb {
    hidden: yes
    type: string
    sql: ${TABLE}.commercialweb ;;
  }

  dimension: contactreasontype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.contactreasontype_id ;;
  }

  dimension: customer_encrypted_taxnum {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_encrypted_taxnum ;;
  }

  dimension_group: date_business_started {
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
    sql: ${TABLE}.date_business_started ;;
  }

  dimension: description_of_operations {
    hidden: yes
    type: string
    sql: ${TABLE}.description_of_operations ;;
  }

  dimension: detailstatuscode_id {
    hidden: yes
    type: number
    sql: ${TABLE}.detailstatuscode_id ;;
  }

  dimension: display_name {
    label: "Display Name"
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: dln {
    hidden: yes
    type: string
    sql: ${TABLE}.dln ;;
  }

  dimension_group: dln {
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
    sql: ${TABLE}.dln_date ;;
  }

  dimension: dlstate_id {
    hidden: yes
    type: number
    sql: ${TABLE}.dlstate_id ;;
  }

  dimension: doing_business_as {
    hidden: yes
    type: string
    sql: ${TABLE}.doing_business_as ;;
  }

  dimension: entitytype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.entitytype_id ;;
  }

  dimension: first_name {
    hidden: yes
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: has_no_email_address {
    hidden: yes
    type: string
    sql: ${TABLE}.has_no_email_address ;;
  }

  dimension: health_insurance_claim_number {
    hidden: yes
    type: string
    sql: ${TABLE}.health_insurance_claim_number ;;
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

  dimension: lexis_nexis_identifier {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.lexis_nexis_identifier ;;
  }

  dimension: maritalstatus_id {
    hidden: yes
    type: number
    sql: ${TABLE}.maritalstatus_id ;;
  }

  dimension: middle_name {
    hidden: yes
    type: string
    sql: ${TABLE}.middle_name ;;
  }

  dimension: naics_code {
    hidden: yes
    type: string
    sql: ${TABLE}.naics_code ;;
  }

  dimension: name_display_num {
    hidden: yes
    type: number
    sql: ${TABLE}.name_display_num ;;
  }

  dimension: name_num {
    hidden: yes
    type: number
    sql: ${TABLE}.name_num ;;
  }

  dimension: nameaddresssource_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nameaddresssource_id ;;
  }

  dimension: nametype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nametype_id ;;
  }

  dimension: okay_to_call {
    label: "Okay to Call (Y/N)"
    type: string
    sql: case when ${TABLE}.okay_to_call='true' then 'Yes' else 'No' end ;;
  }

  dimension: okay_to_email {
    label: "Okay to E-Mail (Y/N)"
    type: string
    sql: case when ${TABLE}.okay_to_email='true' then 'Yes' else 'No' end ;;
  }

  dimension: okay_to_text {
    label: "Okay to Text Message (Y/N)"
    type: string
    sql: case when ${TABLE}.okay_to_text='true' then 'Yes' else 'No' end ;;
  }

  dimension: other_legal_entity_description {
    hidden: yes
    type: string
    sql: ${TABLE}.other_legal_entity_description ;;
  }

  dimension: packagepart_num {
    hidden: yes
    type: number
    sql: ${TABLE}.packagepart_num ;;
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

  dimension: policy_id {
    hidden: yes
    type: number
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    hidden: yes
    type: number
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension: position_title {
    type: string
    sql: ${TABLE}.position_title ;;
  }

  dimension: prefix_name {
    hidden: yes
    type: string
    sql: ${TABLE}.prefix_name ;;
  }

  dimension: riskgradelookup_id {
    hidden: yes
    type: number
    sql: ${TABLE}.riskgradelookup_id ;;
  }

  dimension: salutation {
    hidden: yes
    type: string
    sql: ${TABLE}.salutation ;;
  }

  dimension: sex_id {
    hidden: yes
    type: number
    sql: ${TABLE}.sex_id ;;
  }

  dimension: sic_code {
    hidden: yes
    type: string
    sql: ${TABLE}.sic_code ;;
  }

  dimension: sort_name {
    hidden: yes
    type: string
    sql: ${TABLE}.sort_name ;;
  }

  dimension: suffix_name {
    hidden: yes
    type: string
    sql: ${TABLE}.suffix_name ;;
  }

  dimension: taxnum {
    hidden: yes
    type: string
    sql: ${TABLE}.taxnum ;;
  }

  dimension: taxtype_id {
    hidden: yes
    type: number
    sql: ${TABLE}.taxtype_id ;;
  }

  dimension: thirdparty_entity_id {
    hidden: yes
    type: number
    sql: ${TABLE}.thirdparty_entity_id ;;
  }

  dimension: thirdparty_group_id {
    hidden: yes
    type: number
    sql: ${TABLE}.thirdparty_group_id ;;
  }

  dimension: vendor_birth_date_changed {
    hidden: yes
    type: string
    sql: ${TABLE}.vendor_birth_date_changed ;;
  }

  dimension: vendor_dln_changed {
    hidden: yes
    type: string
    sql: ${TABLE}.vendor_dln_changed ;;
  }

  dimension: vendor_taxnum_changed {
    hidden: yes
    type: string
    sql: ${TABLE}.vendor_taxnum_changed ;;
  }

  dimension: years_experience {
    hidden: yes
    type: number
    sql: ${TABLE}.years_experience ;;
  }

  measure: count {
    hidden: yes
    type: count
  }

}

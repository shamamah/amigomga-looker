view: name {
  sql_table_name: name;;


    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: name_id {
      type: number
      sql: ${TABLE}.name_id ;;
    }

    dimension: name_num {
      type: number
      sql: ${TABLE}.name_num ;;
    }

    dimension: nametype_id {
      type: number
      sql: ${TABLE}.nametype_id ;;
    }

    dimension: nameaddresssource_id {
      type: number
      sql: ${TABLE}.nameaddresssource_id ;;
    }

    dimension: policy_id {
      type: number
      sql: ${TABLE}.policy_id ;;
    }

    dimension: policyimage_num {
      type: number
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: display_name {
      type: string
      sql: ${TABLE}.display_name ;;
    }

    dimension: sort_name {
      type: string
      sql: ${TABLE}.sort_name ;;
    }

    dimension: taxtype_id {
      type: number
      sql: ${TABLE}.taxtype_id ;;
    }

    dimension: taxnum {
      type: string
      sql: ${TABLE}.taxnum ;;
    }

    dimension: prefix_name {
      type: string
      sql: ${TABLE}.prefix_name ;;
    }

    dimension: first_name {
      type: string
      sql: ${TABLE}.first_name ;;
    }

    dimension: middle_name {
      type: string
      sql: ${TABLE}.middle_name ;;
    }

    dimension: last_name {
      type: string
      sql: ${TABLE}.last_name ;;
    }

    dimension: suffix_name {
      type: string
      sql: ${TABLE}.suffix_name ;;
    }

    dimension: sex_id {
      type: number
      sql: ${TABLE}.sex_id ;;
    }

    dimension: dln {
      type: string
      sql: ${TABLE}.dln ;;
    }

    dimension: dlstate_id {
      type: number
      sql: ${TABLE}.dlstate_id ;;
    }

    dimension_group: dln_date {
      type: time
      sql: ${TABLE}.dln_date ;;
    }

    dimension: salutation {
      type: string
      sql: ${TABLE}.salutation ;;
    }

    dimension: position_title {
      type: string
      sql: ${TABLE}.position_title ;;
    }

    dimension_group: birth_date {
      type: time
      sql: ${TABLE}.birth_date ;;
    }

    dimension: maritalstatus_id {
      type: number
      sql: ${TABLE}.maritalstatus_id ;;
    }

    dimension: commercial_name1 {
      type: string
      sql: ${TABLE}.commercial_name1 ;;
    }

    dimension: commercial_name2 {
      type: string
      sql: ${TABLE}.commercial_name2 ;;
    }

    dimension: commercialweb {
      type: string
      sql: ${TABLE}.commercialweb ;;
    }

    dimension: detailstatuscode_id {
      type: number
      sql: ${TABLE}.detailstatuscode_id ;;
    }

    dimension: added_date {
      type: date
      sql: ${TABLE}.added_date ;;
    }

    dimension_group: pcadded_date {
      type: time
      sql: ${TABLE}.pcadded_date ;;
    }

    dimension: thirdparty_entity_id {
      type: number
      sql: ${TABLE}.thirdparty_entity_id ;;
    }

    dimension: thirdparty_group_id {
      type: number
      sql: ${TABLE}.thirdparty_group_id ;;
    }

    dimension: name_display_num {
      type: number
      sql: ${TABLE}.name_display_num ;;
    }

    dimension: customer_encrypted_taxnum {
      type: string
      sql: ${TABLE}.customer_encrypted_taxnum ;;
    }

    dimension: health_insurance_claim_number {
      type: string
      sql: ${TABLE}.health_insurance_claim_number ;;
    }

    dimension_group: last_modified_date {
      type: time
      sql: ${TABLE}.last_modified_date ;;
    }

    dimension: description_of_operations {
      type: string
      sql: ${TABLE}.description_of_operations ;;
    }

    dimension: entitytype_id {
      type: number
      sql: ${TABLE}.entitytype_id ;;
    }

    dimension: doing_business_as {
      type: string
      sql: ${TABLE}.doing_business_as ;;
    }

    dimension: contactreasontype_id {
      type: number
      sql: ${TABLE}.contactreasontype_id ;;
    }

    dimension: naics_code {
      type: string
      sql: ${TABLE}.naics_code ;;
    }

    dimension: other_legal_entity_description {
      type: string
      sql: ${TABLE}.other_legal_entity_description ;;
    }

    dimension: packagepart_num {
      type: number
      sql: ${TABLE}.packagepart_num ;;
    }

    dimension: riskgradelookup_id {
      type: number
      sql: ${TABLE}.riskgradelookup_id ;;
    }

    dimension: sic_code {
      type: string
      sql: ${TABLE}.sic_code ;;
    }

    dimension: vendor_taxnum_changed {
      type: string
      sql: ${TABLE}.vendor_taxnum_changed ;;
    }

    dimension: vendor_dln_changed {
      type: string
      sql: ${TABLE}.vendor_dln_changed ;;
    }

    dimension: vendor_birth_date_changed {
      type: string
      sql: ${TABLE}.vendor_birth_date_changed ;;
    }

    dimension: active_military {
      type: string
      sql: ${TABLE}.active_military ;;
    }

    dimension: okay_to_text {
      type: string
      sql: ${TABLE}.okay_to_text ;;
    }

    dimension: okay_to_email {
      type: string
      sql: ${TABLE}.okay_to_email ;;
    }

    dimension: okay_to_call {
      type: string
      sql: ${TABLE}.okay_to_call ;;
    }

    dimension: best_contact_time_details {
      type: string
      sql: ${TABLE}.best_contact_time_details ;;
    }

    dimension: years_experience {
      type: number
      sql: ${TABLE}.years_experience ;;
    }

    dimension: date_business_started {
      type: date
      sql: ${TABLE}.date_business_started ;;
    }

    dimension: lexis_nexis_identifier {
      type: string
      sql: ${TABLE}.lexis_nexis_identifier ;;
    }

    dimension: has_no_email_address {
      type: string
      sql: ${TABLE}.has_no_email_address ;;
    }

    set: detail {
      fields: [
        name_id,
        name_num,
        nametype_id,
        nameaddresssource_id,
        policy_id,
        policyimage_num,
        display_name,
        sort_name,
        taxtype_id,
        taxnum,
        prefix_name,
        first_name,
        middle_name,
        last_name,
        suffix_name,
        sex_id,
        dln,
        dlstate_id,
        dln_date_time,
        salutation,
        position_title,
        birth_date_time,
        maritalstatus_id,
        commercial_name1,
        commercial_name2,
        commercialweb,
        detailstatuscode_id,
        added_date,
        pcadded_date_time,
        thirdparty_entity_id,
        thirdparty_group_id,
        name_display_num,
        customer_encrypted_taxnum,
        health_insurance_claim_number,
        last_modified_date_time,
        description_of_operations,
        entitytype_id,
        doing_business_as,
        contactreasontype_id,
        naics_code,
        other_legal_entity_description,
        packagepart_num,
        riskgradelookup_id,
        sic_code,
        vendor_taxnum_changed,
        vendor_dln_changed,
        vendor_birth_date_changed,
        active_military,
        okay_to_text,
        okay_to_email,
        okay_to_call,
        best_contact_time_details,
        years_experience,
        date_business_started,
        lexis_nexis_identifier,
        has_no_email_address
      ]
    }
  }

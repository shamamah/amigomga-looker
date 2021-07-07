view: dt_policy_attachment {
  derived_table: {
  sql: Select policy,
        pim.policy_id,  pim.policyimage_num, a.eff_date,
        a.filename, a.statuscode_id, a.is_esign, ar.dscr as Originator, aat.dscr
      FROM policyimage pim
      join PolicyImageAttachmentLink pial ON pial.policy_id = pim.policy_id
        and pial.policyimage_num = pim.policyimage_num
      Join [ProductionBackup].[dbo].[Attachment] a
        ON a.attachment_id = pial.attachment_id
        left join attachmenttype aat ON aat.attachmenttype_id = a.attachmenttype_id
        left join OriginationType ar ON ar.originationtype_id = a.originationtype_id
       ;;
}

  dimension: view_primary  {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${policy_id}, ' ', ${policyimage_num}, ' ', ${filename}) ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: policy {
    type: string
    hidden: yes
    sql: ${TABLE}.policy ;;
  }

  dimension: policy_id {
    type: number
    hidden: yes
    sql: ${TABLE}.policy_id ;;
  }

  dimension: policyimage_num {
    type: number
    hidden: yes
    sql: ${TABLE}.policyimage_num ;;
  }

  dimension_group: eff_date {
    type: time
    # hidden: yes
    sql: ${TABLE}.eff_date ;;
  }

  dimension: filename {
    type: string
    sql: ${TABLE}.filename ;;
  }

  dimension: originator {
    type: string
    sql: ${TABLE}.Originator ;;
  }

  dimension: dscr {
    label: "Attachment Type"
    type: string
    sql: ${TABLE}.dscr ;;
  }

  dimension: statuscode_id {
    label: "Image Status Id"
    type: number
    sql: ${TABLE}.statuscode_id ;;
  }

  dimension: is_esign_dim {
    label: "esign doc"
    type: string
    sql: CASE WHEN ${TABLE}.is_esign = 1 THEN 'Yes' ELSE 'No' END;;
  }


  measure: is_esign {
    label: "ESign Doc Count"
    type: sum
    sql: ${TABLE}.is_esign;;
  }


  set: detail {
    fields: [
      policy,
      eff_date_time,
      filename,
      statuscode_id
    ]
  }

}

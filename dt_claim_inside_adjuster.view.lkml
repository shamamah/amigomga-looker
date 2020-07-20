view: dt_claim_inside_adjuster {
  derived_table: {
    sql:

    select cc.claimcontrol_id, cc.claim_number
        ,cp.[enabled] as Is_Claim_Personnel_Enabled, cp.initials, cp.claimoffice_id
        ,cpt.claimpersonneltype_id as claim_personnel_type_id, cpt.dscr as ClaimPersonnelType_dscr
        ,cat.claimadjustertype_id as claim_adjuster_type_id, cat.dscr as ClaimAdjusterType_dscr, cat.[enabled] as Is_Adjuster_Enabled
        ,u.display_name as Adjuster_Name
        ,u.active as Active

    from ClaimControlPersonnel ccp
        inner join ClaimControl cc on cc.claimcontrol_id = ccp.claimcontrol_id
        inner join ClaimPersonnel cp on cp.claimpersonnel_id = ccp.claimpersonnel_id
        inner join ClaimPersonnelType cpt on cpt.claimpersonneltype_id = ccp.claimpersonneltype_id
        inner join ClaimAdjusterType cat on cat.claimadjustertype_id = ccp.claimadjustertype_id
        inner join vUsers u on u.users_id = cp.users_id

    where ccp.claimpersonnel_id <> 0
        and cat.[enabled] <> 0
        and cpt.claimpersonneltype_id = 3
        and cat.claimadjustertype_id = 1  ;;
  }

  dimension: claimcontrol_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: initials {
    label: "Adjuster Initials"
    type: string
    sql: case when ${TABLE}.initials IS NULL then '--' else ${TABLE}.initials end ;;
  }

  dimension: adjuster_name {
    label: "Adjuster"
    type: string
    sql: case when ${TABLE}.Adjuster_Name IS NULL then 'Unassigned' else ${TABLE}.Adjuster_Name end ;;
  }

  dimension: active {
    label: "Adjuster Active (Yes/No)"
    type: string
    sql: case when ${TABLE}.Active=1 then 'Yes' else (case when ${TABLE}.Active=0 then 'No' else 'N/A' end) end ;;
  }
}

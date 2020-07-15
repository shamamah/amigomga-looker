view: dt_garaging_territory_zip {
  derived_table: {
      sql: Select
        PIM.Policy, PIM.policy_id, PIM.policyimage_num,
        COALESCE(t1.territory_num,t2.territory_num,t3.territory_num) as Territory_num,
        --t2.territory_num,
        COALESCE(t1.zip,t2.zip) as Zip
      FROM PolicyImage PIM
      --  CHECK TO SEE IF THERE Vehicle zip
      left JOIN (Select a.policy_id, a.policyimage_num, a.zip, t.version_id, t.territory_num territory_num
              from dbo.Address A
            Join (Select policy_id, policyimage_num, max(address_id) maxadid from dbo.Address
                group by policy_id, policyimage_num) py
                ON py.policy_id = a.policy_id
                AND py.policyimage_num = a.policyimage_num
                and py.maxadid = a.address_id
             left JOIN (select zip, version_id, MAX(Territory_num) Territory_num from [Territory]
                group by zip, version_id) T
              ON t.zip = Left(a.zip, 5)
            where A.nameaddresssource_id = 17
            ) T1
          ON T1.policy_id = PIM.policy_id
          AND T1.policyimage_num = PIM.policyimage_num
          AND T1.Version_id = CASE WHEN PIM.Version_id = 2 THEN 1 ELSE PIM.Version_id END


      -- CHECK TO SEE IF THERE IS POLICY ZIP to get Territory
      left JOIN dbo.POlicyImageAddressLink PIAL WITH (NOLOCK)
        ON PIAL.Policy_id = PIM.policy_id
        AND PIAL.policyimage_num = PIM.policyimage_num
          And PIAL.nameaddresssource_id = 3
      left JOIN dbo.Address A2 WITH (NOLOCK)
        ON a2.address_id = pial.address_id
      left JOIN (select zip, version_id, MAX(Territory_num) Territory_num from [Territory]
                group by zip, version_id) T2
        ON t2.zip = Left(a2.zip, 5)
        AND T2.Version_id = CASE WHEN PIM.Version_id = 2 THEN 1 ELSE PIM.Version_id END

      -- USE TOWN Name as LAST RESORT for Terriroty
      left join (Select distinct x.city, x.version_id, territory_num from [Territory] x
            join (select city, CASE WHEN Version_id = 2 THEN 1 ELSE Version_id END as Version_id, max(territory_num) maxtm
                from [Territory]
                group by city, CASE WHEN Version_id = 2 THEN 1 ELSE Version_id END) z
              ON x.city = z.city
              and  x.territory_num = z.maxtm
              and x.version_id = z.version_id
            ) T3
          ON t3.city = a2.city
          AND t3.version_id = CASE WHEN PIM.Version_id = 2 THEN 1 ELSE PIM.Version_id END
      where PIM.policystatuscode_id NOT IN (4, 5, 7, 8, 12, 13, 14)
       ;;
    }

    dimension: policy_id {
      hidden: yes
      type: number
      sql: ${TABLE}.policy_id ;;
    }

    dimension: garagekey {
      hidden: yes
      primary_key: yes
      type: number
      sql: CONCAT(${TABLE}.policy_id,' ', ${TABLE}.policyimage_num);;
    }

    dimension: policyimage_num {
      hidden: yes
      type: number
      sql: ${TABLE}.policyimage_num ;;
    }

    dimension: territory_num {
      type: number
      sql: ${TABLE}.Territory_num ;;
    }

    dimension: zip {
      type: string
      sql: ${TABLE}.Zip ;;
    }

  }

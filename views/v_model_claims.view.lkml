view: v_model_claims {
  sql_table_name: rpt.vModel_Claims ;;

  dimension: claim_number {
    type: string
    sql: ${TABLE}.ClaimNumber ;;
  }

  dimension: claimant_name {
    type: string
    sql: ${TABLE}.ClaimantName ;;
  }

  dimension: claimant_num {
    type: number
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimcontrol_id {
    type: number
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimfeature_num {
    type: number
    sql: ${TABLE}.claimfeature_num ;;
  }

  dimension: coverage {
    type: string
    sql: ${TABLE}.Coverage ;;
  }

  dimension: itd_alaepaid {
    type: string
    sql: ${TABLE}.ITD_ALAEPaid ;;
  }

  dimension: itd_alaereserve {
    type: string
    sql: ${TABLE}.ITD_ALAEReserve ;;
  }

  dimension: itd_ant_rein_expense_recovery {
    type: string
    sql: ${TABLE}.ITD_AntReinExpenseRecovery ;;
  }

  dimension: itd_ant_rein_loss_recovery {
    type: string
    sql: ${TABLE}.ITD_AntReinLossRecovery ;;
  }

  dimension: itd_ant_salvage {
    type: string
    sql: ${TABLE}.ITD_AntSalvage ;;
  }

  dimension: itd_ant_subro {
    type: string
    sql: ${TABLE}.ITD_AntSubro ;;
  }

  dimension: itd_loss_paid {
    type: string
    sql: ${TABLE}.ITD_LossPaid ;;
  }

  dimension: itd_loss_resrve {
    type: string
    sql: ${TABLE}.ITD_LossResrve ;;
  }

  dimension: itd_rein_expense_recovery {
    type: string
    sql: ${TABLE}.ITD_ReinExpenseRecovery ;;
  }

  dimension: itd_rein_loss_recovery {
    type: string
    sql: ${TABLE}.ITD_ReinLossRecovery ;;
  }

  dimension: itd_salvage {
    type: string
    sql: ${TABLE}.ITD_Salvage ;;
  }

  dimension: itd_subro {
    type: string
    sql: ${TABLE}.ITD_Subro ;;
  }

  dimension: itd_ulaepaid {
    type: string
    sql: ${TABLE}.ITD_ULAEPaid ;;
  }

  dimension: itd_ulaereserve {
    type: string
    sql: ${TABLE}.ITD_ULAEReserve ;;
  }

  dimension_group: loss {
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
    sql: ${TABLE}.LossDate ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.Month ;;
  }

  dimension: mtd_alaepaid {
    type: string
    sql: ${TABLE}.MTD_ALAEPaid ;;
  }

  dimension: mtd_alaereserve {
    type: string
    sql: ${TABLE}.MTD_ALAEReserve ;;
  }

  dimension: mtd_ant_rein_expense_recovery {
    type: string
    sql: ${TABLE}.MTD_AntReinExpenseRecovery ;;
  }

  dimension: mtd_ant_rein_loss_recovery {
    type: string
    sql: ${TABLE}.MTD_AntReinLossRecovery ;;
  }

  dimension: mtd_ant_salvage {
    type: string
    sql: ${TABLE}.MTD_AntSalvage ;;
  }

  dimension: mtd_ant_subro {
    type: string
    sql: ${TABLE}.MTD_AntSubro ;;
  }

  dimension: mtd_loss_paid {
    type: string
    sql: ${TABLE}.MTD_LossPaid ;;
  }

  dimension: mtd_loss_resrve {
    type: string
    sql: ${TABLE}.MTD_LossResrve ;;
  }

  dimension: mtd_rein_expense_recovery {
    type: string
    sql: ${TABLE}.MTD_ReinExpenseRecovery ;;
  }

  dimension: mtd_rein_loss_recovery {
    type: string
    sql: ${TABLE}.MTD_ReinLossRecovery ;;
  }

  dimension: mtd_salvage {
    type: string
    sql: ${TABLE}.MTD_Salvage ;;
  }

  dimension: mtd_subro {
    type: string
    sql: ${TABLE}.MTD_Subro ;;
  }

  dimension: mtd_ulaepaid {
    type: string
    sql: ${TABLE}.MTD_ULAEPaid ;;
  }

  dimension: mtd_ulaereserve {
    type: string
    sql: ${TABLE}.MTD_ULAEReserve ;;
  }

  dimension: policy_number {
    type: string
    sql: ${TABLE}.PolicyNumber ;;
  }

  dimension_group: reported {
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
    sql: ${TABLE}.ReportedDate ;;
  }

  dimension: sub_coverage {
    type: string
    sql: ${TABLE}.SubCoverage ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  dimension: ytd_alaepaid {
    type: string
    sql: ${TABLE}.YTD_ALAEPaid ;;
  }

  dimension: ytd_alaereserve {
    type: string
    sql: ${TABLE}.YTD_ALAEReserve ;;
  }

  dimension: ytd_ant_rein_expense_recovery {
    type: string
    sql: ${TABLE}.YTD_AntReinExpenseRecovery ;;
  }

  dimension: ytd_ant_rein_loss_recovery {
    type: string
    sql: ${TABLE}.YTD_AntReinLossRecovery ;;
  }

  dimension: ytd_ant_salvage {
    type: string
    sql: ${TABLE}.YTD_AntSalvage ;;
  }

  dimension: ytd_ant_subro {
    type: string
    sql: ${TABLE}.YTD_AntSubro ;;
  }

  dimension: ytd_loss_paid {
    type: string
    sql: ${TABLE}.YTD_LossPaid ;;
  }

  dimension: ytd_loss_resrve {
    type: string
    sql: ${TABLE}.YTD_LossResrve ;;
  }

  dimension: ytd_rein_expense_recovery {
    type: string
    sql: ${TABLE}.YTD_ReinExpenseRecovery ;;
  }

  dimension: ytd_rein_loss_recovery {
    type: string
    sql: ${TABLE}.YTD_ReinLossRecovery ;;
  }

  dimension: ytd_salvage {
    type: string
    sql: ${TABLE}.YTD_Salvage ;;
  }

  dimension: ytd_subro {
    type: string
    sql: ${TABLE}.YTD_Subro ;;
  }

  dimension: ytd_ulaepaid {
    type: string
    sql: ${TABLE}.YTD_ULAEPaid ;;
  }

  dimension: ytd_ulaereserve {
    type: string
    sql: ${TABLE}.YTD_ULAEReserve ;;
  }

  measure: count {
    type: count
    drill_fields: [claimant_name]
  }
}

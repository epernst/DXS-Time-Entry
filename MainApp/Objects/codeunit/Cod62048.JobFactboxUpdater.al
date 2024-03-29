codeunit 62048 "DXS.Job Factbox Updater"
{
    procedure UpdateJobJurnalData(
        JobJournalLine: Record "Job Journal Line";
        var BillableHours: array[5] of Decimal;
        var NonBillableHours: array[5] of Decimal;
        var TotalSales: array[5] of Decimal;
        var TotalCost: array[5] of Decimal;
        var TotalProfit: array[5] of Decimal;
        var AvgPricePerUOM: array[5] of Decimal);
    var
        JobFactboxCalculation: Codeunit "DXS.Job Factbox Calculator";
        ViewType: Option CurrentJobJournal,JobLedgerEntry,TotalJobJournal;
    begin
        JobFactboxCalculation.CalcJobJnlFactBoxData(
            JobJournalLine,
            ViewType::CurrentJobJournal,
            BillableHours[1],
            NonBillableHours[1],
            TotalSales[1],
            TotalCost[1],
            TotalProfit[1],
            AvgPricePerUOM[1]);
        JobFactboxCalculation.CalcJobJnlFactBoxData(
            JobJournalLine,
            ViewType::JobLedgerEntry,
            BillableHours[2],
            NonBillableHours[2],
            TotalSales[2],
            TotalCost[2],
            TotalProfit[2],
            AvgPricePerUOM[2]);
        JobFactboxCalculation.CalcJobJnlFactBoxData(
            JobJournalLine,
            ViewType::TotalJobJournal,
            BillableHours[3],
            NonBillableHours[3],
            TotalSales[3],
            TotalCost[3],
            TotalProfit[3],
            AvgPricePerUOM[3]);
    end;

    procedure UpdateJobData(
        Job: Record Job;
        var BillableHours: array[5] of Decimal;
        var NonBillableHours: array[5] of Decimal;
        var TotalSales: array[5] of Decimal;
        var TotalCost: array[5] of Decimal;
        var TotalProfit: array[5] of Decimal;
        var AvgPricePerUOM: array[5] of Decimal);
    var
        DxJobJnlFactboxCalculator: Codeunit "DXS.Job Factbox Calculator";
    begin
        DxJobJnlFactboxCalculator.CalcJobFactBoxData(
            Job,
            1,
            BillableHours[1],
            NonBillableHours[1],
            TotalSales[1],
            TotalCost[1],
            TotalProfit[1],
            AvgPricePerUOM[1]);
        DxJobJnlFactboxCalculator.CalcJobFactBoxData(
            Job,
            2,
            BillableHours[2],
            NonBillableHours[2],
            TotalSales[2],
            TotalCost[2],
            TotalProfit[2],
            AvgPricePerUOM[2]);
        DxJobJnlFactboxCalculator.CalcJobFactBoxData(
            Job,
            3,
            BillableHours[3],
            NonBillableHours[3],
            TotalSales[3],
            TotalCost[3],
            TotalProfit[3],
            AvgPricePerUOM[3]);
    end;

}
codeunit 62005 DxUpdateFactboxData
{
    procedure UpdateData(
        JobJournalLine : Record "Job Journal Line";
        var BillableHours : array [5] of Decimal;
        var NonBillableHours : array [5] of Decimal;
        var TotalSales : array [5] of Decimal;
        var TotalCost : array [5] of Decimal;
        var TotalProfit : array [5] of Decimal;
        var AvgPricePerUOM : array [5] of Decimal;
        ShowTimeSheet : Boolean);
    var
        JobFactboxCalculation : Codeunit DxJobFactboxManagement;
        ViewType : Option CurrentJobJournal,TimeSheet,JobLedgerEntry,TotalJobJournal;
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
        if JobFactboxCalculation.ShowTimeSheet then
            JobFactboxCalculation.CalcJobJnlFactBoxData(
                JobJournalLine,
                ViewType::TimeSheet,
                BillableHours[2],
                NonBillableHours[2],
                TotalSales[2],
                TotalCost[2],
                TotalProfit[2],
                AvgPricePerUOM[2]);
        JobFactboxCalculation.CalcJobJnlFactBoxData(
            JobJournalLine,
            ViewType::JobLedgerEntry,
            BillableHours[3],
            NonBillableHours[3],
            TotalSales[3],
            TotalCost[3],
            TotalProfit[3],
            AvgPricePerUOM[3]);
        JobFactboxCalculation.CalcJobJnlFactBoxData(
            JobJournalLine,
            ViewType::TotalJobJournal,
            BillableHours[4],
            NonBillableHours[4],
            TotalSales[4],
            TotalCost[4],
            TotalProfit[4],
            AvgPricePerUOM[4]);
    end;
}
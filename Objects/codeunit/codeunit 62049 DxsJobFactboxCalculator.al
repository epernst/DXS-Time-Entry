codeunit 62049 DxsJobFactboxCalculator
{
    trigger OnRun();
    begin
    end;

    procedure CalcJobJnlFactBoxData(
        JobJournalLine: Record "Job Journal Line";
        ViewType: Option CurrentJobJournal, JobLedgerEntry, TotalJobJournal;
        var BillableHours: Decimal;
        var NonBillableHours: Decimal;
        var TotalSales: Decimal;
        var TotalCost: Decimal;
        var TotalProfit: Decimal;
        var AvgPricePerUOM: Decimal);
    var
        Job: Record Job;
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        if HourlyUnitHandler.GetHourlyUnitOfMeasureFilter = '' then exit;
        if(not Job.GET(JobJournalLine."Job No.")) and(ViewType <> ViewType::TotalJobJournal) then exit;

        BillableHours := 0;
        NonBillableHours := 0;
        TotalSales := 0;
        TotalCost := 0;
        TotalProfit := 0;
        AvgPricePerUOM := 0;

        case ViewType of
            ViewType::CurrentJobJournal :
                CalculateJobJournal(Job."No.", TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
            ViewType::JobLedgerEntry :
                    CalculateJobLedgerEntry(Job."No.", TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
            ViewType::TotalJobJournal :
                    CalculateJobJournal('', TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
        end;
    end;

    procedure CalcJobFactBoxData(
        Job: Record Job;
        ViewType: Option CurrentJobJournal, JobLedgerEntry, TotalJobJournal;
        var BillableHours: Decimal;
        var NonBillableHours: Decimal;
        var TotalSales: Decimal;
        var TotalCost: Decimal;
        var TotalProfit: Decimal;
        var AvgPricePerUOM: Decimal);
    var
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        if Job."No." = '' then
            exit;
        if HourlyUnitHandler.GetHourlyUnitOfMeasureFilter = '' then exit;

        BillableHours := 0;
        NonBillableHours := 0;
        TotalSales := 0;
        TotalCost := 0;
        TotalProfit := 0;
        AvgPricePerUOM := 0;

        case ViewType of
            ViewType::CurrentJobJournal :
                CalculateJobJournal(Job."No.", TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
        ViewType::JobLedgerEntry :
                CalculateJobLedgerEntry(Job."No.", TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
        end;
    end;

    procedure CalculateJobJournal(
        JobNo: Code[20];
        var TotalSales: Decimal;
        var TotalCost: Decimal;
        var TotalProfit: Decimal;
        var BillableHours: Decimal;
        var NonBillableHours: Decimal;
        var AvgPricePerUOM: Decimal);
    var
        JobJournalLine: Record "Job Journal Line";
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        with JobJournalLine do begin
            if JobNo <> '' then
                SetRange("Job No.", JobNo);
            CalcSums("Total Cost (LCY)", "Total Price (LCY)");
            TotalSales := "Total Price (LCY)";
            TotalCost := "Total Cost (LCY)";

            SetFilter("Unit of Measure Code", HourlyUnitHandler.GetHourlyUnitOfMeasureFilter);
            SetRange(Chargeable, true);
            CalcSums(Quantity);
            BillableHours := Quantity;

            SetRange(Chargeable, false);
            CalcSums(Quantity);
            NonBillableHours := Quantity;

            AvgPricePerUOM :=
                CalculateAverageRate(TotalSales, BillableHours + NonBillableHours);

            TotalProfit := TotalSales - TotalCost;
        end;
    end;

    procedure CalculateJobLedgerEntry(
        JobNo: Code[20];
        var TotalSales: Decimal;
        var TotalCost: Decimal;
        var TotalProfit: Decimal;
        var BillableHours: Decimal;
        var NonBillableHours: Decimal;
        var AvgPricePerUOM: Decimal);
    var
        JobLedgerEntry: Record "Job Ledger Entry";
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        with JobLedgerEntry do begin
            IF JobNo <> '' then
                SetRange("Job No.", JobNo);
            SetRange("Entry Type", "Entry Type"::Usage);
            CalcSums("Total Cost (LCY)", "Total Price (LCY)", "Line Amount (LCY)");
            TotalSales := "Line Amount (LCY)";
            TotalCost := "Total Cost (LCY)";

            SetRange("Unit of Measure Code", HourlyUnitHandler.GetHourlyUnitOfMeasureFilter);
            SetFilter("Total Price (LCY)", '<>%1', 0);

            CalcSums(Quantity);
            BillableHours := Quantity;

            SetFilter("Total Price (LCY)", '%1', 0);
            CalcSums(Quantity);
            NonBillableHours := Quantity;

            AvgPricePerUOM :=
                CalculateAverageRate(TotalSales, BillableHours + NonBillableHours);

            TotalProfit := TotalSales - TotalCost;
        end;
    end;

    procedure CalculateAverageRate(
        SalesTotal: Decimal;
        TotalHours: Decimal): Decimal;
    begin
        if(SalesTotal <> 0) and(TotalHours <> 0) then
            exit(SalesTotal / TotalHours)
        else
            exit(0);
    end;
}

codeunit 62047 DxsDrillDownJobFactBox
{
    procedure DrillDownJobJournal(
        JournalTemplateName: Code[20];
        JournalBatchName: Code[20];
        JobNo: Code[20];
        DrillDownField: Option BillableHours, NonBillableHours, TotalSales, TotalCost, TotalProfit);
    var
        JobJournalLine: Record "Job Journal Line";
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        with JobJournalLine do begin
            SetRange("Journal Template Name", JobJournalLine."Journal Template Name");
            SetRange("Journal Batch Name", JobJournalLine."Journal Batch Name");
            SetRange("Job No.", JobJournalLine."Job No.");
            case DrillDownField of
                DrillDownField::BillableHours :
                    begin
                        SetFilter("Unit of Measure Code", HourlyUnitHandler.GetHourlyUnitOfMeasureFilter);
                        SetRange(Chargeable, true);
                    end;
                DrillDownField::NonBillableHours :
                    begin
                        SetFilter("Unit of Measure Code", HourlyUnitHandler.GetHourlyUnitOfMeasureFilter);
                        SetRange(Chargeable, false);
                    end;
            end;
            Page.Run(Page::"Job Journal", JobJournalLine);
        end;
    end;

    procedure DrillDownJobLedgerEntry(
        JobNo: Code[20];
        DrillDownField: Option BillableHours, NonBillableHours, TotalSales, TotalCost, TotalProfit);
    var
        JobLedgerEntry: Record "Job Ledger Entry";
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        with JobLedgerEntry do begin
            SetRange("Job No.", JobNo);
            SetRange("Entry Type", "Entry Type"::Usage);
            case DrillDownField of
                DrillDownField::BillableHours :
                    begin
                        SetRange("Unit of Measure Code", HourlyUnitHandler.GetHourlyUnitOfMeasureFilter);
                        SetFilter("Total Price (LCY)", '<>%1', 0);
                    end;
                DrillDownField::NonBillableHours :
                    begin
                        SetRange("Unit of Measure Code", HourlyUnitHandler.GetHourlyUnitOfMeasureFilter);
                        SetFilter("Total Price (LCY)", '%1', 0);
                    end;
            end;
            Page.Run(Page::"Job Ledger Entries", JobLedgerEntry);
        end;
    end;
}
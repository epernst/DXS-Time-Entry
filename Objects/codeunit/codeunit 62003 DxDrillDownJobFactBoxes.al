codeunit 62003 DxDrillDownJobFactBoxes
{
    procedure DrillDownJobJournal(
        JournalTemplateName : Code[20];
        JournalBatchName : Code[20];
        JobNo : Code[20];
        DrillDownField : Option BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit);
    var
        JobJournalLine : Record "Job Journal Line";
        JobUOM : Codeunit DxHourlyUnitHandler;
    begin
        with JobJournalLine do begin
            SetRange("Journal Template Name",JobJournalLine."Journal Template Name");
            SetRange("Journal Batch Name",JobJournalLine."Journal Batch Name");
            SetRange("Job No.",JobJournalLine."Job No.");
            case DrillDownField of
                DrillDownField::BillableHours :
                    begin
                        SetFilter("Unit of Measure Code",JobUOM.GetUnitOfMeasureHourFilter);
                        SetRange(Chargeable,true);
                    end;
                DrillDownField::NonBillableHours :
                    begin
                        SetFilter("Unit of Measure Code",JobUOM.GetUnitOfMeasureHourFilter);
                        SetRange(Chargeable,false);
                    end;
            end;
            PAGE.RUN(PAGE::"Job Journal",JobJournalLine);
        end;
    end;

    procedure DrillDownJobLedgerEntry(
        JobNo : Code[20];
        DrillDownField : Option BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit);
    var
        JobLedgerEntry : Record "Job Ledger Entry";
        JobUOM : Codeunit DxHourlyUnitHandler;
    begin
        with JobLedgerEntry do begin
            SetRange("Job No.",JobNo);
            SetRange("Entry Type","Entry Type"::Usage);
            case DrillDownField of
                DrillDownField::BillableHours :
                    begin
                        SetRange("Unit of Measure Code",JobUOM.GetUnitOfMeasureHourFilter);
                        SETFILTER("Total Price (LCY)",'<>%1',0);
                    end;
                DrillDownField::NonBillableHours :
                    begin
                        SetRange("Unit of Measure Code",JobUOM.GetUnitOfMeasureHourFilter);
                        SETFILTER("Total Price (LCY)",'%1',0);
                    end;
                end;
            PAGE.RUN(PAGE::"Job Ledger Entries",JobLedgerEntry);
        end;
    end;
}
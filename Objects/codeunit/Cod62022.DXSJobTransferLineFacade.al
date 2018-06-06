codeunit 62022 "DXSJobTransferLineFacade"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJnlLineToLedgEntry', '', false, false)]
    local procedure onAfterFromJnlLineToLedgEntry(
        var JobLedgerEntry : Record "Job Ledger Entry"; 
        JobJournalLine : Record "Job Journal Line");
    begin
        with JobLedgerEntry do begin
            "DXS Start Time" := JobJournalLine."DXS Start Time";
            "DXS End Time" := JobJournalLine."DXS End Time";
            "DXS Start Date Time" := JobJournalLine."DXS Start Date Time";
            "DXS End Date Time" := JobJournalLine."DXS End Date Time";
            "DXS Total Duration" := JobJournalLine."DXS Total Duration";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJnlToPlanningLine', '', false, false)]
    local procedure onAfterFromJnlToPlanningLine(
        var JobPlanningLine : Record "Job Planning Line";
        JobJournalLine : Record "Job Journal Line");
    begin
        with JobPlanningLine do begin
            "DXS Start Time" := JobJournalLine."DXS Start Time";
            "DXS End Time" := JobJournalLine."DXS End Time";
            "DXS Start Date Time" := JobJournalLine."DXS Start Date Time";
            "DXS End Date Time" := JobJournalLine."DXS End Date Time";
            "DXS Total Duration" := JobJournalLine."DXS Total Duration";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromPlanningLineToJnlLine', '', false, false)]
    local procedure onAfterFromPlanningLineToJnlLine(
        var JobJournalLine : Record "Job Journal Line";
        JobPlanningLine : Record "Job Planning Line");
    begin
        with JobJournalLine do begin
            "DXS Start Time" := JobPlanningLine."DXS Start Time";
            "DXS End Time" := JobPlanningLine."DXS End Time";
            "DXS Start Date Time" := JobPlanningLine."DXS Start Date Time";
            "DXS End Date Time" := JobPlanningLine."DXS End Date Time";
            "DXS Total Duration" := JobPlanningLine."DXS Total Duration";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJobLedgEntryToPlanningLine', '', false, false)]
    local procedure onAfterFromJobLedgerEntryToPlanningLine(
        var JobPlanningLine : Record "Job Planning Line";
        JobLedgEntry : Record "Job Ledger Entry");
    begin
        with JobPlanningLine do begin
            "DXS Start Time" := JobLedgEntry."DXS Start Time";
            "DXS End Time" := JobLedgEntry."DXS End Time";
            "DXS Start Date Time" := JobLedgEntry."DXS Start Date Time";
            "DXS End Date Time" := JobLedgEntry."DXS End Date Time";
            "DXS Total Duration" := JobLedgEntry."DXS Total Duration";
        end;
    end;
}

codeunit 62001 DxJobFacade
{
    [EventSubscriber(ObjectType::Table, 210, 'OnAfterValidateEvent', 'Line Type', false, false)]
    local procedure T210_OnAfterValidate(
        var Rec : Record "Job Journal Line");
    begin
        with Rec do begin
            if "Job No." <> '' then
                Chargeable := ("Line Type" <> "Line Type"::Budget);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1004, 'onAfterFromJnlLineToLedgEntry', '', false, false)]
    local procedure onAfterFromJnlLineToLedgEntry(
      var JobLedgerEntry : Record "Job Ledger Entry"; 
      JobJournalLine : Record "Job Journal Line");
    begin
        with JobLedgerEntry do begin
          "Start Time" := JobJournalLine."Start Time";
          "End Time" := JobJournalLine."End Time";
          "Start Date Time" := JobJournalLine."Start Date Time";
          "End Date Time" := JobJournalLine."End Date Time";
          "Total Duration" := JobJournalLine."Total Duration";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1004, 'onAfterFromJnlToPlanningLine', '', false, false)]
    local procedure onAfterFromJnlToPlanningLine(
      JobJournalLine : Record "Job Journal Line";
      var JobPlanningLine : Record "Job Planning Line");
    begin
        with JobPlanningLine do begin
            "Start Time" := JobJournalLine."Start Time";
            "End Time" := JobJournalLine."End Time";
            "Start Date Time" := JobJournalLine."Start Date Time";
            "End Date Time" := JobJournalLine."End Date Time";
            "Total Duration" := JobJournalLine."Total Duration";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1004, 'onAfterFromPlanningLineToJnlLine', '', false, false)]
    local procedure onAfterFromPlanningLineToJnlLine(
      var JobJournalLine : Record "Job Journal Line";
      JobPlanningLine : Record "Job Planning Line");
    begin
        with JobJournalLine DO begin
            "Start Time" := JobPlanningLine."Start Time";
            "End Time" := JobPlanningLine."End Time";
            "Start Date Time" := JobPlanningLine."Start Date Time";
            "End Date Time" := JobPlanningLine."End Date Time";
            "Total Duration" := JobPlanningLine."Total Duration";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1004, 'OnAfterFromJobLedgEntryToPlanningLine', '', false, false)]
    local procedure onAfterFromJobLedgerEntryToPlanningLine(
        var JobPlanningLine : Record "Job Planning Line";
        JobLedgEntry : Record "Job Ledger Entry");
    begin
        with JobPlanningLine do begin
            "Start Time" := JobLedgEntry."Start Time";
            "End Time" := JobLedgEntry."End Time";
            "Start Date Time" := JobLedgEntry."Start Date Time";
            "End Date Time" := JobLedgEntry."End Date Time";
            "Total Duration" := JobLedgEntry."Total Duration";
        end;
    end;
}


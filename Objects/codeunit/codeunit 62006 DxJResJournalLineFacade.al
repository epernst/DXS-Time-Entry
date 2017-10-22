codeunit 62006 DxResJournalLineFacade
{
    [EventSubscriber(ObjectType::Table, 207, 'onAfterCopyResJnlLineFromJobJnlLine', '', false, false)]
    local procedure onAfterFromJnlLineToLedgEntry(
        var ResJnlLine : Record "Res. Journal Line"; 
        JobJnlLine : Record "Job Journal Line");
    begin
        with ResJnlLine do begin
           "Start Time" := JobJnlLine."Start Time";
           "End Time" := JobJnlLine."End Time";
           "Start Date Time" := JobJnlLine."Start Date Time";
           "End Date Time" := JobJnlLine."End Date Time";
           "Total Duration" := JobJnlLine."Total Duration";
        end;
    end;

}

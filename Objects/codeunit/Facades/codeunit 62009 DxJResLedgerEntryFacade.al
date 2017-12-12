codeunit 62009 DxResLedgerEntryFacade
{
    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", 'OnAfterCopyFromResJnlLine', '', false, false)]
    local procedure OnAfterCopyFromResJnlLine(
        var ResLedgerEntry : Record "Res. Ledger Entry"; 
        ResJournalLine : Record "Res. Journal Line");
    begin
        with ResLedgerEntry do begin
           "Start Time" := ResJournalLine."Start Time";
           "End Time" := ResJournalLine."End Time";
           "Start Date Time" := ResJournalLine."Start Date Time";
           "End Date Time" := ResJournalLine."End Date Time";
           "Total Duration" := ResJournalLine."Total Duration";
        end;
    end;
}

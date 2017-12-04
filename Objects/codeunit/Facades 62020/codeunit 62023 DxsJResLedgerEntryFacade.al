codeunit 62023 DxResLedgerEntryFacade
{
    [EventSubscriber(ObjectType::Table, Database::"Res. Ledger Entry", 'OnAfterCopyFromResJnlLine', '', false, false)]
    local procedure OnAfterCopyFromResJnlLine(
        var ResLedgerEntry: Record "Res. Ledger Entry";
        ResJournalLine: Record "Res. Journal Line");
    begin
        with ResLedgerEntry do begin
            "DXS Start Time" := ResJournalLine."DXS Start Time";
            "DXS End Time" := ResJournalLine."DXS End Time";
            "DXS Start Date Time" := ResJournalLine."DXS Start Date Time";
            "DXS End Date Time" := ResJournalLine."DXS End Date Time";
            "DXS Total Duration" := ResJournalLine."DXS Total Duration";
        end;
    end;
}

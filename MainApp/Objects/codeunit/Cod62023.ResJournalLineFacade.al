Codeunit 62023 "DXS.Res JournalLine Facade"
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Res. Journal Line", 'onAfterCopyResJnlLineFromJobJnlLine', '', false, false)]
    local procedure onAfterFromJnlLineToLedgEntry(
        var ResJnlLine: Record "Res. Journal Line";
        JobJnlLine: Record "Job Journal Line");
    begin
        with ResJnlLine do begin
            "DXS.Start Time" := JobJnlLine."DXS Start Time";
            "DXS.End Time" := JobJnlLine."DXS End Time";
            "DXS.Start Date Time" := JobJnlLine."DXS Start Date Time";
            "DXS.End Date Time" := JobJnlLine."DXS End Date Time";
            "DXS.Total Duration" := JobJnlLine."DXS Total Duration";
        end;
    end;

}

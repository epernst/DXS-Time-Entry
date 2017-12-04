codeunit 62020 DxJobJournalLineFacade
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnAfterValidateEvent', 'Line Type', false, false)]
    local procedure OnAfterValidateLineType(
        var Rec : Record "Job Journal Line");
    begin
        with Rec do 
            if "Job No." <> '' then
                Chargeable := ("Line Type" <> "Line Type"::Budget);
    end;
}
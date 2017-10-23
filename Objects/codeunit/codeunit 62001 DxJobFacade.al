codeunit 62001 DxJobFacade
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnAfterValidateEvent', 'Line Type', false, false)]
    local procedure OnAfterValidateLineType(
        var Rec : Record "Job Journal Line");
    begin
        with Rec do begin
            if "Job No." <> '' then
                Chargeable := ("Line Type" <> "Line Type"::Budget);
        end;
    end;
}

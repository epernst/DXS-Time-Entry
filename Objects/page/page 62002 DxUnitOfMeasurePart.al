page 62002 DxUnitOfMeasurePart
{
    PageType = ListPart;
    SourceTable = "Unit of Measure";
    SourceTableTemporary = true;
    InsertAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Hourly Unit";"Hourly Unit")
                {
                    
                }
                field("Time Rounding";"Time Rounding")
                {
                    Editable = IsRoudingEditable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin
                end;
            }
        }
    }
    var
        IsRoudingEditable : Boolean;

    trigger OnAfterGetCurrRecord();
    begin 
        UpdatePage
    end;

    local procedure UpdatePage();
    begin 
        IsRoudingEditable := "Hourly Unit";
    end;

    procedure Set(var TempUnitOfMeasure : Record "Unit of Measure" Temporary );
    begin 
        Copy(TempUnitOfMeasure,true);
    end;
}

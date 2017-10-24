page 62002 DxUnitOfMeasurePart
{
    Caption = 'Units Of Measure';
    PageType = ListPart;
    SourceTable = "Unit of Measure";
    SourceTableTemporary = true;
    DeleteAllowed = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = IsHourlyUnit;
                }
                field(Description;Description)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = IsHourlyUnit;
                }
                field("Hourly Unit";"Hourly Unit")
                {
                    Visible = NOT HourlyUnitsFiltered;
                    ApplicationArea = All;                    
                }
                field("Time Rounding";"Time Rounding")
                {
                    Visible = HourlyUnitsFiltered;
                    ApplicationArea = All;
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
        HourlyUnitsFiltered : Boolean;
        IsRoudingVisible : Boolean;
        IsHourlyUnit : Boolean;
        InternationalStandardCode : Label 'HUR';

    trigger OnOpenPage();
    begin
        HourlyUnitsFiltered := GetFilter("Hourly Unit") <> '';

    end;

    trigger OnAfterGetCurrRecord();
    begin 
        UpdatePage
    end;

    procedure Set(var TempUnitOfMeasure : Record "Unit of Measure" temporary);
    begin 
        Copy(TempUnitOfMeasure,true);
    end;

    procedure Get(var TempUnitOfMeasure : Record "Unit of Measure" temporary);
    begin 
        TempUnitOfMeasure.Copy(Rec,true);
    end;

    local procedure UpdatePage();
    begin 
        IsHourlyUnit := "Hourly Unit" or ("International Standard Code" = InternationalStandardCode);
    end;
}

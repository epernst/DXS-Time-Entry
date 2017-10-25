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
                    Style = Attention;
                    StyleExpr = IsHourlyUnit;
                }
                field("Hourly Unit";"Hourly Unit")
                {
                    ApplicationArea = All;                    
                }
                field("Time Rounding";"Time Rounding")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        IsRoudingVisible : Boolean;
        IsHourlyUnit : Boolean;
        InternationalStandardCodeLbl : Label 'HUR';

    trigger OnOpenPage();
    begin
        UpdatePage
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
        IsHourlyUnit := "Hourly Unit" or IsInternationalStandardCode(Code) or IsInternationalStandardCode("International Standard Code");
    end;
    
    local procedure IsInternationalStandardCode(CodeToCheck : Code[10]) :  Boolean;
    var
        IsIntStdCode : Boolean;
    begin 
        if CodeToCheck = InternationalStandardCodeLbl then exit(true);
        OnCheckInternationalCode(CodeToCheck,IsIntStdCode);
        exit(IsIntStdCode);
    end;

    [IntegrationEvent(false,false)]
    local procedure OnCheckInternationalCode(CodeToCheck : Code[10]; var IsHourlyCode : Boolean);
    begin
    end;
}

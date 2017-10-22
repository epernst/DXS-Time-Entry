codeunit 62004 DxHourlyUnitHandler
{
    trigger OnRun();
    begin
    end;
    
    var
        CanOnlyUseWithTypeErr : Label '%1 can only be used with a %2, which have been setup as a "%3".';

    procedure ValidateHourUnitOfMeasure(UnitOfMeasureCode : Code[10];TestFieldCaption : Text;ShowMessage : Boolean) : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin
        with UnitOfMeasure do begin
            if get(UnitOfMeasureCode) and "Hourly Unit" then 
                exit(true);
            if ShowMessage and GuiAllowed then
                Message(
                    CanOnlyUseWithTypeErr,
                    TestFieldCaption,
                    TableCaption,
                    FieldCaption("Hourly Unit"));
            exit(false);
        end;
    end;

    procedure IsUOMforHours(UnitOfMeasureCode : Code[10]) : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin 
        with UnitOfMeasure do begin
            if not get(UnitOfMeasureCode) then exit(false);
            exit("Hourly Unit");
        end;
    end;

    procedure HourlyUnitExits() : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin 
        with UnitOfMeasure do begin
            SetRange("Hourly Unit", true);
            exit(not IsEmpty);
        end;
    end;
    
    procedure GetUnitOfMeasureHourFilter() : Text;
    var
        UnitOfMeasure : Record "Unit of Measure";
        FilterText : Text;
    begin 
        with UnitOfMeasure do begin
            SetRange("Hourly Unit", true);
            if IsEmpty then exit('');

            FilterText := '';
            FindSet;
            repeat
                if FilterText <> '' then
                    FilterText += '|';
                FilterText += Code;
            until Next = 0;
        end;
        exit(FilterText);
    end;
}
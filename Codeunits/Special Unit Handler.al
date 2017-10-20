codeunit 62004 SpecialUnitHandler
{
    trigger OnRun();
    begin
    end;
    
    var
        CanOnlyUseWithTypeErr : Label '%1 can only be used with a %2, which have been setup as a "%3" of the type %4.';

    procedure ValidateHourUOM(UnitOfMeasureCode : Code[10];TestFieldCaption : Text;ShowMessage : Boolean) : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin
        with UnitOfMeasure do begin
            if get(UnitOfMeasureCode) and 
                ("Special Unit Calculation" = "Special Unit Calculation"::Hour) 
            then 
                exit(true);
            if ShowMessage and GuiAllowed then
                Message(
                    CanOnlyUseWithTypeErr,
                    TestFieldCaption,
                    TableCaption,
                    FieldCaption("Special Unit Calculation"),
                    "Special Unit Calculation"::Hour);
            exit(false);
        end;
    end;

    procedure IsUOMforHours(UOMCode : Code[10]) : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin 
        with UnitOfMeasure do begin
            if not get(UOMCode) then exit(false);
            exit("Special Unit Calculation" = "Special Unit Calculation"::Hour);
        end;
    end;

    procedure GetUnitOfMeasureHour() : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin 
        with UnitOfMeasure do begin
            SetRange("Special Unit Calculation", "Special Unit Calculation"::Hour);
            exit(not IsEmpty);
        end;
    end;
    
    procedure GetUnitOfMeasureHourFilter() : Text;
    var
        UnitOfMeasure : Record "Unit of Measure";
        FilterText : Text;
    begin 
        with UnitOfMeasure do begin
            SetRange("Special Unit Calculation", "Special Unit Calculation"::Hour);
            if IsEmpty then exit('');

            FilterText := '';
            findset;
            repeat
                if FilterText <> '' then
                    FilterText += '|';
                FilterText += Code;
            until Next = 0;
        end;
        exit(FilterText);
    end;
}
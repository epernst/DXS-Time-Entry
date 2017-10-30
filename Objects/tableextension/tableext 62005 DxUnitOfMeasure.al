tableextension 62005 DxUnitOfMeasure extends "Unit of Measure"
{
    fields
    {
        field(62000;"Hourly Unit";Boolean)
        {
            Caption = 'Hourly Unit';
            trigger OnValidate();
            var
                TimeEntrySetup : Record DxTimeEntrySetup;
            begin 
                if "Hourly Unit" = xRec."Hourly Unit" then exit;
                if "Hourly Unit" then begin
                    if not TimeEntrySetup.get then TimeEntrySetup.init;
                        "Time Rounding" := TimeEntrySetup."Default Time Rounding";
                end else 
                    "Time Rounding" := 0;
            end;            
        }
        field(62001;"Time Rounding";Decimal)
        {
            Caption ='Time Rounding';
            trigger OnValidate();
            begin 
                if "Time Rounding" = xRec."Time Rounding" then exit;

                if "Time Rounding" = 0 then begin
                    if ("Hourly Unit") then 
                        error( 
                            RoundingMustBeEnteredErr,
                            FieldCaption("Time Rounding"),
                            FieldCaption("Hourly Unit"), 
                            Code);
                end else begin
                    if not "Hourly Unit" then 
                        error(
                            NotHourlyUnitErr,
                            FieldCaption("Time Rounding"),
                            FieldCaption("Hourly Unit"));
                end;
            end;
        }
    }

    var
        NotHourlyUnitErr : Label 'It is only possible to use %1 with %2''s', Comment = '%1-Field caption, %2 Hourly Unit', Maxlength=100;
        RoundingMustBeEnteredErr : Label '%1 must be specified if "%2" is selected. For example 0.25 will round to 15 minutes.';

    procedure GetTimeRounding(UnitOfMeasureCode : Code[10]) : Decimal;
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
        UnitOfMeasure : Record "Unit of Measure";
        HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
        myInt : Record DxTimeEntrySetup;
    begin
        if UnitOfMeasure.get(UnitofMeasureCode) and (UnitOfMeasure."Time Rounding" <> 0) then
            exit(Unitofmeasure."Time Rounding");
        
        if TimeEntrySetup.get and (TimeEntrySetup."Default Time Rounding" <> 0) then
            exit(TimeEntrySetup."Default Time Rounding");

        exit(0.25);
    end;
}
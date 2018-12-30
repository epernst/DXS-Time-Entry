tableextension 62005 "DXS.Unit of Measure" extends "Unit of Measure"
{
    fields
    {
        field(62000; "DXS.Hourly Unit"; Boolean)
        {
            Caption = 'Hourly Unit';
            trigger OnValidate();
            var
                TimeEntrySetup: Record "DXS.Time Entry Setup";
            begin
                if "DXS.Hourly Unit" = xRec."DXS.Hourly Unit" then exit;
                if "DXS.Hourly Unit" then begin
                    if not TimeEntrySetup.get() then TimeEntrySetup.init();
                    "DXS.Time Rounding" := TimeEntrySetup."Default Time Rounding";
                end else
                    "DXS.Time Rounding" := 0;
            end;
        }
        field(62001; "DXS.Time Rounding"; Decimal)
        {
            Caption = 'Time Rounding';
            trigger OnValidate();
            begin
                if "DXS.Time Rounding" = xRec."DXS.Time Rounding" then exit;

                if "DXS.Time Rounding" = 0 then begin
                    if ("DXS.Hourly Unit") then
                        error(
                            RoundingMustBeEnteredErr,
                            FieldCaption("DXS.Time Rounding"),
                            FieldCaption("DXS.Hourly Unit"),
                            Code);
                end else
                    if not "DXS.Hourly Unit" then
                        error(
                            NotHourlyUnitErr,
                            FieldCaption("DXS.Time Rounding"),
                            FieldCaption("DXS.Hourly Unit"));
            end;
        }
    }

    var
        NotHourlyUnitErr: Label 'It is only possible to use %1 with %2''s', Comment = '%1-Field caption, %2 Hourly Unit', Maxlength = 100;
        RoundingMustBeEnteredErr: Label '%1 must be specified if "%2" is selected. For example 0.25 will round to 15 minutes.';

    procedure GetTimeRounding(UnitOfMeasureCode: Code[10]): Decimal;
    var
        TimeEntrySetup: Record "DXS.Time Entry Setup";
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if UnitOfMeasure.get(UnitofMeasureCode) and (UnitOfMeasure."DXS.Time Rounding" <> 0) then
            exit(Unitofmeasure."DXS.Time Rounding");

        if TimeEntrySetup.get() and (TimeEntrySetup."Default Time Rounding" <> 0) then
            exit(TimeEntrySetup."Default Time Rounding");

        exit(0.25);
    end;
}
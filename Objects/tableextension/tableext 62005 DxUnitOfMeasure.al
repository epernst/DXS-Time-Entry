tableextension 62005 DxUnitOfMeasure extends "Unit of Measure"
{
    fields
    {
        field(62000;"Hourly Unit";Boolean)
        {
            Caption = 'Hourly Unit';
            trigger OnValidate();
            begin 
                if "Hourly Unit" = xRec."Hourly Unit" then exit;

                if "Hourly Unit" then
                    "Time Rounding" := 0.25
                else 
                    "Time Rounding" := 0;
            end;            
        }
        field(62001;"Time Rounding";Decimal)
        {
            Caption ='Time Rounding';
            trigger OnValidate();
            begin 
                if "Time Rounding" = 0 then begin
                    if "Hourly Unit" and GuiAllowed then
                        error( 
                            RoundingMustBeEnteredErr,
                            FieldCaption("Time Rounding"),
                            FieldCaption("Hourly Unit"), 
                            Code);
                    exit;
                end;
                if "Hourly Unit"  then exit;
                error(
                    NotHourSpecialUnitErr,
                    FieldCaption("Time Rounding"),
                    FieldCaption("Hourly Unit"))
            end;
        }
    }

    var
        NotHourSpecialUnitErr : Label 'It is only possible to use %1 with %2', Comment = '%1-Field caption, %2 Hourly Unit', Maxlength=100;
        RoundingMustBeEnteredErr : Label '%1 must be specified for %2 "%3". For example 0.25 will round to 15 minutes.';
}
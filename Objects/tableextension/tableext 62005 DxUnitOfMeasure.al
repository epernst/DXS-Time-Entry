tableextension 62005 DxUnitOfMeasure extends "Unit of Measure"
{
    fields
    {
        field(62000;"Special Unit Calculation";Option)
        {
            Caption = 'Special Unit Calculation';
            OptionMembers = Normal,Hour,Kilometer;
            OptionCaption = ' ,Hour,Kilometer';
            trigger OnValidate();
            begin 
                if "Special Unit Calculation" = xRec."Special Unit Calculation" then exit;

                if "Special Unit Calculation" = "Special Unit Calculation"::Hour then
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
                    if ("Special Unit Calculation" = "Special Unit Calculation"::Hour) and 
                        GuiAllowed
                    then
                        error( 
                            RoundingMustBeEnteredErr,
                            FieldCaption("Time Rounding"),
                            "Special Unit Calculation"::Hour, 
                            Code);
                    exit;
                end;
                if "Special Unit Calculation" = "Special Unit Calculation"::Hour then exit;
                error(
                    NotHourSpecialUnitErr,
                    FieldCaption("Time Rounding"),
                    FieldCaption("Special Unit Calculation"),
                    "Special Unit Calculation"::Hour)
            end;
        }
    }

    var
        NotHourSpecialUnitErr : Label 'It is only possible to use %1 with units, where %2 is %4', Comment = '%1-Field caption, %2 Special Unit caption and %3 value', Maxlength=100;
        RoundingMustBeEnteredErr : Label '%1 must be specified for "%2" unit %3. 0.25 will round to 15 minutes.';
}
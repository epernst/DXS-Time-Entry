tableextension 62005 DxUnitOfMeasure extends "Unit of Measure"
{
    fields
    {
        field(62000;"Special Unit Calculation";Option)
        {
            Caption = 'Special Unit Calculation';
            OptionMembers = Normal,Hour,Kilometer;
            OptionCaption = ' ,Hour,Kilometer';
        }
        field(62001;"Time Rounding";Decimal)
        {
            Caption ='Time Rounding';
            trigger OnValidate();
            begin 
                if ("Time Rounding" <> 0) and 
                   ("Special Unit Calculation" <> "Special Unit Calculation"::Hour)
                then
                    error(
                        NotHourSpecialUnitErr,
                        FieldCaption("Special Unit Calculation"),
                        "Special Unit Calculation"::Hour)
            end;
        }
    }

    var
        NotHourSpecialUnitErr : Label 'It is only possible to use Time Rounding with units, where %1 is %2', Comment = '%1 Special Unit caption and %2 value', Maxlength=200;

}
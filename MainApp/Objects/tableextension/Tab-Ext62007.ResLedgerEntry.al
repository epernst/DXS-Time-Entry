tableextension 62007 "DXS.Res. Ledger Entry" extends "Res. Ledger Entry"
{
    fields
    {
        field(62000; "DXS.Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(62001; "DXS.End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(62003; "DXS.Start Date Time"; DateTime)
        {
            Caption = 'Start Date Time';
            DataClassification = CustomerContent;
        }
        field(62004; "DXS.End Date Time"; DateTime)
        {
            Caption = 'End Date Time';
            DataClassification = CustomerContent;
        }
        field(62005; "DXS.Total Duration"; Duration)
        {
            Caption = 'Total Duration';
            DataClassification = CustomerContent;
        }
    }
}


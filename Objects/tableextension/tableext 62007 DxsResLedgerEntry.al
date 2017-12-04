tableextension 62007 DxResLedgerEntry extends "Res. Ledger Entry" 
{
    fields
    {
        field(62000;"DXS Start Time";Time)
        {
            Caption='Start Time';
        }
        field(62001;"DXS End Time";Time)
        {
            Caption='End Time';
        }
        field(62002;"DXS Total Time";Decimal)
        {
            Caption='Total Time';
        }
          field(62003;"DXS Start Date Time";DateTime)
        {
            Caption = 'Start Date Time';
        }
        field(62004;"DXS End Date Time";DateTime)
        {
            Caption = 'End Date Time';
        }
        field(62005;"DXS Total Duration";Duration)
        {
            Caption = 'Total Duration';
        }
    }
}


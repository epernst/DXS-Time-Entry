tableextension 62004 DxJobLedgerEntry extends "Job Ledger Entry" 
{
    fields
    {
        field(62000;"Start Time";Time)
        {
            Caption='Start Time';
        }
        field(62001;"End Time";Time)
        {
            Caption='End Time';
        }
        field(62002;"Total Time";Decimal)
        {
            Caption='Total Time';
        }
          field(62003;"Start Date Time";DateTime)
        {
            Caption = 'Start Date Time';
        }
        field(62004;"End Date Time";DateTime)
        {
            Caption = 'End Date Time';
        }
        field(62005;"Total Duration";Duration)
        {
            Caption = 'Total Duration';
        }
    }
}


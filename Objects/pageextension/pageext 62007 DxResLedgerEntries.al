pageextension 62007 DxResourceLedgerEntries extends "Resource Ledger Entries" 
{
  layout
  {
    addafter("Unit of Measure Code")
    {
      field("Start Time";"Start Time")
      {
        ApplicationArea = All;
      }
      field("End Time";"End Time")
      {
        ApplicationArea = All;
      }
      field("Start Date Time";"Start Date Time")
      {
        Visible = false;
        ApplicationArea = All;
      }
      field("End Date Time";"End Date Time")
      {
        Visible = false;
        ApplicationArea = All;
      }
      field("Total Duration";"Total Duration")
      {
        ApplicationArea = All;
      }
    }
  }
}
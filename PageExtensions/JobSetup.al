pageextension 50103 JobSetupTime extends "Jobs Setup"
{
  layout
  {
    addlast(General)
    {
      group(Time)
      {
        Caption = 'Job Extension Settings';
        field("After Midnight Action";"After Midnight Action")
        {
            ToolTip = 'Specify how an ending time after midnight should be handled.';
            ApplicationArea = All;
        }
      }
    }
  }
  

}

pageextension 50155 UnitOfMeasure extends "Units of Measure"
{
  layout
  {
    addbefore("International Standard Code")
    {
        field("Special Unit Calculation";"Special Unit Calculation")
        {
            ToolTip = 'Specify if the unit of measure is either hour or distance based. Only used in the jobs module.';
            ApplicationArea = All;
        }
        field("Time Rounding";"Time Rounding")
        {
            ToolTip = 'Specify how to round start and end time based entries in the jobs module. For example enter 0.25 to have 15 minutes as the minimum time to use.';
            ApplicationArea = All;          
            Editable = IsSpecialUnit;
        }
    }
  }
  trigger OnOpenPage();
  begin
    IsSpecialUnit := false;
  end;
  
  trigger OnNewRecord(BelowxRec : Boolean);
  begin
    UpdatePage;
  end;

  trigger OnAfterGetCurrRecord();
  begin
    UpdatePage;
  end;
  
  var
    IsSpecialUnit : Boolean;

  local procedure UpdatePage();
  begin
    IsSpecialUnit := "Special Unit Calculation" = "Special Unit Calculation"::Hour;  
  end;

}

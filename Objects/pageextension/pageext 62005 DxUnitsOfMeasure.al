pageextension 62005 DxUnitsOfMeasure extends "Units of Measure"
{
  layout
  {
    addbefore("International Standard Code")
    {
        field("Hourly Unit";"Hourly Unit")
        {
            ToolTip = 'Specify if the unit of measure is either hour or distance based. Only used in the jobs module.';
            ApplicationArea = All;
        }
        field("Time Rounding";"Time Rounding")
        {
            ToolTip = 'Specify how to round start and end time based entries in the jobs module. For example enter 0.25 to have 15 minutes as the minimum time to use.';
            ApplicationArea = All;          
            Editable = IsHourlyUnit;
            ShowMandatory = IsHourlyUnit;
        }
    }
  }
  trigger OnOpenPage();
  begin
    IsHourlyUnit := false;
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
    IsHourlyUnit : Boolean;

  local procedure UpdatePage();
  begin
    IsHourlyUnit := "Hourly Unit";  
  end;

}

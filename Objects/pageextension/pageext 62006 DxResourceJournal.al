pageextension 62006 DxResourceJournal extends "Resource Journal" 
{
  layout
  {
    modify("Unit of Measure Code"){
      trigger OnAfterValidate();
      begin
        UpdatePage;
      end;
    }
    addafter("Unit of Measure Code")
    {
      field("Start Time";"Start Time")
      {
        ApplicationArea = All;
        Editable = IsTimeEditable;
      }
      field("End Time";"End Time")
      {
        ApplicationArea = All;
        Editable = IsTimeEditable;
      }
      field("Start Date Time";"Start Date Time")
      {
        Visible = false;
        Editable = IsTimeEditable;
        ApplicationArea = All;
      }
      field("End Date Time";"End Date Time")
      {
        Visible = false;
        Editable = IsTimeEditable;
        ApplicationArea = All;
      }
      field("Total Duration";"Total Duration")
      {
        Editable = IsTimeEditable;
        ApplicationArea = All;
      }
    }
  }
  trigger OnOpenPage();
  begin
    UpdatePage;
  end;
  
  trigger OnNewRecord(BelowxRec : Boolean);
  begin
    InitJobTimes;
    UpdatePage;
  end;

  trigger OnAfterGetCurrRecord();
  begin
    UpdatePage;
  end;
  
  var
    IsTimeEditable : Boolean;

  local procedure GetTimeEditable() : Boolean;
    var
      HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
    begin
        exit(HourlyUnitHandler.IsHourlyUnit("Unit of Measure Code"));
    end;

  local procedure UpdatePage();
    begin
      IsTimeEditable := GetTimeEditable;
    end;
}


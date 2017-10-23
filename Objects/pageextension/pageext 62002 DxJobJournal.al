pageextension 62002 DxJobJournal extends "Job Journal" 
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
        Visible = IsTimeEntryEnabled;
      }
      field("End Time";"End Time")
      {
        ApplicationArea = All;
        Editable = IsTimeEditable;
        Visible = IsTimeEntryEnabled;
      }
      field("Start Date Time";"Start Date Time")
      {
        Visible = IsTimeEntryEnabled;
        Editable = IsTimeEditable;
        ApplicationArea = All;
      }
      field("End Date Time";"End Date Time")
      {
        Visible = IsTimeEntryEnabled;
        Editable = IsTimeEditable;
        ApplicationArea = All;
      }
      field("Total Duration";"Total Duration")
      {
        Editable = IsTimeEditable;
        ApplicationArea = All;
      }
    }
    addfirst(FactBoxes)
    {
      part(JobJournalSummeryFactBox;DxJobJournalSummaryFactBox)
      {
        ApplicationArea = All;
        SubPageLink = 
          "Journal Template Name"=FIELD("Journal Template Name"),
          "Journal Batch Name"=FIELD("Journal Batch Name"),
          "Line No."=FIELD("Line No.");
        Visible = true;
      }
    }
  }
  trigger OnOpenPage();
  var 
    TimePermissionHandler : Codeunit DxTimePermissionHandler;
  begin
    IsTimeEntryEnabled := TimePermissionHandler.IsSetupEnabled; 
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
    IsTimeEntryEnabled  : Boolean;

  local procedure GetTimeEditable() : Boolean;
    var
      JobUOM : Codeunit DxHourlyUnitHandler;
    begin
        exit(jobuom.IsUOMforHours("Unit of Measure Code"));
    end;

  local procedure UpdatePage();
    begin
      IsTimeEditable := GetTimeEditable;
    end;
}
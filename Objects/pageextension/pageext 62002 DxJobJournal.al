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
        Visible = IsStartTimeVisible;
      }
      field("End Time";"End Time")
      {
        ApplicationArea = All;
        Editable = IsTimeEditable;
        Visible = IsEndTimeVisible;
      }
      field("Start Date Time";"Start Date Time")
      {
        ApplicationArea = All;
        Visible = IsStartDateTimeVisible;
        Editable = IsTimeEditable;
      }
      field("End Date Time";"End Date Time")
      {
        ApplicationArea = All;
        Visible = IsEndDateTimeVisible;
        Editable = IsTimeEditable;
      }
      field("Total Duration";"Total Duration")
      {
        ApplicationArea = All;
        Visible = IsTimeEntryEnabled;
        Editable = IsTimeEditable;
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
    with TimeEntrySetup do begin
        if not Get then Init;
        IsEndDateTimeVisible := IsTimeEntryEnabled and "Show End Date-Times"; 
        IsEndTimeVisible := IsTimeEntryEnabled and "Show End Times"; 
        IsStartDateTimeVisible := IsTimeEntryEnabled and "Show Start Date-Times"; 
        IsStartTimeVisible := IsTimeEntryEnabled and "Show Start Times"; 
    end;

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
    TimeEntrySetup : Record DxTimeEntrySetup;
    IsTimeEditable : Boolean;
    IsTimeEntryEnabled  : Boolean;
    IsStartTimeVisible : Boolean;
    IsEndTimeVisible : Boolean;
    IsStartDateTimeVisible : Boolean;
    IsEndDateTimeVisible : Boolean;

  local procedure GetTimeEditable() : Boolean;
    var
      JobUOM : Codeunit DxHourlyUnitHandler;
    begin
        exit(JobUOM.IsUOMforHours("Unit of Measure Code"));
    end;

  local procedure UpdatePage();
    begin
      IsTimeEditable := GetTimeEditable;
    end;
}

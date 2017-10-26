pageextension 62002 DxJobJournal extends "Job Journal" 
{
    layout
    {
        modify("Unit of Measure Code")
        {
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
                ToolTip = 'For time based entries enter the start time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartTimeVisible;
            }
            field("End Time";"End Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndTimeVisible;
            }
            field("Start Date Time";"Start Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartDateTimeVisible;
            }
            field("End Date Time";"End Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndDateTimeVisible;
            }
            field("Total Duration";"Total Duration")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries the total duration will show here.';
                Enabled = IsTimeEntryEnabled;
                Editable = IsTimeEditable;
                Visible = IsTimeEntryEnabled;
            }
        }
        addfirst(FactBoxes)
        {
            part(JobJournalSummeryFactBox;DxJobJournalSummaryFactBox)
            {
                ToolTip = 'Shows a summery of the current job and total job journal.';
                Enabled = IsTimeEntryEnabled;
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
        InitStartEndTimes;
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
        HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
    begin
        exit(HourlyUnitHandler.IsHourlyUnit("Unit of Measure Code"));
    end;

    local procedure UpdatePage();
    begin
        IsTimeEditable := GetTimeEditable;
    end;
}

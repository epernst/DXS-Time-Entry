pageextension 62004 DxJobLedgerEntries extends "Job Ledger Entries" 
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Start Time";"Start Time")
            {
                ApplicationArea = All;
                ToolTip = 'The start time of the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartTimeVisible;
            }
            field("End Time";"End Time")
            {
                ApplicationArea = All;
                ToolTip = 'The end time pf the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndTimeVisible;
            }
            field("Start Date Time";"Start Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'The start date and time of the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartDateTimeVisible;
            }
            field("End Date Time";"End Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'The end date and time of the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndDateTimeVisible;
            }
            field("Total Duration";"Total Duration")
            {
                ApplicationArea = All;
                ToolTip = 'The duration of the entry.';
                Enabled = IsTimeEntryEnabled;
                Editable = IsTimeEditable;
                Visible = IsTimeEntryEnabled;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SetEnabledOnOpen;
        IsTimeEditable := false;
    end;
      
    var
        TimeEntrySetup : Record DxsTimeEntrySetup;
        IsTimeEditable : Boolean;
        IsTimeEntryEnabled  : Boolean;
        IsStartTimeVisible : Boolean;
        IsEndTimeVisible : Boolean;
        IsStartDateTimeVisible : Boolean;
        IsEndDateTimeVisible : Boolean;

    local procedure SetEnabledOnOpen();
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
    end;
}
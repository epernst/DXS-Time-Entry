pageextension 62004 DxsJobLedgerEntries extends "Job Ledger Entries"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Start Time"; "DXS Start Time")
            {
                ApplicationArea = All;
                ToolTip = 'The start time of the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartTimeVisible;
            }
            field("End Time"; "DXS End Time")
            {
                ApplicationArea = All;
                ToolTip = 'The end time pf the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndTimeVisible;
            }
            field("Start Date Time"; "DXS Start Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'The start date and time of the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartDateTimeVisible;
            }
            field("End Date Time"; "DXS End Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'The end date and time of the entry.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndDateTimeVisible;
            }
            field("Total Duration"; "DXS Total Duration")
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
        TimeEntrySetup: Record DxsTimeEntrySetup;
        IsTimeEditable: Boolean;
        IsTimeEntryEnabled: Boolean;
        IsStartTimeVisible: Boolean;
        IsEndTimeVisible: Boolean;
        IsStartDateTimeVisible: Boolean;
        IsEndDateTimeVisible: Boolean;

    local procedure SetEnabledOnOpen();
    var
        TimePermissionHandler: Codeunit DxTimePermissionHandler;
    begin
        IsTimeEntryEnabled := TimePermissionHandler.IsSetupEnabled;
        if not TimeEntrySetup.Get then TimeEntrySetup.Init;
        IsEndDateTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show End Date-Times";
        IsEndTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show End Times";
        IsStartDateTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show Start Date-Times";
        IsStartTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show Start Times";
    end;
}
pageextension 62006 "DXS.Resource Journal" extends "Resource Journal"
{
    layout
    {
        modify("Resource No.")
        {
            trigger OnAfterValidate();
            begin
                UpdatePage();
            end;
        }

        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate();
            begin
                UpdatePage();
            end;
        }

        addafter("Unit of Measure Code")
        {
            field("Start Time"; "DXS.Start Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartTimeVisible;
            }
            field("End Time"; "DXS.End Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndTimeVisible;
            }
            field("Start Date Time"; "DXS.Start Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartDateTimeVisible;
            }
            field("End Date Time"; "DXS.End Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndDateTimeVisible;
            }
            field("Total Duration"; "DXS.Total Duration")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries the total duration will show here.';
                Enabled = IsTimeEntryEnabled;
                Editable = IsTimeEditable;
                Visible = IsTimeEntryEnabled;
                QuickEntry = true;
            }
        }
    }
    trigger OnOpenPage();
    begin
        SetEnabledOnOpen();
        UpdatePage();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        UpdatePage();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        InitStartEndTimes();
        UpdatePage();
    end;

    trigger OnAfterGetCurrRecord();
    begin
        UpdatePage();
    end;

    var
        TimeEntrySetup: Record "DXS.Time Entry Setup";
        IsTimeEditable: Boolean;
        IsTimeEntryEnabled: Boolean;
        IsStartTimeVisible: Boolean;
        IsEndTimeVisible: Boolean;
        IsStartDateTimeVisible: Boolean;
        IsEndDateTimeVisible: Boolean;

    local procedure UpdatePage();
    var
        HourlyUnitHandler: Codeunit "DXS.Hourly Unit Handler";
    begin
        IsTimeEditable := HourlyUnitHandler.IsHourlyUnit("Unit of Measure Code");
    end;

    local procedure SetEnabledOnOpen();
    var
        TimePermissionHandler: Codeunit "DXS.Time Permission Handler";
    begin
        IsTimeEntryEnabled := TimePermissionHandler.IsSetupEnabled();
        if not TimeEntrySetup.Get() then TimeEntrySetup.Init();
        IsEndDateTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show End Date-Times";
        IsEndTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show End Times";
        IsStartDateTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show Start Date-Times";
        IsStartTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show Start Times";
    end;
}

pageextension 62001 DxsJobPlanningLines extends "Job Planning Lines" 
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate();
            begin
                UpdatePage;
            end;
        }

        modify("Unit of Measure Code"){
            trigger OnAfterValidate();
            begin
                UpdatePage;
            end;
        }

        addafter(Reserve)
        {
            field("Start Time";"DXS Start Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartTimeVisible;
            }
            field("End Time";"DXS End Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndTimeVisible;
            }
            field("Start Date Time";"DXS Start Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartDateTimeVisible;
            }
            field("End Date Time";"DXS End Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndDateTimeVisible;
            }
            field("Total Duration";"DXS Total Duration")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries the total duration will show here.';
                Enabled = IsTimeEntryEnabled;
                Editable = IsTimeEditable;
                Visible = IsTimeEntryEnabled;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SetEnabledOnOpen;
        UpdatePage;
    end;
    
    trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    begin
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
        TimeEntrySetup : Record DxsTimeEntrySetup;
        IsTimeEditable : Boolean;
        IsTimeEntryEnabled  : Boolean;
        IsStartTimeVisible : Boolean;
        IsEndTimeVisible : Boolean;
        IsStartDateTimeVisible : Boolean;
        IsEndDateTimeVisible : Boolean;

    local procedure UpdatePage();
    var
        HourlyUnitHandler : Codeunit DxsHourlyUnitHandler;
    begin
        IsTimeEditable := HourlyUnitHandler.IsHourlyUnit("Unit of Measure Code");
    end;

    local procedure SetEnabledOnOpen();
    var 
        TimePermissionHandler : Codeunit DxsTimePermissionHandler;
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

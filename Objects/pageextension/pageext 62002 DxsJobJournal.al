pageextension 62002 DxsJobJournal extends "Job Journal"
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

        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate();
            begin
                UpdatePage;
            end;
        }

        addafter("Unit of Measure Code")
        {
            field("Start Time"; "DXS Start Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartTimeVisible;
            }
            field("End Time"; "DXS End Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndTimeVisible;
            }
            field("Start Date Time"; "DXS Start Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the start date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsStartDateTimeVisible;
            }
            field("End Date Time"; "DXS End Date Time")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries enter the end date-time here.';
                Editable = IsTimeEditable;
                Enabled = IsTimeEntryEnabled;
                Visible = IsEndDateTimeVisible;
            }
            field("Total Duration"; "DXS Total Duration")
            {
                ApplicationArea = All;
                ToolTip = 'For time based entries the total duration will show here.';
                Enabled = IsTimeEntryEnabled;
                Editable = IsTimeEditable;
                Visible = IsTimeEntryEnabled;
                QuickEntry = false;
            }
        }
        addfirst(FactBoxes)
        {
            part(JobJournalSummeryFactBox; DxsJobJournalSummaryFactBox)
            {
                ToolTip = 'Shows a summery of the current job and a job journal total.';
                Enabled = IsTimeEntryEnabled;
                ApplicationArea = All;
                SubPageLink =
                    "Journal Template Name" = FIELD ("Journal Template Name"),
                    "Journal Batch Name" = FIELD ("Journal Batch Name"),
                    "Line No." = FIELD ("Line No.");
                Visible = true;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SetEnabledOnOpen;
        UpdatePage;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        UpdatePage;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        InitStartEndTimes;
        UpdatePage;
    end;

    trigger OnAfterGetCurrRecord();
    begin
        UpdatePage;
    end;

    var
        TimeEntrySetup: Record DxsTimeEntrySetup;
        IsTimeEditable: Boolean;
        IsTimeEntryEnabled: Boolean;
        IsStartTimeVisible: Boolean;
        IsEndTimeVisible: Boolean;
        IsStartDateTimeVisible: Boolean;
        IsEndDateTimeVisible: Boolean;

    local procedure UpdatePage();
    var
        HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
    begin
        IsTimeEditable := HourlyUnitHandler.IsHourlyUnit("Unit of Measure Code");
    end;

    local procedure SetEnabledOnOpen();
    var
        TimePermissionHandler: Codeunit DxsTimePermissionHandler;
    begin
        IsTimeEntryEnabled := TimePermissionHandler.IsSetupEnabled;
        if not TimeEntrySetup.Get then TimeEntrySetup.Init;
        IsEndDateTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show End Date-Times";
        IsEndTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show End Times";
        IsStartDateTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show Start Date-Times";
        IsStartTimeVisible := IsTimeEntryEnabled and TimeEntrySetup."Show Start Times";
    end;
}

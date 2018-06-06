pageextension 62005 "DXSUnitsOfMeasure" extends "Units of Measure"
{
    layout
    {
        addbefore("International Standard Code")
        {
            field("Hourly Unit"; "DXS Hourly Unit")
            {
                ToolTip = 'Specify if this unit of measure is used as an hourly unit, for entry of start and end times in journals.';
                ApplicationArea = All;
                Visible = TimeEntryEnabled;
            }
            field("Time Rounding"; "DXS Time Rounding")
            {
                ToolTip = 'Specify how to round start and end time based entries. For example enter 0.25 to have 15 minutes as the minimum time to use.';
                ApplicationArea = All;
                Editable = IsHourlyUnit;
                Visible = TimeEntryEnabled;
            }
        }
    }
    actions
    {
        addlast(Navigation)
        {
            group(DxTimeEntry)
            {
                Caption = 'DXS Time';
                action("DXS DxTimeEntrySetup")
                {
                    AccessByPermission = TableData "DXS TimeEntrySetup" = R;
                    ApplicationArea = All;
                    Caption = 'Time Entry Setup';
                    Image = Setup;
                    RunPageMode = Edit;
                    RunObject = Page "DXS TimeEntrySetup";
                    ToolTip = 'Show the page setup of the DXS Time Entry App, which handles and enables entry of begin and end times in journals.';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        IsHourlyUnit := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        UpdatePage();
    end;

    trigger OnAfterGetCurrRecord();
    begin
        UpdatePage();
    end;

    var
        IsHourlyUnit: Boolean;
        TimeEntryEnabled: Boolean;

    local procedure UpdatePage();
    var
        TimeEntrySetup: Record "DXS TimeEntrySetup";
    begin
        TimeEntryEnabled := TimeEntrySetup.GetSetupIfEnabled();
        IsHourlyUnit := "DXS Hourly Unit";
    end;
}

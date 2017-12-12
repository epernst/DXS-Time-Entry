pageextension 62005 DxUnitsOfMeasure extends "Units of Measure"
{
    layout
    {
        addbefore("International Standard Code")
        {
            field("Hourly Unit";"Hourly Unit")
            {
                ToolTip = 'Specify if this unit of measure is used as an hourly unit, for entry of start and end times in journals.';
                ApplicationArea = All;
            }
            field("Time Rounding";"Time Rounding")
            {
                ToolTip = 'Specify how to round start and end time based entries. For example enter 0.25 to have 15 minutes as the minimum time to use.';
                ApplicationArea = All;          
                Editable = IsHourlyUnit;
                ShowMandatory = IsHourlyUnit;
            }
        }
    }
    actions
    {
        addlast(Navigation)
        {
            group(DxTimeEntry)
            {
                Caption = 'Dx365 Time';
                action(DxTimeEntrySetup)
                {
                    AccessByPermission = TableData DxsTimeEntrySetup=R;
                    ApplicationArea = All;
                    Caption = 'Time Entry Setup';
                    Image = Setup;
                    RunPageMode = Edit;
                    RunObject = Page DxTimeEntrySetup;
                    ToolTip = 'Show the page setup of the Dx365 Time Entry App, which handles and enables entry of begin and end times in journals.';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        IsHourlyUnit := false;
    end;
    
    trigger OnNewRecord(BelowxRec : Boolean);
    begin
        UpdatePage;
    end;

    trigger OnAfterGetCurrRecord();
    begin
        UpdatePage;
    end;
    
    var
        IsHourlyUnit : Boolean;

    local procedure UpdatePage();
    begin
        IsHourlyUnit := "Hourly Unit";  
    end;
}

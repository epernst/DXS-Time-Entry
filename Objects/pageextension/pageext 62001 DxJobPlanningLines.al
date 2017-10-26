pageextension 62001 DxJobPlanningLines extends "Job Planning Lines" 
{
    layout
    {
        modify("Unit of Measure Code"){
            trigger OnAfterValidate();
            begin
                UpdatePage;
            end;
        }

        addafter(Reserve)
        {
            field("Start Time";"Start Time")
            {
                ApplicationArea = All;
                Editable = IsTimeEditable;
            }
            field("End Time";"End Time")
            {
                ApplicationArea = All;
                Editable = IsTimeEditable;
            }
            field("Start Date Time";"Start Date Time")
            {
                ApplicationArea = All;
                Visible = false;
                Editable = IsTimeEditable;
            }
            field("End Date Time";"End Date Time")
            {
                ApplicationArea = All;
                Visible = false;
                Editable = IsTimeEditable;
            }
            field("Total Duration";"Total Duration")
            {
                ApplicationArea = All;
                Editable = IsTimeEditable;
            }
        }
    }
    trigger OnOpenPage();
    begin
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

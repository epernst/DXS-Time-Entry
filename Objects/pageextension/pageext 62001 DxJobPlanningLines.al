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
          Visible = false;
          Editable = IsTimeEditable;
          ApplicationArea = All;
        }
        field("End Date Time";"End Date Time")
        {
          Visible = false;
          Editable = IsTimeEditable;
          ApplicationArea = All;
        }
        field("Total Duration";"Total Duration")
        {
          Editable = IsTimeEditable;
          ApplicationArea = All;
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
        DxHourlyUnitHandler : Codeunit DxHourlyUnitHandler;
      begin
          exit(DxHourlyUnitHandler.IsUOMforHours("Unit of Measure Code"));
      end;

    local procedure UpdatePage();
      begin
        IsTimeEditable := GetTimeEditable;
      end;

}

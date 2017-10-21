pageextension 62001 DxJobPlanningLines extends "Job Planning Lines" 
{
    layout
    {
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
      IsTimeEditable := false;
    end;
    
    trigger OnNewRecord(BelowxRec : Boolean);
    begin
      IsTimeEditable := GetTimeEditable;  
    end;

    trigger OnAfterGetCurrRecord();
    begin
      IsTimeEditable := GetTimeEditable;  
    end;
    
    var
      IsTimeEditable : Boolean;

    local procedure GetTimeEditable() : Boolean;
      var
        JobUOM : Codeunit DxSpecialUnitHandler;
      begin
          exit(jobuom.IsUOMforHours("Unit of Measure Code"));
      end;

}


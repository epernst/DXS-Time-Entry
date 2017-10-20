pageextension 62002 JobJournalPage extends "Job Journal" 
{
  layout
  {
    addafter("Unit of Measure Code")
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
    addfirst(FactBoxes)
    {
      part(JobJournalSummeryFactBox;"Job Journal Summary FactBox")
      {
        ApplicationArea = All;
        SubPageLink = 
          "Journal Template Name"=FIELD("Journal Template Name"),
          "Journal Batch Name"=FIELD("Journal Batch Name"),
          "Line No."=FIELD("Line No.");
        Visible = true;
      }
    }
  }
  trigger OnOpenPage();
  begin
    IsTimeEditable := false;
  end;
  
  trigger OnNewRecord(BelowxRec : Boolean);
  begin
    InitJobTimes;
  end;

  trigger OnAfterGetCurrRecord();
  begin
    IsTimeEditable := GetTimeEditable;  
  end;
  
  var
    IsTimeEditable : Boolean;

  local procedure GetTimeEditable() : Boolean;
    var
      JobUOM : Codeunit SpecialUnitHandler;
    begin
        exit(jobuom.IsUOMforHours("Unit of Measure Code"));
    end;
}


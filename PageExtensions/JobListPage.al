pageextension 62003 DxJobListPage extends "Job List" 
{

  layout
  {
    addbefore("Job Details")
    {
      part("Job Summery";"Job Summary FactBox")
      {
        ApplicationArea = All;
        Caption = 'Job Summery';
        SubPageLink = "No."=FIELD("No.");
      }
    }
  }
}


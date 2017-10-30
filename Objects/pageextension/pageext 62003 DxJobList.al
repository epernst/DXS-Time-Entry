pageextension 62003 DxJobList extends "Job List" 
{
    layout
    {
        addbefore("Job Details")
        {
            part("Job Summery";DxJobSummaryFactBox)
            {
              ApplicationArea = All;
              Caption = 'Job Summery';
              SubPageLink = "No."=FIELD("No.");
            }
        }
    }
}


pageextension 62003 "DXSJobList" extends "Job List"
{
    layout
    {
        addbefore("Job Details")
        {
            part("Job Summery"; "DXS JobSummaryFactBox")
            {
                ApplicationArea = All;
                Caption = 'Job Summery';
                SubPageLink = "No." = FIELD ("No.");
            }
        }
    }
}


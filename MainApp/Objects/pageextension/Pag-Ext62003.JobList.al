pageextension 62003 "DXS.Job List" extends "Job List"
{
    layout
    {
        addbefore(Control1902018507)
        {
            part("Job Summery"; "DXS.Job Summary FactBox")
            {
                ApplicationArea = All;
                Caption = 'Job Summery';
                SubPageLink = "No." = FIELD ("No.");
            }
        }
    }
}


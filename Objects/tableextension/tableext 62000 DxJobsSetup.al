tableextension 62000 DxJobsSetup extends "Jobs Setup"
{

    fields
    {
        field(62003;"After Midnight Action";Option)
        {
            OptionMembers=NextDay,Error;
            OptionCaption='Next Day,Errors';  
        }
    }

}
table 62001 DxTimeHelpResource
{
    Caption = 'Dx365 Time Help Resource';
    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Url; Text[250])
        {
            Caption = 'Url';
            ExtendedDatatype = URL;
        }
        field(3; Icon; Media)
        {
            Caption = 'Icon';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}


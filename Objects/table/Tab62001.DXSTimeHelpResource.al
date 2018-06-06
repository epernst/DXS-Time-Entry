table 62001 "DXS TimeHelpResource"
{
    Caption = 'DXS Time Help Resource';
    DataPerCompany = false;

    fields
    {
        field(1;"Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2;"Url"; Text[250])
        {
            Caption = 'Url';
            ExtendedDatatype = URL;
        }
        field(3;"Icon"; Media)
        {
            Caption = 'Icon';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}


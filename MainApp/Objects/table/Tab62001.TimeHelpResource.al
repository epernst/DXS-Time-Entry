table 62001 "DXS.Time Help Resource"
{
    Caption = 'DXS Time Help Resource';
    DataPerCompany = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Url"; Text[250])
        {
            Caption = 'Url';
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(3; "Icon"; Media)
        {
            Caption = 'Icon';
            DataClassification = CustomerContent;
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


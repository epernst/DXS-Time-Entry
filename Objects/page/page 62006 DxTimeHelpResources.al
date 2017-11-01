page 62006 DxTimeHelpResources
{
    Caption = 'Dx365 Time Help Resources';
    Editable = false;
    PageType = List;
    SourceTable = DxTimeHelpResource;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {
                    ApplicationArea = All;
                }
                    field(Url;Url)
                {
                    ApplicationArea = All;
                }
                field(Icon;Icon)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    var
        ResourceHelper : Codeunit DxTimeResourceHelper;
    begin
        ResourceHelper.InitializeResources;
    end;
}


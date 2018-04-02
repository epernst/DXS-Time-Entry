page 62006 DxsTimeHelpResources
{
    Caption = 'DXS Time Help Resources';
    Editable = false;
    PageType = List;
    SourceTable = DxsTimeHelpResource;

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
        ResourceHelper : Codeunit DxsTimeResourceHelper;
    begin
        ResourceHelper.InitializeResources();
    end;
}

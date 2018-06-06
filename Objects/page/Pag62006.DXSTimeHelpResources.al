page 62006 "DXS TimeHelpResources"
{
    Caption = 'DXS Time Help Resources';
    Editable = false;
    PageType = List;
    SourceTable = "DXS TimeHelpResource";

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
        ResourceHelper : Codeunit "DXS TimeResourceHelper";
    begin
        ResourceHelper.InitializeResources();
    end;
}

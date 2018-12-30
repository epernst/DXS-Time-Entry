page 62006 "DXS.Time Help Resources"
{
    Caption = 'DXS Time Help Resources';
    Editable = false;
    PageType = List;
    SourceTable = "DXS.Time Help Resource";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Url; Url)
                {
                    ApplicationArea = All;
                }
                field(Icon; Icon)
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
        ResourceHelper: Codeunit "DXS.Time Resource Helper";
    begin
        ResourceHelper.InitializeResources();
    end;
}

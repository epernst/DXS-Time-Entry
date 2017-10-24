page 62000 DxTimeEntrySetup
{
    PageType = Card;
    SourceTable = DxTimeEntrySetup;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML=ENU='General';
                field("Time Based Entries Enabled";"Time Based Entries Enabled")
                {
                }
                field("Hourly Units Only";"Hourly Units Only")
                {
                    
                }
                field("Allow Entries to Pass Midnight";"Allow Entries to Pass Midnight")
                {
                }
                field("Fields To Show";"Fields To Show")
                {
                    trigger OnValidate();
                    begin
                        UpdatePage;
                    end;
                }
                group(ShowMix)
                {
                    Visible = IsMixSelected;
                    field("Show Start Times";"Show Start Times")
                    {
                    }
                    field("Show End Times";"Show End Times")
                    {
                    }
                    field("Show Start Date-Times";"Show Start Date-Times")
                    {
                    }
                    field("Show End Date-Times";"Show End Date-Times")
                    {
                    }
                }
            }
        }
    }

    var
        IsMixSelected : Boolean;

    trigger OnOpenPage();
    begin
        InitSetupRecord;
        UpdatePage;
    end;

    procedure UpdatePage();
    begin
        IsMixSelected := "Fields To Show" = "Fields To Show"::Mix;
    end;

    procedure InitSetupRecord();
    begin
        If not get then begin
            Init;
            Insert;
        end;
    end;
}

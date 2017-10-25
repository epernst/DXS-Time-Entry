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
                    ApplicationArea = All;
                }
                field("Hourly Units Only";"Hourly Units Only")
                {
                    ApplicationArea = All;
                }
                field("Allow Entries to Pass Midnight";"Allow Entries to Pass Midnight")
                {
                    ApplicationArea = All;
                }
                field("Fields To Show";"Fields To Show")
                {
                    ApplicationArea = All;
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
                        ApplicationArea = All;
                    }
                    field("Show End Times";"Show End Times")
                    {
                        ApplicationArea = All;
                    }
                    field("Show Start Date-Times";"Show Start Date-Times")
                    {
                        ApplicationArea = All;
                    }
                    field("Show End Date-Times";"Show End Date-Times")
                    {
                        ApplicationArea = All;
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

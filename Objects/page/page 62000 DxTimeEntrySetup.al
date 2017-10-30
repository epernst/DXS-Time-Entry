page 62000 DxTimeEntrySetup
{
    Caption = 'Dx365 Time Entry Setup';
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
                Caption = 'General';
                field("Time Based Entries Enabled";"Time App Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enables the app. If not enabled, then the start and end times cannot be entered and will to be shown.';
                }
                field("Hourly Units Only";"Hourly Units Only")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow only time entry on lines using unit of measure codes marked as "Hourly Units".';
                    trigger OnValidate();
                    begin
                        if "Hourly Units Only" then
                            NoHourlyUnitsSetupNotification;
                    end;
                }
                field("Default Time Rounding";"Default Time Rounding")
                {
                    ToolTip = 'Specify how to round start and end time based entries. For example enter 0.25 to have 15 minutes as the minimum time to use. The field is mandatory if "Hourly Units Only" has not been selected.';
                    ApplicationArea = All;          
                    ShowMandatory = not HourlyUnitsOnly;
                }
                field("Allow Entries to Pass Midnight";"Allow Entries to Pass Midnight")
                {
                    ApplicationArea = All;
                    ToolTip = 'May a ending time pass midnigth, or may stretch over multiple days?';
                }
                field("Fields To Show";"Fields To Show")
                {
                    ApplicationArea = All;
                    ToolTip = 'Which start and end times should be visible? Only regular times (i.e. 12:00) or Date-Times. If you allow entries to pass midnight or stretch over mulitiple days, then Date-Times are recommended.';
                    trigger OnValidate();
                    begin
                        UpdatePage;
                    end;
                }
                group(ShowMix)
                {
                    Caption = '';
                    Visible = IsMixSelected;
                    field("Show Start Times";"Show Start Times")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Show Start Times i.e. "8:00 AM".';
                    }
                    field("Show End Times";"Show End Times")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Show End Times i.e. "6:00 PM".';
                    }
                    field("Show Start Date-Times";"Show Start Date-Times")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Show Start Date-Times i.e. "2018-05-12 8:00".';
                    }
                    field("Show End Date-Times";"Show End Date-Times")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Show Start Date-Times i.e. "2018-05-13 11:00".';
                    }
                }
            }
            group(Registration)
            {
                Caption = 'Registration';
                field("Registration E-Mail Address";"Registration E-Mail Address")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'The Time Entry App will be registered on this E-Mail Address. When registering the registration key will be sent to this E-Mail Address.';
                }
                field("Registration Id";"Registration Id")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'The registration id will be recived by email, after registration. Without this Id, then the App will remain in trail mode.';
                }
                field("Next Registration Verification";"Next Registration Verification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows when the registration needs to be renewed.';
                }
            }
        }
    }

    var
        HourlyUnitsOnly : Boolean;
        IsMixSelected : Boolean;

    trigger OnOpenPage();
    begin
        InitSetupRecord;
        NoHourlyUnitsSetupNotification;
        UpdatePage;
    end;

    procedure UpdatePage();
    begin
        IsMixSelected := "Fields To Show" = "Fields To Show"::Mix;
        HourlyUnitsOnly := "Hourly Units Only";  
    end;

    procedure InitSetupRecord();
    begin
        If not get then begin
            Init;
            Insert;
        end;
    end;

}

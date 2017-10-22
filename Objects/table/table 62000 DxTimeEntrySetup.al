table 62000 DxTimeEntrySetup
{
    Caption = 'Time Entry Setup';
    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Time Based Entries Enabled";Boolean)
        {
            Caption='Time Based Entries Enabled';
            trigger OnValidate();
            var
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not "Time Based Entries Enabled" then exit;
                VerifySetupBeforeEnabling(true);
            end;
        }
        field(3;"Hourly Units Only";Boolean)
        {
            Caption = 'Hourly Units Only';
        }
        field(4;"Allow Entries to Pass Midnight";Boolean)
        {
            Caption = 'Allow Entries to Pass Midnight';
        }
        field(5;"Fields To Show";Option)
        {
            Caption = 'Fields To Show';

            OptionMembers=Times,DateTimes,Both,Mix;
            OptionCaption='Times,Date-Times,Both,Mix';  
            trigger OnValidate();
            begin
                if ("Fields To Show" = xrec."Fields To Show") and
                    ("Fields To Show" = "Fields To Show"::Mix) 
                then 
                    exit;

                "Show Start Times" := false;
                "Show End Times" := false;
                "Show Start Date-Times" := false;
                "Show End Date-Times" := false;
                case "Fields To Show" of
                  "Fields To Show"::Times : 
                    begin
                        "Show Start Times" := true;
                        "Show End Times" := true;
                    end;
                  "Fields To Show"::DateTimes : 
                    begin
                        "Show Start Date-Times" := true;
                        "Show End Date-Times" := true;
                    end;
                  "Fields To Show"::Both : 
                    begin
                        "Show Start Times" := true;
                        "Show End Times" := true;
                        "Show Start Date-Times" := true;
                        "Show End Date-Times" := true;
                    end;                    
                end;
            end;
        }
        field(6;"Show Start Times";Boolean)
        {
        }
        field(7;"Show End Times";Boolean)
        {
        }
        field(8;"Show Start Date-Times";Boolean)
        {
        }
        field(9;"Show End Date-Times";Boolean)
        {
        }
        
    }
    keys
    {
        key(PK;"Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

    var
        NoHourlyUnitsCannotEnableErr : Label 'You need to setup at least one %1 as an %2, before you can enable time based entries.';

    local procedure VerifySetupBeforeEnabling(ShowError : Boolean) : Boolean;
    var
        HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
    begin
        if "Hourly Units Only" and (not HourlyUnitHandler.HourlyUnitExits) then begin
            if ShowError then
                error('You need to setup at least one %1 as an %2.');
            exit(false);
        end;
        exit(true);
    end;

}
 
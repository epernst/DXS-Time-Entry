table 62000 DxTimeEntrySetup
{
    Caption = 'Time Entry Setup';
    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2;"Time App Enabled";Boolean)
        {
            Caption = 'Time App Enabled';
            trigger OnValidate();
            var
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
                AssistedSetup : Record "Assisted Setup";
            begin
                if not "Time App Enabled" then exit;
                VerifySetupBeforeEnabling(true);
                Status := Status::Completed;
                AssistedSetup.SetStatus(PAGE::DxTimeEntrySetupWizard,AssistedSetup.Status::Completed);
            end;
        }
        field(3;"Hourly Units Only";Boolean)
        {
            Caption = 'Hourly Units Only';
        }
        field(4;"Allow Entries to Pass Midnight";Option)
        {
            Caption = 'Allow Entries to Pass Midnight';
            OptionMembers= No,NextDay,MultipleDays;
            OptionCaption = 'No,Yes - Next Day,Yes - Multiple Days';
        }
        field(5;"Fields To Show";Option)
        {
            Caption = 'Fields To Show';
            OptionMembers = Times,"Date Times",Both,Mix;
            OptionCaption = 'Times,Date-Times,Both,Mix';  
            trigger OnValidate();
            begin
                if ("Fields To Show" = xrec."Fields To Show") and
                    ("Fields To Show" = "Fields To Show"::Mix) 
                then 
                    exit;
                InitShowFields;
            end;
        }
        field(6;"Show Start Times";Boolean)
        {
            Caption = 'Show Start Times';
        }
        field(7;"Show End Times";Boolean)
        {
            Caption = 'Show End Times';
        }
        field(8;"Show Start Date-Times";Boolean)
        {
            Caption = 'Show Start Date-Times';
        }
        field(9;"Show End Date-Times";Boolean)
        {
            Caption = 'Show End Date-Times';
        }
        field(12;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Not Completed,Completed,Not Started,Seen,Watched,Read, ';
            OptionMembers = "Not Completed",Completed,"Not Started",Seen,Watched,Read," ";
        }
        field(30;"Registration E-Mail Address";Text[50])
        {
            Caption = 'Registration E-Mail Address';
        }
        field(31;"Installation Id";Guid)
        {
            Caption = 'Installation Id';
        }
        field(32;"Registration Id";Guid)
        {
            Caption = 'Registration Id';
        }
        field(33;"Next Registration Verification";DateTime)
        {
            Caption = 'Next Registration Verification';
            Editable = false;
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
        NoHourlyUnitsCannotEnableErr : Label 'You need to setup at least one unit of measure as an Hourly Unit, before you can enable the Time Entry App.';
        NoRegistrationEmailAddressErr : Label 'You need to enter a valid email adress, before you can enable the app.';

    procedure GetSetupIfEnabled() : Boolean;
    begin
        exit(Get and "Time App Enabled");
    end;

    local procedure VerifySetupBeforeEnabling(ShowError : Boolean) : Boolean;
    var
        HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
    begin
        if "Hourly Units Only" and (not HourlyUnitHandler.HourlyUnitExits) then begin
            if ShowError then
                error(NoHourlyUnitsCannotEnableErr);
            exit(false);
        end;
        if "Registration E-Mail Address" = '' then begin
            if ShowError then
                Error(NoRegistrationEmailAddressErr);
            exit(false);
        end;
        exit(true);
    end;

    local procedure InitShowFields();
    begin
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
            "Fields To Show"::"Date Times" : 
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

    procedure CreateHourlyNotificationIfNoSetup();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

}

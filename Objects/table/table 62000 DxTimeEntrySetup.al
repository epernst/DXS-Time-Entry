table 62000 DxsTimeEntrySetup
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
                if "Time App Enabled" then begin
                    VerifySetupBeforeEnabling(GuiAllowed);
                    Status := Status::Completed; 
                    if "First Enabled Date" = 0DT then
                        "First Enabled Date" := CurrentDateTime;
                end else 
                    Status := status::"Not Completed";
                
                AssistedSetup.SetStatus(Page::DxTimeEntrySetupWizard,Status);
            end;
        }
        field(3;"Hourly Units Only";Boolean)
        {
            Caption = 'Hourly Units Only';
        }
        field(4;"Allow Entries to Pass Midnight";Option)
        {
            Caption = 'Allow Entries to Pass Midnight';
            OptionMembers = No,NextDay,MultipleDays;
            OptionCaption = 'No,Yes - Next Day,Yes - Multiple Days';
        }
        field(5;"Fields To Show";Option)
        {
            Caption = 'Fields To Show';
            OptionMembers = Times,"Date Times",Both,Mix;
            OptionCaption = 'Times,Date and Times,Both,Mix';  
            trigger OnValidate();
            begin
                if ("Fields To Show" = xrec."Fields To Show") or
                    ("Fields To Show" = "Fields To Show"::Mix) 
                then 
                    exit;
                InitShowFields;
            end;
        }
        field(6;"Show Start Times";Boolean)
        {
            Caption = 'Show Start Times';
            InitValue = true;
        }
        field(7;"Show End Times";Boolean)
        {
            Caption = 'Show End Times';
            InitValue = true;
        }
        field(8;"Show Start Date-Times";Boolean)
        {
            Caption = 'Show Start Date-Times';
        }
        field(9;"Show End Date-Times";Boolean)
        {
            Caption = 'Show End Date-Times';
        }
        field(10;"First Enabled Date";DateTime)
        {
            Caption = 'First Enabled Date';
            Editable = false;
        }
        field(12;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Not Completed,Completed,Not Started,Seen,Watched,Read, ';
            OptionMembers = "Not Completed",Completed,"Not Started",Seen,Watched,Read," ";
        }
        field(20;"Default Time Rounding";Decimal)
        {
            Caption = 'Default Time Rounding';
            InitValue = 0.25;

            trigger OnValidate();
            begin                 
                if ("Default Time Rounding" = 0) and (not "Hourly Units Only") then 
                    error(RoundingMustBeEnteredErr,FieldCaption("Default Time Rounding"),FieldCaption("Hourly Units Only"));
            end;
        }
        field(30;"Registration E-Mail Address";Text[50])
        {
            Caption = 'Registration E-Mail Address';
            trigger OnValidate();
            begin 
                if "Registration E-Mail Address" = xRec."Registration E-Mail Address" then exit;
                if (xRec."Registration E-Mail Address" <> '') then
                    if not Confirm(ChangeRegistrationQst,false,FieldCaption("Registration E-Mail Address"),FieldCaption("Registration Id")) then
                        error('');
                ValidateRegistration; 
            end;
        }
        field(31;"Installation Id";Guid)
        {
            Caption = 'Installation Id';
            trigger OnValidate();
            begin 
                ValidateRegistration; 
            end;
        }
        field(32;"Registration Id";Guid)
        {
            Caption = 'Registration Id';
            trigger OnValidate();
            begin 
                ValidateRegistration; 
            end;
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
        RoundingMustBeEnteredErr : Label '%1 must be specified when %2 is selected. For example 0.25 will round to 15 minutes.';
        ChangeRegistrationQst : Label 'Changing the %1, without changing the assosicated %2, may cause the app to stop working.';
    
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

    procedure NoHourlyUnitsSetupNotification();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    procedure ValidateRegistration() : Boolean;
    begin
        if ("Registration E-Mail Address" <> '') and
            ("Registration Id" <> '') and
            ("Installation Id" <> '') 
        then
            exit(true);
        exit(false);
    end;

    procedure GetRegistrationStatus() : Option Ok,Trial,Expires,Expired;
    begin
        if ("Registration E-Mail Address" <> '') and
            ("Registration Id" <> '') and
            ("Installation Id" <> '') 
        then
            exit(0);
        if "Next Registration Verification" > CurrentDateTime then
            exit(3);
        exit(1);
    end;

    procedure NoValidRegistrationNotification();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateNotificationIfInvalidRegistration;
    end;
}
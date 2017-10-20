codeunit 62007 HourUOMSetupNotification
{
    trigger OnRun();
    begin
    end;
    
    var
        NoHourUnitOfMeasureNotificationLbl : Label 'No Hour Setup';
        NoHourUnitOfMeasureNotificationMsg : Label 'No unit of measure codes have been setup to support time based entry.';
        
        NoHourUnitOfMeasureAction : Label 'Setup an hourly based unit of measure code.';

    [EventSubscriber(ObjectType::Page, 201, 'OnOpenPageEvent', '', false, false)]
    procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    begin
        CreateHourNotificationIfNoSetup;
    end;
    procedure GetNoHourUnitOfMeasureNotoficationID() : Guid;
    begin
        exit('ce5c533b-2d86-4325-96be-db10dca9857b');        
    end;
    procedure GetNoKMUnitOfMeasureNotoficationID() : Guid;
    begin
        exit('75adeccf-73f0-404f-94a2-f7cdfcf0f721');        
    end;

    local procedure CreateHourNotificationIfNoSetup();
    var
        SpecialUnitHandler : Codeunit SpecialUnitHandler;
    begin
        if SpecialUnitHandler.GetUnitOfMeasureHour then exit;
        CreateHourSetupNotification;
    end;
    local procedure CreateHourSetupNotification();
    var
        SpecialUnitHandler : Codeunit SpecialUnitHandler;
        MyNotifications : Record "My Notifications";
        HourNotification : Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotoficationID) then exit;
        with HourNotification do begin
            id := GetNoHourUnitOfMeasureNotoficationID;
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoHourUnitOfMeasureAction,Codeunit::HourUOMSetupNotification,'')
        end;

        
    end;
    local procedure HourSetupNotification();
    var
        SpecialUnitHandler : Codeunit SpecialUnitHandler;
        MyNotifications : Record "My Notifications";
        HourNotification : Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotoficationID) then exit;
        with HourNotification do begin
            id := GetNoHourUnitOfMeasureNotoficationID;
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoHourUnitOfMeasureAction,Codeunit::HourUOMSetupNotification,'')
        end;
    end;


}
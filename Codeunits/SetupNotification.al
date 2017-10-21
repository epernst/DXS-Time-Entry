codeunit 62007 HourUOMSetupNotification
{
    trigger OnRun();
    begin
    end;
    
    var
        NoHourUnitOfMeasureNotificationLbl : Label 'No Hour Setup';
        NoHourUnitOfMeasureNotificationMsg : Label 'No unit of measure codes have been setup to support time based entry.';
        NoHourUnitOfMeasureSetupAct : Label 'Setup an hourly based unit of measure code.';
        NoHourUnitOfMeasureSetupName : Label 'Hour unit of measure etup.';
        NoHourUnitOfMeasureSetupDesc : Label 'Warns if no hourly unit of measure codes have been setup.';
        DismissFurtherNotificationsAct : Label 'Dont show this notification again.';
        
    [EventSubscriber(ObjectType::Page, 201, 'OnOpenPageEvent', '', false, false)]
    procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    begin
        CreateHourNotificationIfNoSetup;
    end;
    procedure GetNoHourUnitOfMeasureNotificationId() : Guid;
    begin
        exit('ce5c533b-2d86-4325-96be-db10dca9857b');        
    end;
    procedure GetNoKMUnitOfMeasureNotificationId() : Guid;
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
        NotificationLifecycleMgt : Codeunit "Notification Lifecycle Mgt.";
        MyNotifications : Record "My Notifications";
        HourNotification : Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotificationId) then exit;
        with HourNotification do begin
            id := GetNoHourUnitOfMeasureNotificationId;
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoHourUnitOfMeasureSetupAct,Codeunit::HourUOMSetupNotification,'SetupHourUnitOfMeasure');
            AddAction(DismissFurtherNotificationsAct,Codeunit::HourUOMSetupNotification,'DismissNotification');
            Send;
        end;
    end;
    local procedure SetupHourUnitOfMeasure();
    var
        UnitOfMeasurePage : Page "Units of Measure";
        SpecialUnitHandler : Codeunit SpecialUnitHandler;
        MyNotifications : Record "My Notifications";
        HourNotification : Notification;
    begin
        UnitOfMeasurePage.RunModal;
    end;

    local procedure DismissNotification(NotificationID : Guid);
    var
        MyNotifications : Record "My Notifications";
        HourNotification : Notification;
    begin
        if not MyNotifications.Disable(NotificationID) THEN
        case NotificationID of
            GetNoHourUnitOfMeasureNotificationId:
                MyNotifications.InsertDefault(NotificationID,NoHourUnitOfMeasureSetupName,NoHourUnitOfMeasureSetupDesc,false);
        end;
    end;

}
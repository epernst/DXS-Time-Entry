codeunit 62008 DxJobNotificationHandler
{
    trigger OnRun();
    begin
    end;
    
    var
        NoHourUnitOfMeasureNotificationLbl : Label 'No Hour Setup';
        NoHourUnitOfMeasureNotificationMsg : Label 'No unit of measure codes have been setup to support time based entry.';
        NoHourUnitOfMeasureSetupAct : Label 'Setup an hourly based unit of measure code.';
        NoHourUnitOfMeasureSetupName : Label 'Hour unit of measure setup.';
        NoHourUnitOfMeasureSetupDesc : Label 'Warns if no hourly unit of measure codes have been setup.';
        DismissFurtherNotificationsAct : Label 'Dont show this notification again.';
           
    procedure CreateHourNotificationIfNoSetup();
    var
        SpecialUnitHandler : Codeunit DxSpecialUnitHandler;
    begin
        if SpecialUnitHandler.GetUnitOfMeasureHour then exit;
        CreateHourSetupNotification;
    end;

    local procedure CreateHourSetupNotification();
    var
        SpecialUnitHandler : Codeunit DxSpecialUnitHandler;
        MyNotifications : Record "My Notifications";
        HourNotification : Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotificationId) then exit;
        with HourNotification do begin
            id := GetNoHourUnitOfMeasureNotificationId;
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoHourUnitOfMeasureSetupAct,Codeunit::DxJobNotificationHandler,'RunSetupHourUnitOfMeasure');
            AddAction(DismissFurtherNotificationsAct,Codeunit::DxJobNotificationHandler,'DismissNotification');
            Send;
        end;
    end;
    
    procedure RunSetupHourUnitOfMeasure(HourNotification : Notification);
    var
        UnitOfMeasurePage : Page "Units of Measure";
    begin
        UnitOfMeasurePage.RunModal;
    end;

    procedure DismissNotification(HourNotification : Notification);
    var
        MyNotifications : Record "My Notifications";
    begin
        if not MyNotifications.Disable(HourNotification.Id) then
        case HourNotification.Id of
            GetNoHourUnitOfMeasureNotificationId:
                NoHourUnitOfMeasureNotificationDefaultState(FALSE);
        end;
    end;

    local procedure RecallNotification(HourNotification : Notification);
    var
        MyNotifications : Record "My Notifications";
    begin
        if not MyNotifications.Disable(HourNotification.Id) then exit;

        HourNotification.Recall;
    end;

    procedure NoHourUnitOfMeasureNotificationDefaultState(TurnOn : Boolean);
    var
        MyNotifications : Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetNoHourUnitOfMeasureNotificationId,NoHourUnitOfMeasureSetupName,NoHourUnitOfMeasureSetupDesc,TurnOn);
    end;

   procedure GetNoHourUnitOfMeasureNotificationId() : Guid;
    begin
        exit('ce5c533b-2d86-4325-96be-db10dca9857b');        
    end;
    
    procedure GetNoKMUnitOfMeasureNotificationId() : Guid;
    begin
        exit('75adeccf-73f0-404f-94a2-f7cdfcf0f721');        
    end;

}
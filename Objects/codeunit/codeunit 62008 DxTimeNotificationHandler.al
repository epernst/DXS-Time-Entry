codeunit 62008 DxTimeNotificationHandler
{
    trigger OnRun();
    begin
    end;
    
    var
        NoSetupNotificationLbl : Label 'No Time Entry Setup';
        NoSetupNotificationMsg : Label 'Time Entry has been installed, but setup has not been enabled.';
        NoSetupNotificationAct : Label 'Enable now.';
        NoSetupNotificationName : Label 'Time Entry Setup.';
        NoSetupNotificationDesc : Label 'Warns if Dx Time Entry extension have been installed, but not been enabled.';
        NoHourUnitOfMeasureNotificationLbl : Label 'No Hourly Unit Setup';
        NoHourUnitOfMeasureNotificationMsg : Label 'No Hourly Unit of Measure Codes have been setup to support time based entry.';
        NoHourUnitOfMeasureSetupAct : Label 'Select or create hourly based Unit of Measure codes.';
        NoHourUnitOfMeasureSetupName : Label 'Hourly Unit of Measure Setup.';
        NoHourUnitOfMeasureSetupDesc : Label 'Warns if no Hourly Unit of Measure codes have been setup.';
        WatchVideoNotificationAct : Label 'Watch video help.';
        DismissFurtherNotificationsAct : Label 'Dont show this message again.';

    procedure CreateSetupNotificationIfNoSetup();
    var
        TimePermissionHandler : Codeunit DxTimePermissionHandler;
    begin
        if TimePermissionHandler.IsSetupEnabled then exit;
        if not TimePermissionHandler.CanChangeTimeSetup then exit;

        CreateSetupNotification;
    end;

    local procedure CreateSetupNotification();
    var
        MyNotifications : Record "My Notifications";
        TimePermissionHandler : Codeunit DxTimePermissionHandler;
        HourNotification : Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoSetupNotificationId) then exit;

        with HourNotification do begin
            Id := GetNoSetupNotificationId;
            Message := NoSetupNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoSetupNotificationAct,Codeunit::DxTimeNotificationHandler,'EnableTimeEntrySetup');
            AddAction(DismissFurtherNotificationsAct,Codeunit::DxTimeNotificationHandler,'DismissNotification');
            Send;
        end;
    end;

    procedure CreateHourlyNotificationIfNoSetup();
    var
        TimePermissionHandler : Codeunit DxTimePermissionHandler;
        TimeEntrySetup : Record DxTimeEntrySetup;
        SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
    begin
        if not TimePermissionHandler.IsSetupEnabled then exit;
        if not TimeEntrySetup."Hourly Units Only" then exit;
        if SpecialUnitHandler.HourlyUnitExits then exit;
        CreateHourlySetupNotification;
    end;

    local procedure CreateHourlySetupNotification();
    var
        SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
        MyNotifications : Record "My Notifications";
        UnitOfMeasure : Record "Unit of Measure";
        HourNotification : Notification;
    begin
        if not UnitOfMeasure.WritePermission then exit;
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotificationId) then exit;
        with HourNotification do begin
            Id := GetNoHourUnitOfMeasureNotificationId;
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoHourUnitOfMeasureSetupAct,Codeunit::DxTimeNotificationHandler,'RunSetupHourUnitOfMeasure');
            AddAction(DismissFurtherNotificationsAct,Codeunit::DxTimeNotificationHandler,'DismissNotification');
            Send;
        end;
    end;
    
    procedure EnableTimeEntrySetup(HourNotification : Notification);
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
        TimeEntrySetupPage : Page "Units of Measure";
    begin
        message('Running Time Entry Setup Wizard');        
    end;

    procedure RunSetupHourUnitOfMeasure(HourNotification : Notification);
    var
        UnitOfMeasurePage : Page "Units of Measure";
    begin
        UnitOfMeasurePage.RunModal;
    end;

    procedure DismissNotification(TimeNotification : Notification);
    var
        MyNotifications : Record "My Notifications";
    begin
        if not MyNotifications.Disable(TimeNotification.Id) then
        case TimeNotification.Id of
            GetNoHourUnitOfMeasureNotificationId:
                NoHourUnitOfMeasureNotificationDefaultState(false);
            GetNoSetupNotificationId :
                NoSetupNotificationDefaultState(false);
        end;
    end;

    local procedure RecallNotification(HourNotification : Notification);
    var
        MyNotifications : Record "My Notifications";
    begin
        if not MyNotifications.Disable(HourNotification.Id) then exit;

        HourNotification.Recall;
    end;

    procedure NoSetupNotificationDefaultState(TurnOn : Boolean);
    var
        MyNotifications : Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetNoSetupNotificationId,NoSetupNotificationName,NoSetupNotificationDesc,TurnOn);
    end;
    
    procedure NoHourUnitOfMeasureNotificationDefaultState(TurnOn : Boolean);
    var
        MyNotifications : Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetNoHourUnitOfMeasureNotificationId,NoHourUnitOfMeasureSetupName,NoHourUnitOfMeasureSetupDesc,TurnOn);
    end;

    local procedure GetNoHourUnitOfMeasureNotificationId() : Guid;
    begin
        exit('ce5c533b-2d86-4325-96be-db10dca9857b');        
    end;
    
    local procedure GetNoSetupNotificationId() : Guid;
    begin
        exit('75adeccf-73f0-404f-94a2-f7cdfcf0f721');        
    end;
}
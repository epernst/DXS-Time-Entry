codeunit 62008 DxTimeNotificationHandler
{
    trigger OnRun();
    begin
    end;
    
    var
        NoSetupNotificationLbl : Label 'Dx Time - App Not Enabled';
        NoSetupNotificationMsg : Label 'Dx Time - App has been installed, but it has not been setup and enabled.';
        NoSetupNotificationAct : Label 'Enable now.';
        NoSetupNotificationName : Label 'Dx Time Entry App not enabled.';
        NoSetupNotificationDesc : Label 'Warns if Dx Time App have been installed, but not been setup and enabled.';
        NoHourUnitOfMeasureNotificationLbl : Label 'No Hourly Unit Setup';
        NoHourUnitOfMeasureNotificationMsg : Label 'No Hourly Unit of Measure Codes have been setup to support time based entry.';
        NoHourUnitOfMeasureSetupAct : Label 'Select or create hourly based Unit of Measure codes.';
        NoHourUnitOfMeasureSetupName : Label 'Dx Time - Hourly Unit of Measure Setup missing.';
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
        TimeNotification : Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoSetupNotificationId) then exit;

        with TimeNotification do begin
            Id := GetNoSetupNotificationId;
            Message := NoSetupNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoSetupNotificationAct,Codeunit::DxTimeNotificationHandler,'RunAssistedSetup');
            AddAction(DismissFurtherNotificationsAct,Codeunit::DxTimeNotificationHandler,'DismissNotification');
            Send;
        end;
    end;

    procedure CreateHourlyNotificationIfNoSetup();
    var
        TimePermissionHandler : Codeunit DxTimePermissionHandler;
        TimeEntrySetup : Record DxTimeEntrySetup;
        HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
    begin
        if not TimePermissionHandler.IsSetupEnabled then exit;
        if not TimeEntrySetup."Hourly Units Only" then exit;
        if HourlyUnitHandler.HourlyUnitExits then exit;
        CreateHourlySetupNotification;
    end;

    local procedure CreateHourlySetupNotification();
    var
        HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
        MyNotifications : Record "My Notifications";
        UnitOfMeasure : Record "Unit of Measure";
        TimeNotification : Notification;
    begin
        if not UnitOfMeasure.WritePermission then exit;
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotificationId) then exit;
        with TimeNotification do begin
            Id := GetNoHourUnitOfMeasureNotificationId;
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := Scope::LocalScope;
            AddAction(NoHourUnitOfMeasureSetupAct,Codeunit::DxTimeNotificationHandler,'RunSetupHourUnitOfMeasure');
            AddAction(DismissFurtherNotificationsAct,Codeunit::DxTimeNotificationHandler,'DismissNotification');
            Send;
        end;
    end;
    
    procedure RunAssistedSetup(TimeNotification : Notification);
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
        TimeEntrySetupWizard : Page DxTimeEntrySetupWizard;
    begin
        TimeEntrySetupWizard.RunModal;
    end;

    procedure RunSetupHourUnitOfMeasure(TimeNotification : Notification);
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

    local procedure RecallNotification(TimeNotification : Notification);
    var
        MyNotifications : Record "My Notifications";
    begin
        if not MyNotifications.Disable(TimeNotification.Id) then exit;

        TimeNotification.Recall;
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

    local procedure AppTrialExpiredNotificationId() : Guid;
    begin
        exit('ad92ae2c-dbed-49ff-aa0c-5998f08b49f1');        
    end;
    local procedure AppRegistrationRequiredNotificationId() : Guid;
    begin
        exit('686f522d-6d91-4611-98e9-eec52ecbdbc6');        
    end;

    local procedure AppRegistrationExpiredNotificationId() : Guid;
    begin
        exit('5e54892e-557d-4056-b409-d8684637a7b5');        
    end;

}
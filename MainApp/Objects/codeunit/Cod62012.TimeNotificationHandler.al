codeunit 62012 "DXS.Time Notification Handler"
{
    trigger OnRun();
    begin
    end;

    var
        NoSetupNotificationLbl: Label 'DXS Time Entry extension is not enabled';
        NoSetupNotificationMsg: Label 'The DXS Time Entry extension to allow entry of start and end times has been installed, but it has not been setup and enabled.';
        NoSetupNotificationAct: Label 'Enable now.';
        NoSetupNotificationName: Label 'DXS Time Entry extension is not enabled.';
        NoSetupNotificationDesc: Label 'Warns if the DXS Time Entry extension has been installed, but not been setup and enabled.';
        NoHourUnitOfMeasureNotificationLbl: Label 'No Hourly Unit Setup';
        NoHourUnitOfMeasureNotificationMsg: Label 'No Hourly Unit of Measure Codes have been setup to support time based entry.';
        NoHourUnitOfMeasureSetupAct: Label 'Select or create hourly based Unit of Measure codes.';
        NoHourUnitOfMeasureSetupName: Label 'DXS Time Entry - Hourly Unit of Measure Setup missing.';
        NoHourUnitOfMeasureSetupDesc: Label 'Warns if no Hourly Unit of Measure codes have been setup.';
        WatchVideoNotificationAct: Label 'Watch video help.';
        DismissFurtherNotificationsAct: Label 'Dont show this message again.';

    procedure CreateSetupNotificationIfNoSetup();
    var
        TimePermissionHandler: Codeunit "DXS.Time Permission Handler";
    begin
        if TimePermissionHandler.IsSetupEnabled() then exit;
        if not TimePermissionHandler.CanChangeTimeSetup() then exit;

        CreateSetupNotification();
    end;

    local procedure CreateSetupNotification();
    var
        MyNotifications: Record "My Notifications";
        TimeNotification: Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoSetupNotificationId()) then exit;

        with TimeNotification do begin
            Id := GetNoSetupNotificationId();
            Message := NoSetupNotificationMsg;
            Scope := Scope(NotificationScope::LocalScope);
            AddAction(NoSetupNotificationAct, Codeunit::"DXS.Time Notification Handler", 'RunAssistedSetup');
            AddAction(DismissFurtherNotificationsAct, Codeunit::"DXS.Time Notification Handler", 'DismissNotification');
            Send();
        end;
    end;

    procedure CreateNotificationIfInvalidRegistration();
    var
        TimePermissionHandler: Codeunit "DXS.Time Permission Handler";
        TimeEntrySetup: Record "DXS.Time Entry Setup";
    begin
        if not TimePermissionHandler.IsSetupEnabled() then exit;
        if not TimeEntrySetup.ValidateRegistration() then
            CreateInvalidRegistrationNotification();
    end;

    local procedure CreateInvalidRegistrationNotification();
    var
        MyNotifications: Record "My Notifications";
        TimeNotification: Notification;
    begin
        if not MyNotifications.IsEnabled(GetNoSetupNotificationId()) then exit;

        with TimeNotification do begin
            Id := GetNoSetupNotificationId();
            Message := NoSetupNotificationMsg;
            Scope := NotificationScope::LocalScope;
            AddAction(NoSetupNotificationAct, Codeunit::"DXS.Time Notification Handler", 'RunAssistedSetup');
            AddAction(DismissFurtherNotificationsAct, Codeunit::"DXS.Time Notification Handler", 'DismissNotification');
            Send();
        end;
    end;

    procedure CreateHourlyNotificationIfNoSetup();
    var
        TimePermissionHandler: Codeunit "DXS.Time Permission Handler";
        TimeEntrySetup: Record "DXS.Time Entry Setup";
        HourlyUnitHandler: Codeunit "DXS.Hourly Unit Handler";
    begin
        if not TimePermissionHandler.IsSetupEnabled() then exit;
        if not TimeEntrySetup."Hourly Units Only" then exit;
        if HourlyUnitHandler.HourlyUnitExits() then exit;
        CreateHourlySetupNotification();
    end;

    local procedure CreateHourlySetupNotification();
    var
        MyNotifications: Record "My Notifications";
        UnitOfMeasure: Record "Unit of Measure";
        TimeNotification: Notification;
    begin
        if not UnitOfMeasure.WritePermission() then exit;
        if not MyNotifications.IsEnabled(GetNoHourUnitOfMeasureNotificationId()) then exit;
        with TimeNotification do begin
            Id := GetNoHourUnitOfMeasureNotificationId();
            Message := NoHourUnitOfMeasureNotificationMsg;
            Scope := NotificationScope::LocalScope;
            AddAction(NoHourUnitOfMeasureSetupAct, Codeunit::"DXS.Time Notification Handler", 'RunSetupHourUnitOfMeasure');
            AddAction(DismissFurtherNotificationsAct, Codeunit::"DXS.Time Notification Handler", 'DismissNotification');
            Send();
        end;
    end;

    procedure RunAssistedSetup(TimeNotification: Notification);
    var
        TimeEntrySetupWizard: Page "DXS.Time Entry Setup Wizard";
    begin
        TimeEntrySetupWizard.RunModal();
    end;

    procedure RunSetupHourUnitOfMeasure(TimeNotification: Notification);
    var
        UnitOfMeasurePage: Page "Units of Measure";
    begin
        UnitOfMeasurePage.RunModal();
    end;

    procedure DismissNotification(TimeNotification: Notification);
    var
        MyNotifications: Record "My Notifications";
    begin
        if not MyNotifications.Disable(TimeNotification.Id()) then
            case TimeNotification.Id() of
                GetNoHourUnitOfMeasureNotificationId:
                    NoHourUnitOfMeasureNotificationDefaultState(false);
                GetNoSetupNotificationId:
                    NoSetupNotificationDefaultState(false);
            end;
    end;

    local procedure RecallNotification(TimeNotification: Notification);
    var
        MyNotifications: Record "My Notifications";
    begin
        if not MyNotifications.Disable(TimeNotification.Id()) then exit;

        TimeNotification.Recall();
    end;

    procedure NoSetupNotificationDefaultState(TurnOn: Boolean);
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetNoSetupNotificationId(), NoSetupNotificationName, NoSetupNotificationDesc, TurnOn);
    end;

    procedure NoHourUnitOfMeasureNotificationDefaultState(TurnOn: Boolean);
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetNoHourUnitOfMeasureNotificationId(), NoHourUnitOfMeasureSetupName, NoHourUnitOfMeasureSetupDesc, TurnOn);
    end;

    local procedure GetNoHourUnitOfMeasureNotificationId(): Guid;
    begin
        exit('ce5c533b-2d86-4325-96be-db10dca9857b');
    end;

    local procedure GetNoSetupNotificationId(): Guid;
    begin
        exit('75adeccf-73f0-404f-94a2-f7cdfcf0f721');
    end;

    local procedure AppTrialExpiredNotificationId(): Guid;
    begin
        exit('ad92ae2c-dbed-49ff-aa0c-5998f08b49f1');
    end;

    local procedure AppRegistrationRequiredNotificationId(): Guid;
    begin
        exit('686f522d-6d91-4611-98e9-eec52ecbdbc6');
    end;

    local procedure AppRegistrationExpiredNotificationId(): Guid;
    begin
        exit('5e54892e-557d-4056-b409-d8684637a7b5');
    end;

}
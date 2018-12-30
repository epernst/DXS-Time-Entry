codeunit 62025 "DXS.Time Notification Facade"
{
    var
        TimeNotificationHandler: Codeunit "DXS.Time Notification Handler";

    [EventSubscriber(ObjectType::Page, Page::"Job Journal", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobJournalPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Resource Journal", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenResourceJournalPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Job Planning Lines", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobPlanningLinesPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"DXS.Time Entry Setup", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenDxTimeEntrySetupPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Units of Measure", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenUnitsOfMeasurePage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"O365 Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenD365ActivitiesPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Project Manager Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenProjectManagerActivitiesPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"IT Operations Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenITOperationsActivitiesPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Bookkeeper Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenBookkeeperActivitiesPage();
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup();
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingHourNotificationWithDefaultState();
    begin
        TimeNotificationHandler.NoSetupNotificationDefaultState(true);
        TimeNotificationHandler.NoHourUnitOfMeasureNotificationDefaultState(true);
    end;

}
codeunit 62025 DxsTimeNotificationFacade
{
    trigger OnRun();
    begin
    end;
           
    [EventSubscriber(ObjectType::Page, Page::"Job Journal", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Resource Journal", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenResourceJournalPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Job Planning Lines", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobPlanningLinesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::DxTimeEntrySetup, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenDxTimeEntrySetupPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Units of Measure", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenUnitsOfMeasurePage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"O365 Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenD365ActivitiesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Project Manager Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenProjectManagerActivitiesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"IT Operations Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenITOperationsActivitiesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Bookkeeper Activities", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenBookkeeperActivitiesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateSetupNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingHourNotificationWithDefaultState();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.NoSetupNotificationDefaultState(true);
        TimeNotificationHandler.NoHourUnitOfMeasureNotificationDefaultState(true);
    end;
    
}
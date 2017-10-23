codeunit 62007 DxTimeNotificationFacade
{
    trigger OnRun();
    begin
    end;
           
    [EventSubscriber(ObjectType::Page, Page::"Job Journal", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Resource Journal", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenResourceJournalPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Job Planning Lines", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobPlanningLinesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;
    
    [EventSubscriber(ObjectType::Page, Page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingHourNotificationWithDefaultState();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.NoHourUnitOfMeasureNotificationDefaultState(true);
    end;
    
}
codeunit 62007 DxTimeNotificationFacade
{
    trigger OnRun();
    begin
    end;
           
    [EventSubscriber(ObjectType::Page, 201, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, 207, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenResourceJournalPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, 1007, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobPlanningLinesPage();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.CreateHourlyNotificationIfNoSetup;
    end;
    
    [EventSubscriber(ObjectType::Page, 1518, 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingHourNotificationWithDefaultState();
    var
        TimeNotificationHandler : Codeunit DxTimeNotificationHandler;
    begin
        TimeNotificationHandler.NoHourUnitOfMeasureNotificationDefaultState(true);
    end;
    
}
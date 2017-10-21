codeunit 62007 DxJobNotificationFacade
{
    trigger OnRun();
    begin
    end;
           
    [EventSubscriber(ObjectType::Page, 201, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    var
        HourUOMSetupNotificationHandler : Codeunit DxJobNotificationHandler;
    begin
        HourUOMSetupNotificationHandler.CreateHourNotificationIfNoSetup;
    end;

    [EventSubscriber(ObjectType::Page, 1007, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobPlanningLinesPage();
    var
        HourUOMSetupNotificationHandler : Codeunit DxJobNotificationHandler;
    begin
        HourUOMSetupNotificationHandler.CreateHourNotificationIfNoSetup;
    end;
    
    [EventSubscriber(ObjectType::Page, 1518, 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingHourNotificationWithDefaultState();
    var
        HourUOMSetupNotificationHandler : Codeunit DxJobNotificationHandler;
    begin
        HourUOMSetupNotificationHandler.NoHourUnitOfMeasureNotificationDefaultState(true);
    end;
    
}
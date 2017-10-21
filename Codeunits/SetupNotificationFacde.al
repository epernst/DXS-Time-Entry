codeunit 62007 HourUOMSetupNotificationFacade
{
    trigger OnRun();
    begin
    end;
           
    [EventSubscriber(ObjectType::Page, 201, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenJobJournalPage(var Rec : Record "Job Journal Line");
    var
        HourUOMSetupNotificationHandler : Codeunit HourUOMNotificationHandler;
    begin
        HourUOMSetupNotificationHandler.CreateHourNotificationIfNoSetup;
    end;
    
    [EventSubscriber(ObjectType::Page, 1518, 'OnInitializingNotificationWithDefaultState', '', false, false)]
    local procedure OnInitializingHourNotificationWithDefaultState();
    var
        HourUOMSetupNotificationHandler : Codeunit HourUOMNotificationHandler;
    begin
        HourUOMSetupNotificationHandler.NoHourUnitOfMeasureNotificationDefaultState(true);
    end;
    
}
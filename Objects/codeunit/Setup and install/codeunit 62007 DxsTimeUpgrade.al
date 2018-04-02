codeunit 62007 DxsTimeUpgrade
{
    procedure OnNavAppUpgradePerDatabase();
    begin
        exit;
        NavApp.RestoreArchiveData(Database::DxsTimeHelpResource);
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        exit;
        NavApp.RestoreArchiveData(Database::DxsTimeEntrySetup);
    end;

}
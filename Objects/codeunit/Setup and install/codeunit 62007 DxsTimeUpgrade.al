codeunit 62007 DxsTimeUpgrade
{
    procedure OnNavAppUpgradePerDatabase();
    var
        AccessControl : Record "Access Control";
        DataMigration: Codeunit DxsTimeDataMigration;
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
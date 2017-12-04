codeunit 62007 DxsTimeUpgrade
{
    Subtype = Upgrade;

    var
        DataMigration: Codeunit DxsTimeDataMigration;
        
    procedure OnNavAppUpgradePerDatabase();
    begin
        NavApp.RestoreArchiveData(Database::DxsTimeHelpResource);
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        NavApp.RestoreArchiveData(Database::DxsTimeEntrySetup);
        NavApp.RestoreArchiveData(Database::"Job Journal Line");
        NavApp.RestoreArchiveData(Database::"Job Planning Line");
        NavApp.RestoreArchiveData(Database::"Job Ledger Entry");
        NavApp.RestoreArchiveData(Database::"Res. Journal Line");
        NavApp.RestoreArchiveData(Database::"Res. Ledger Entry");
        NavApp.RestoreArchiveData(Database::"Unit of Measure");
    end;

}
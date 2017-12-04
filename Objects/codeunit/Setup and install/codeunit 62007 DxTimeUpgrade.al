codeunit 62007 DxTimeUpgrade
{
    Subtype = Upgrade;

    var
        DataMigration: Codeunit "DXS Time Data Migration";
        
    procedure OnNavAppUpgradePerDatabase();
    begin
        NavApp.RestoreArchiveData(Database::DxTimeHelpResource);
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        NavApp.RestoreArchiveData(Database::DxTimeEntrySetup);
        NavApp.RestoreArchiveData(Database::"Job Journal Line");
        NavApp.RestoreArchiveData(Database::"Job Planning Line");
        NavApp.RestoreArchiveData(Database::"Job Ledger Entry");
        NavApp.RestoreArchiveData(Database::"Res. Journal Line");
        NavApp.RestoreArchiveData(Database::"Res. Ledger Entry");
        NavApp.RestoreArchiveData(Database::"Unit of Measure");
    end;

}
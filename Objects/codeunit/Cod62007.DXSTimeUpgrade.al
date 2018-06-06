codeunit 62007 "DXS TimeUpgrade"
{
    procedure OnNavAppUpgradePerDatabase();
    begin
        exit;
        NavApp.RestoreArchiveData(Database::"DXS TimeHelpResource");
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        exit;
        NavApp.RestoreArchiveData(Database::"DXS TimeEntrySetup");
    end;

}
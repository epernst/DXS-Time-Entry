codeunit 62007 "DXS.Time Upgrade"
{
    procedure OnNavAppUpgradePerDatabase();
    begin
        exit;
        NavApp.RestoreArchiveData(Database::"DXS.Time Help Resource");
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        exit;
        NavApp.RestoreArchiveData(Database::"DXS.Time Entry Setup");
    end;

}
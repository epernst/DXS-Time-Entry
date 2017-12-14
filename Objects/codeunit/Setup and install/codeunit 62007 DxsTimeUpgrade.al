codeunit 62007 DxsTimeUpgrade
{
    var
        UpdateSetupPermissionSet : Label 'TIMEENTRY-SETUP';

    procedure OnNavAppUpgradePerDatabase();
    var
        AccessControl : Record "Access Control";
        DataMigration: Codeunit DxsTimeDataMigration;
    begin
        NavApp.RestoreArchiveData(Database::DxsTimeHelpResource);
        
        with AccessControl do begin
            SetFilter("Role ID",'%1|%2','SUPER','SECURITY');
            if IsEmpty then exit;
            FindSet;
            repeat
                DataMigration.AddUserAccess("User Security ID",UpdateSetupPermissionSet);
            until Next = 0;
        end;
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        NavApp.RestoreArchiveData(Database::DxsTimeEntrySetup);
    end;

}
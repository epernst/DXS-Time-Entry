codeunit 62000 DxTimeUpgrade
{
    var
        UpdateSetupPermissionSet : Label 'TIMEENTRY-SETUP';

    trigger OnRun();
    begin
    end;

    procedure OnNavAppUpgradePerDatabase();
    var
        AccessControl : Record "Access Control";
    begin
        with AccessControl do begin
            SetFilter("Role ID",'%1|%2','SUPER','SECURITY');
            if IsEmpty then exit;
            FindSet;
            repeat
                AddUserAccess("User Security ID",UpdateSetupPermissionSet);
            until Next = 0;
        end;
    end;

    procedure OnNavAppUpgradePerCompany();
    begin
        NavApp.RestoreArchiveData(Database::DxTimeEntrySetup);

      //GLSourceNameMgt.PopulateSourceTable;
      //RemoveAssistedSetup;
    end;

    local procedure AddUserAccess(AssignToUser : GUID;PermissionSet : Code[20]);
    var
        AccessControl : Record "Access Control";
        AppId : Guid;
    begin
        Evaluate(AppId,GetAppId);
        with AccessControl do begin
            Init;
            "User Security ID" := AssignToUser;
            "App ID" := AppId;
            Scope := Scope::Tenant;
            "Role ID" := PermissionSet;
            if not Find then
                Insert(true);
        end;
    end;

    procedure GetAppId() : Guid;
    begin
        exit('00000000-0000-0000-0000-00000000000');
    end;

}
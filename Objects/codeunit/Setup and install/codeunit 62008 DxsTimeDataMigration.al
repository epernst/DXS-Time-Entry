codeunit 62008 DxsTimeDataMigration
{

    var
        UpdateSetupPermissionSet: Label 'TIME-ENTRY-SETUP';

    procedure MigrateFromNAV2017();
    begin
        MigrateJobsSetupFields;
        MigrateJobLedgerEntryFields;
        MigrateJobPlanningLineFields;
    end;

    local procedure MigrateJobLedgerEntryFields();
    var
        AllObjects: Record AllObj;
        JobLedgerEntry: Record "Job Ledger Entry";
        DXSJobLedgerEntry: RecordRef;
    begin
        if not AllObjects.Get(AllObjects."Object Type"::Table, 80200) then exit;
        with DXSJobLedgerEntry do
        begin
            Open(80200);
            if FindSet then 
                repeat
                    if JobLedgerEntry.Get(Field(1)) then begin
                        JobLedgerEntry.Validate("DXS Start Time", Field(80010).Value);
                        JobLedgerEntry.Validate("DXS End Time", Field(80011).Value);
                        JobLedgerEntry."DXS Total Duration" := Field(80012).Value;
                        JobLedgerEntry.Modify(true);
                    end;
                until Next = 0;
        end;
    end;

    local procedure MigrateJobPlanningLineFields();
    var
        AllObjects: Record AllObj;
        JobPlanningLine: Record "Job Planning Line";
        DXSJobPlaningLine: RecordRef;
    begin
        if not AllObjects.Get(AllObjects."Object Type"::Table, 80202) then exit;
        with DXSJobPlaningLine do
        begin
            Open(80202);
            if FindSet then
                repeat
                    if JobPlanningLine.Get(Field(1), Field(2), Field(1000)) then begin
                        JobPlanningLine.Validate("DXS Start Time", Field(80010).Value);
                        JobPlanningLine.Validate("DXS End Time", Field(80011).Value);
                        JobPlanningLine."DXS Total Duration" := Field(80012).Value;
                        JobPlanningLine.Modify(true);
                    end;
                until Next = 0;
        end;
    end;

    procedure AddAccessControl();
    var
        AccessControl: Record "Access Control";
    begin
        with AccessControl do
        begin
            SetFilter("Role ID", '%1|%2', 'SUPER', 'SECURITY');
            if IsEmpty then exit;
            FindSet;
            repeat
                AddUserAccess("User Security ID", UpdateSetupPermissionSet);
            until Next = 0;
        end;
    end;

    local procedure MigrateJobsSetupFields();
    var
        AllObjects: Record AllObj;
        TimeEntrySetup: Record DxsTimeEntrySetup;
        UnitOfMeasure: Record "Unit of Measure";
        DXSJobsSetup: RecordRef;
    begin
        if not AllObjects.Get(AllObjects."Object Type"::Table, 80201) then exit;
        with DXSJobsSetup do
        begin
            Open(80201);
            if not FindFirst then exit;
            if Format(Field(5).Value) = '' then exit;
            if not UnitOfMeasure.Get(Field(5).Value) then exit;
            TimeEntrySetup.Get;
            TimeEntrySetup."Hourly Units Only" := true;
            TimeEntrySetup."App Enabled" := true;
            TimeEntrySetup.Status := TimeEntrySetup.Status::Completed;
            TimeEntrySetup.Modify;
            UnitOfMeasure."DXS Hourly Unit" := true;
            UnitOfMeasure.Modify;
        end;
    end;

    local procedure AddUserAccess(AssignToUser: Guid; PermissionSet: Code[20]);
    var
        AccessControl: Record "Access Control";
        AppId: Guid;
    begin
        Evaluate(AppId, GetAppId);
        with AccessControl do
        begin
            Init;
            "User Security ID" := AssignToUser;
            "App ID" := AppId;
            Scope := Scope::Tenant;
            "Role ID" := PermissionSet;
            if not Find then
                Insert(true);
        end;
    end;

    procedure GetAppId(): Guid;
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        exit(AppInfo.Id);
    end;

}
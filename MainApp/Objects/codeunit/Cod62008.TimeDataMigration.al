codeunit 62008 "DXS.Time Data Migration"
{
    var
        UpdateSetupPermissionSetLbl: Label 'TIME-ENTRY-SETUP', MaxLength = 20;

    procedure MigrateFromNAV2017();
    begin
        if not FieldsExists() then exit;
        MigrateJobLedgerEntryFields();
        MigrateJobPlanningLineFields();
    end;

    local procedure FieldsExists(): Boolean;
    var
        theField: Record Field;
    begin
        exit(theField.Get(Database::"Job Ledger Entry", 80010));
    end;

    local procedure MigrateJobLedgerEntryFields();
    var
        JobLedgerEntry: Record "Job Ledger Entry";
        xJobLedgerEntry: Record "Job Ledger Entry";
        DXSJobLedgerEntry: RecordRef;
        NoOfRecords: Integer;
        CurrRecNo: Integer;
        UpdateWindow: Dialog;
        UpdatingLbl: Label 'Updating Job Ledger Entries\Record #1###### of #2######.';
    begin
        with DXSJobLedgerEntry do begin
            Open(Database::"Job Ledger Entry");
            CurrRecNo := 0;
            NoOfRecords := Count();
            If NoOfRecords < 1 then exit;
            if GuiAllowed() then
                UpdateWindow.Open(UpdatingLbl, CurrRecNo, NoOfRecords);
            FindSet();
            repeat
                if GuiAllowed() then begin
                    CurrRecNo += 1;
                    UpdateWindow.Update(1);
                end;
                if JobLedgerEntry.Get(Field(1).Value()) then begin
                    xJobLedgerEntry := JobLedgerEntry;
                    if Format(Field(80010).Value()) <> FORMAT(0T) then begin
                        JobLedgerEntry."DXS Start Time" := Field(80010).Value();
                        JobLedgerEntry."DXS.Start Date Time" := CreateDateTime(JobLedgerEntry."Posting Date", JobLedgerEntry."DXS Start Time");
                    end;
                    if Format(Field(80011).Value()) <> FORMAT(0T) then begin
                        JobLedgerEntry."DXS.End Time" := Field(80011).Value();
                        JobLedgerEntry."DXS.End Date Time" := CreateDateTime(JobLedgerEntry."Posting Date", JobLedgerEntry."DXS.End Time");
                        JobLedgerEntry."DXS.Total Duration" := JobLedgerEntry."DXS.End Date Time" - JobLedgerEntry."DXS.Start Date Time";
                    end;
                    if Format(JobLedgerEntry) <> Format(xJobLedgerEntry) then
                        JobLedgerEntry.Modify(false);
                end;
            until Next() = 0;
        end;
    end;

    local procedure MigrateJobPlanningLineFields();
    var
        JobPlanningLine: Record "Job Planning Line";
        xJobPlanningLine: Record "Job Planning Line";
        DXSJobPlaningLine: RecordRef;
        NoOfRecords: Integer;
        CurrRecNo: Integer;
        UpdateWindow: Dialog;
        UpdatingLbl: Label 'Updating Job Planning Lines\Record #1###### of #2######.';
    begin
        with DXSJobPlaningLine do begin
            Open(Database::"Job Planning Line");
            CurrRecNo := 0;
            NoOfRecords := Count();
            If NoOfRecords < 1 then exit;
            if GuiAllowed() then
                UpdateWindow.Open(UpdatingLbl, CurrRecNo, NoOfRecords);
            FindSet();
            repeat
                if GuiAllowed() then begin
                    CurrRecNo += 1;
                    UpdateWindow.Update(1);
                end;
                if JobPlanningLine.Get(Field(2).Value(), Field(1000).Value(), Field(1).Value()) then begin
                    xJobPlanningLine := JobPlanningLine;
                    if Format(Field(80010).Value()) <> FORMAT(0T) then begin
                        JobPlanningLine.Validate("DXS Start Time", Field(80010).Value());
                        JobPlanningLine."DXS Start Time" := Field(80010).Value();
                        JobPlanningLine."DXS Start Date Time" := CreateDateTime(JobPlanningLine."Planning Date", JobPlanningLine."DXS Start Time");
                    end;
                    if Format(Field(80011).Value()) <> FORMAT(0T) then begin
                        JobPlanningLine."DXS End Time" := Field(80011).Value();
                        JobPlanningLine."DXS.End Date Time" := CreateDateTime(JobPlanningLine."Planning Date", JobPlanningLine."DXS End Time");
                        JobPlanningLine."DXS.Total Duration" := JobPlanningLine."DXS.End Date Time" - JobPlanningLine."DXS Start Date Time";
                    end;
                    if Format(JobPlanningLine) <> Format(xJobPlanningLine) then
                        JobPlanningLine.Modify(false);
                end;
            until Next() = 0;
        end;
    end;

    procedure AddAccessControl();
    var
        AccessControl: Record "Access Control";
    begin
        with AccessControl do begin
            SetFilter("Role ID", '%1|%2', 'SUPER', 'SECURITY');
            if IsEmpty() then exit;
            FindSet();
            repeat
                AddUserAccess("User Security ID", UpdateSetupPermissionSetLbl);
            until Next() = 0;
        end;
    end;

    procedure AddUserAccess(AssignToUser: Guid; PermissionSet: Code[20]);
    var
        AccessControl: Record "Access Control";
    begin
        with AccessControl do begin
            Init();
            "User Security ID" := AssignToUser;
            "App ID" := GetAppId();
            Scope := Scope::Tenant;
            "Role ID" := PermissionSet;
            if not Find() then
                Insert(true);
        end;
    end;

    procedure GetAppId(): Guid;
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        exit(AppInfo.Id());
    end;

}
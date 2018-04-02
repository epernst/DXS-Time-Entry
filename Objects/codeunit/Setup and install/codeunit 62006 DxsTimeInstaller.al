codeunit 62006 DxsTimeInstaller
{
    Subtype = Install;
    Permissions = tabledata DxsTimeEntrySetup = rim;

    trigger OnInstallAppPerCompany();
    var
        TimeAppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(TimeAppInfo);
        if TimeAppInfo.DataVersion() = Version.Create(0, 0, 0, 0) then
            InitializeNewSetup()
        else
            ReInitializeSetup();
    end;

    trigger OnInstallAppPerDatabase();
    var
        ResourceHelper: Codeunit DxsTimeResourceHelper;
    begin
        ResourceHelper.Run();
    end;

    local procedure InitializeNewSetup();
    var
        Setup: Record DxsTimeEntrySetup;
        DataMigration: Codeunit DxsTimeDataMigration;
    begin
        with Setup do begin
            if not IsEmpty() then exit;
            Init();
            Status := Status::"Not Started";
            "Installation Date Time" := CurrentDateTime();
            Insert();
        end;

        DataMigration.MigrateFromNAV2017();
    end;

    local procedure ReInitializeSetup();
    var
        Setup: Record DxsTimeEntrySetup;
    begin
        with Setup do begin
            Get();
            "Installation Date Time" := CurrentDateTime();
            Modify();
        end;
    end;

}
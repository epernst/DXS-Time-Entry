codeunit 62006 "DXS TimeInstaller"
{
    Subtype = Install;
    Permissions = tabledata "DXS TimeEntrySetup" = rim;

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
        ResourceHelper: Codeunit "DXS TimeResourceHelper";
    begin
        ResourceHelper.Run();
    end;

    local procedure InitializeNewSetup();
    var
        Setup: Record "DXS TimeEntrySetup";
        DataMigration: Codeunit "DXS TimeDataMigration";
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
        Setup: Record "DXS TimeEntrySetup";
    begin
        with Setup do begin
            Get();
            "Installation Date Time" := CurrentDateTime();
            Modify();
        end;
    end;

}
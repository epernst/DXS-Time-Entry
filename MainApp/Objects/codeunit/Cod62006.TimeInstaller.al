codeunit 62006 "DXS.Time Installer"
{
    Subtype = Install;
    Permissions = tabledata "DXS.Time Entry Setup" = rim;

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
        ResourceHelper: Codeunit "DXS.Time Resource Helper";
    begin
        ResourceHelper.Run();
    end;

    local procedure InitializeNewSetup();
    var
        Setup: Record "DXS.Time Entry Setup";
        DataMigration: Codeunit "DXS.Time Data Migration";
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
        Setup: Record "DXS.Time Entry Setup";
    begin
        with Setup do begin
            Get();
            "Installation Date Time" := CurrentDateTime();
            Modify();
        end;
    end;

}
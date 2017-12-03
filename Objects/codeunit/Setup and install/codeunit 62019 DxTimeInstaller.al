codeunit 62019 DxTimeInstaller
{
    Subtype = Install;
    Permissions = tabledata DxTimeEntrySetup = rim;

    trigger OnInstallAppPerCompany();
    var
        TimeAppInfo : ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(TimeAppInfo); 
        if TimeAppInfo.DataVersion = Version.Create(0,0,0,0) then
            HandleFreshInstall
        else
            HandleReinstall; 
    end;

    trigger OnInstallAppPerDatabase();
    var
        ResourceHelper : Codeunit DxTimeResourceHelper;
    begin
        ResourceHelper.InitializeResources;
    end;

    local procedure HandleFreshInstall();
    begin
        // Do work needed the first time this extension is ever installed for this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was install
        // - Initial data setup for use
        InitializeNewSetup;
    end;

    local procedure HandleReinstall();
    begin
        // Do work needed when reinstalling the same version of this extension back on this tenant.
        // Some possible usages:
        // - Service callback/telemetry indicating that extension was reinstalled
        // - Data 'patch-up' work, for example, detecting if new 'base' records have been changed while you have been working 'offline'.
        // - Setup 'welcome back' messaging for next user access.
        ReInitializeSetup;
    end;

    local procedure InitializeNewSetup();
    var
        Setup: Record DxTimeEntrySetup;
    begin
        with Setup do begin
            if not IsEmpty then exit;
            Init;
            Status := Status::"Not Started";
            "Installation Date Time" := CurrentDateTime;
            Insert;           
        end;
    end;

    local procedure ReInitializeSetup();
    var
        Setup: Record DxTimeEntrySetup;
    begin
        with Setup do begin
            Get;
            "Installation Date Time" := CurrentDateTime;
            Modify;           
        end;
    end;

}
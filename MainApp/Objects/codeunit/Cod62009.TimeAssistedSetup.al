codeunit 62009 "DXS.Time Assisted Setup"
{
    var
        TimeEntrySetup: Record "DXS.Time Entry Setup";
        SetupNameLbl: Label 'Setup DXS Time Entry extension', MaxLength = 50;
        SetupDescriptionLbl: Label 'Setup the DXS Time Entry extension to allow entry of start and ending times.', MaxLength = 250;
        SetupKeywordsTxt: Label 'Jobs, Resources, Project Management, Time', MaxLength = 250;
        RequiredPermissionMissingErr: Label 'You have not been granted required access rights to start the Assisted Setup.\\The Assisted Setup for G/L Source Names is about assigning the required permissions to users.  To be able to assign permissions you need to be granted either the SUPER og SECURITY permission set.';

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', true, false)]
    local procedure OnRegisterAssistedSetup(
        var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary);
    begin
        if not TimeEntrySetup.WritePermission() then exit;
        InitializeSetup();
        AddToAssistedSetup(TempAggregatedAssistedSetup);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnUpdateAssistedSetupStatus', '', true, false)]
    local procedure OnUpdateAssistedSetupStatus(
        var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary);
    begin
        TimeEntrySetup.Get();
        with TempAggregatedAssistedSetup do
            SetStatus(TempAggregatedAssistedSetup, Page::"DXS.Time Entry Setup Wizard", TimeEntrySetup.Status);
    end;

    procedure VerifyUserAccess();
    var
        AccessControl: Record "Access Control";
    begin
        with AccessControl do begin
            //SETRANGE("User Security ID",USERSECURITYID);
            SetRange("User Name", UserId());
            SetFilter("Role ID", '%1|%2', 'SUPER', 'SECURITY');
            if IsEmpty() THEN
                Error(RequiredPermissionMissingErr);
        end;
    end;

    local procedure InitializeSetup();
    begin
        with TimeEntrySetup do
            if IsEmpty() then begin
                Init();
                Insert();
            end else
                Get();
    end;

    local procedure AddToAssistedSetup(
        var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary);
    var
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 240x240";
        ResourceHelper: Codeunit "DXS.Time Resource Helper";
        InStr: InStream;
    begin
        with TempAggregatedAssistedSetup do begin
            DxTimeIcon.GetIcon(TempBlob);
            TempBlob.Blob.CreateInStream(InStr);
            InsertAssistedSetupIcon(ResourceHelper.Get240PXIconCode(), InStr);

            AddExtensionAssistedSetup(
                Page::"DXS.Time Entry Setup Wizard",
                SetupNameLbl,
                true,
                TimeEntrySetup.RecordId(),
                TimeEntrySetup.Status,
                ResourceHelper.Get240PXIconCode());
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Business Setup", 'OnRegisterBusinessSetup', '', true, true)]
    local procedure OnRegisterBusinessSetup(var TempBusinessSetup: Record "Business Setup" temporary);
    var
        TimeEntrySetup: Record "DXS.Time Entry Setup";
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 240x240";
        InStr: InStream;
    begin
        if not TimeEntrySetup.WritePermission() then exit;

        TempBusinessSetup.InsertExtensionBusinessSetup(
            TempBusinessSetup,
            GetAppName(),
            SetupDescriptionLbl,
            SetupKeywordsTxt,
            TempBusinessSetup.Area::Jobs,
            Page::"DXS.Time Entry Setup",
            GetAppName());

        DxTimeIcon.GetIcon(TempBlob);
        TempBlob.Blob.CreateInStream(InStr);
        TempBusinessSetup.SetBusinessSetupIcon(TempBusinessSetup, InStr);
    end;

    local procedure GetIconInStream(var InStr: InStream);
    var
        TempBlob: Record TempBlob;
        IconCodeunit: Codeunit "DXS.Time Icon 240x240";
    begin
        IconCodeunit.GetIcon(TempBlob);
        TempBlob.Blob.CREATEINSTREAM(InStr);
    end;

    procedure GetAppName(): Text[50];
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        exit(copystr(AppInfo.Name(), 1, 50));
    end;

}
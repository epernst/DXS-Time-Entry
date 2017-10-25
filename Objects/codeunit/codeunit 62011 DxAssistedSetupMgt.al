codeunit 62011 DxAssistedSetup
{
    trigger OnRun();
    begin
    end;
    
    var
        Setup : Record DxTimeEntrySetup;
        SetupNameLbl : Label 'Set up Start and End Time Entry';
        RequiredPermissionMissingErr : Label 'You have not been granted required access rights to start the Assisted Setup.\\The Assisted Setup for G/L Source Names is about assigning the required permissions to users.  To be able to assign permissions you need to be granted either the SUPER og SECURITY permission set.';

    procedure VerifyUserAccess();
    var
        AccessControl : Record "Access Control";
    begin
        with AccessControl do begin
            //SETRANGE("User Security ID",USERSECURITYID);
            SetRange("User Name",UserId);
            SetFilter("Role ID",'%1|%2','SUPER','SECURITY');
            if IsEmpty THEN
                Error(RequiredPermissionMissingErr);
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', true, false)]
    local procedure OnRegisterAssistedSetup(var TempAggregatedAssistedSetup : Record "Aggregated Assisted Setup" temporary);
    begin
        if not Setup.WritePermission then exit;
        InitializeSetup;
        AddToAssistedSetup(TempAggregatedAssistedSetup);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnUpdateAssistedSetupStatus', '', true, false)]
    local procedure OnUpdateAssistedSetupStatus(var TempAggregatedAssistedSetup : Record "Aggregated Assisted Setup" temporary);
    begin
        Setup.GET;
        with TempAggregatedAssistedSetup DO
            SetStatus(TempAggregatedAssistedSetup,Page::DxTimeEntrySetupWizard,Setup.Status);
    end;

    local procedure InitializeSetup();
    begin
        with Setup do
            if IsEmpty then begin
                Init;
                Insert;
            end else
                Get;
    end;

    local procedure AddToAssistedSetup(var TempAggregatedAssistedSetup : Record "Aggregated Assisted Setup" temporary);
    var
        TempBlob : Record TempBlob;
        //GLSourceNameIcon : Codeunit 70009232;
        InStr : InStream;
    begin
        with TempAggregatedAssistedSetup do begin
            //GLSourceNameIcon.GetIcon(TempBlob);
            //TempBlob.Blob.CREATEINSTREAM(InStr);
            //InsertAssistedSetupIcon(HelpResource.Get240PXIconCode,InStr);            

            AddExtensionAssistedSetup(
                Page::DxTimeEntrySetupWizard,
                SetupNameLbl,
                true,
                Setup.RecordId,
                Setup.Status,
                ''); //HelpResource.Get240PXIconCode
        END;
    end;
}
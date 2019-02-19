codeunit 62040 "DXS.Time Resource Helper"
{
    trigger OnRun();
    begin
        InitializeResources();
    end;

    procedure InitializeResources();
    begin
        InitAssistedSetupHelpPageUrl();
        InitAssistedSetupEmbedVideoUrl();
        InitUsageHelpEmbedVideoUrl();
        InitUsageHelpPageUrl();
        InitIcon70x70();
        InitIcon150x150();
        InitIcon240x240();
        InitIcon250x250();
        InitIcon417x417();
    end;

    procedure GetHelpUrl(SetupCode: Code[50]): Text;
    var
        HelpResource: Record "DXS.Time Help Resource";
    begin
        with HelpResource do
            if Get(SetupCode) then
                exit(Url);
    end;

    procedure StartVideo(SetupCode: Code[50]);
    var
        ClientTypeMgt: Codeunit ClientTypeManagement;
        VideoLink: Page "Video link";
    begin
        if ClientTypeMgt.IsCommonWebClientType() then begin
            VideoLink.SetURL(GetHelpUrl(SetupCode));
            VideoLink.RunModal();
        end else
            Hyperlink(GetHelpUrl(SetupCode));
    end;

    procedure GetSetupHelpCode(): Code[50];
    var
        SetupHelpCodeLbl: Label 'SETUPHELP', MaxLength = 50;
    begin
        exit(SetupHelpCodeLbl);
    end;

    procedure GetSetupVideoCode(): Code[50];
    var
        SetupVideoCodeLbl: Label 'SETUPVIDEO', MaxLength = 50;
    begin
        exit(SetupVideoCodeLbl);
    end;

    procedure GetUsageHelpCode(): Code[50];
    var
        UsageHelpCodeLbl: Label 'USAGEHELP', MaxLength = 50;
    begin
        exit(UsageHelpCodeLbl);
    end;

    procedure GetUsageVideoCode(): Code[50];
    var
        UsageVideoCodeLbl: Label 'USAGEVIDEO', MaxLength = 50;
    begin
        exit(UsageVideoCodeLbl);
    end;

    procedure Get70PXIconCode(): Code[50];
    var
        IconCodeLbl: Label 'DXTIME_70PXICON', MaxLength = 50;
    begin
        exit(IconCodeLbl)
    end;

    procedure Get150PXIconCode(): Code[50];
    var
        IconCodeLbl: Label 'DXTIME_150PXICON', MaxLength = 50;
    begin
        exit(IconCodeLbl)
    end;

    procedure Get240PXIconCode(): Code[50];
    var
        IconCodeLbl: Label 'DXTIME_240PXICON', MaxLength = 50;
    begin
        exit(IconCodeLbl)
    end;

    procedure Get250PXIconCode(): Code[50];
    var
        IconCodeLbl: Label 'DXTIME_250PXICON', MaxLength = 50;
    begin
        exit(IconCodeLbl)
    end;

    procedure Get417PXIconCode(): Code[50];
    var
        IconCodeLbl: Label 'DXTIME_417PXICON', MaxLength = 50;
    begin
        exit(IconCodeLbl)
    end;

    local procedure InitAssistedSetupHelpPageUrl();
    var
        SetupHelpUrlLbl: Label 'https://dynamicsuser.net/isv/dxs/w', MaxLength = 250, Locked = true;
    begin
        InitUrl(GetSetupHelpCode(), SetupHelpUrlLbl);
    end;

    local procedure InitAssistedSetupEmbedVideoUrl();
    var
        SetupVideoUrlLbl: Label 'https://www.youtube.com/embed/TYo1ZJ5jizs', MaxLength = 250, Locked = true;
    begin
        InitUrl(GetSetupVideoCode(), SetupVideoUrlLbl);
    end;

    local procedure InitUsageHelpPageUrl();
    var
        UsageHelpUrlLbl: Label 'https://dynamicsuser.net/isv/dxs/w', MaxLength = 250, Locked = true;
    begin
        InitUrl(GetUsageHelpCode(), UsageHelpUrlLbl);
    end;

    local procedure InitUsageHelpEmbedVideoUrl();
    var
        UsageVideoUrlLbl: Label 'https://www.youtube.com/embed/Xj5TATt7Pns', MaxLength = 250, Locked = true;
    begin
        InitUrl(GetUsageVideoCode(), UsageVideoUrlLbl);
    end;

    local procedure InitIcon70x70();
    var
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 70x70";
        IconDescriptionLbl: Label 'DXS Time Icon 70x70';
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get70PXIconCode(), IconDescriptionLbl, TempBlob);
    end;

    local procedure InitIcon150x150();
    var
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 150x150";
        IconDescriptionLbl: Label 'DXS Time Icon 150x150';
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get150PXIconCode(), IconDescriptionLbl, TempBlob);
    end;

    local procedure InitIcon240x240();
    var
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 240x240";
        IconDescriptionLbl: Label 'DXS Time Icon 240x240';
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get240PXIconCode(), IconDescriptionLbl, TempBlob);
    end;

    local procedure InitIcon250x250();
    var
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 250x250";
        IconDescriptionLbl: Label 'DXS Time Icon 250x250';
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get250PXIconCode(), IconDescriptionLbl, TempBlob);
    end;

    local procedure InitIcon417x417();
    var
        TempBlob: Record TempBlob;
        DxTimeIcon: Codeunit "DXS.Time Icon 417x417";
        IconDescriptionLbl: Label 'DXS Time Icon 417x417';
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get417PXIconCode(), IconDescriptionLbl, TempBlob);
    end;

    local procedure InitUrl(UrlCode: Code[50]; UrlLink: Text[250]);
    var
        DxTimeHelpResource: Record "DXS.Time Help Resource";
    begin
        with DxTimeHelpResource do
            if not Get(UrlCode) then begin
                Code := UrlCode;
                Url := UrlLink;
                Insert();
            end;
    end;

    procedure InitIcon(IconCode: Code[50]; IconDescription: Text; TempBlob: Record TempBlob);
    var
        HelpResource: Record "DXS.Time Help Resource";
        InStr: InStream;
    begin
        with HelpResource do
            if not Get(IconCode) then begin
                Code := IconCode;
                TempBlob.Blob.CreateInStream(InStr);
                Icon.ImportStream(InStr, IconDescription, 'image/png');
                Insert();
            end;
    end;
}
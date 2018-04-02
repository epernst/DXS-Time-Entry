codeunit 62040 DxsTimeResourceHelper
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
        HelpResource: Record DxsTimeHelpResource;
    begin
        with HelpResource do
            if Get(SetupCode) then
            exit(Url);
    end;

    procedure StartVideo(SetupCode: Code[50]);
    var
        VideoLink: Page "Video link";
        ClientTypeMgt: Codeunit ClientTypeManagement;
    begin
        if ClientTypeMgt.IsCommonWebClientType() then begin
            VideoLink.SetURL(GetHelpUrl(SetupCode));
            VideoLink.RunModal();
        end else
            Hyperlink(GetHelpUrl(SetupCode));
    end;

    procedure GetSetupHelpCode(): Code[50];
    var
        SetupHelpCode: Label 'SETUPHELP', MaxLength = 50;
    begin
        exit(SetupHelpCode);
    end;

    procedure GetSetupVideoCode(): Code[50];
    var
        SetupVideoCode: Label 'SETUPVIDEO', MaxLength = 50;
    begin
        exit(SetupVideoCode);
    end;

    procedure GetUsageHelpCode(): Code[50];
    var
        UsageHelpCode: Label 'USAGEHELP', MaxLength = 50;
    begin
        exit(UsageHelpCode);
    end;

    procedure GetUsageVideoCode(): Code[50];
    var
        UsageVideoCode: Label 'USAGEVIDEO', MaxLength = 50;
    begin
        exit(UsageVideoCode);
    end;

    procedure Get70PXIconCode(): Code[50];
    var
        IconCode: Label 'DXTIME_70PXICON', MaxLength = 50;
    begin
        exit(IconCode)
    end;

    procedure Get150PXIconCode(): Code[50];
    var
        IconCode: Label 'DXTIME_150PXICON', MaxLength = 50;
    begin
        exit(IconCode)
    end;

    procedure Get240PXIconCode(): Code[50];
    var
        IconCode: Label 'DXTIME_240PXICON', MaxLength = 50;
    begin
        exit(IconCode)
    end;

    procedure Get250PXIconCode(): Code[50];
    var
        IconCode: Label 'DXTIME_250PXICON', MaxLength = 50;
    begin
        exit(IconCode)
    end;

    procedure Get417PXIconCode(): Code[50];
    var
        IconCode: Label 'DXTIME_417PXICON', MaxLength = 50;
    begin
        exit(IconCode)
    end;

    local procedure InitAssistedSetupHelpPageUrl();
    var
        SetupHelpUrl: Label 'https://dynamicsuser.net/isv/dxs/w', Locked = true;
    begin
        InitUrl(GetSetupHelpCode(), SetupHelpUrl);
    end;

    local procedure InitAssistedSetupEmbedVideoUrl();
    var
        SetupVideoUrl: Label 'https://www.youtube.com/embed/TYo1ZJ5jizs', Locked = true;
    begin
        InitUrl(GetSetupVideoCode(), SetupVideoUrl);
    end;

    local procedure InitUsageHelpPageUrl();
    var
        UsageHelpUrl: Label 'https://dynamicsuser.net/isv/dxs/w', Locked = true;
    begin
        InitUrl(GetUsageHelpCode(), UsageHelpUrl);
    end;

    local procedure InitUsageHelpEmbedVideoUrl();
    var
        UsageVideoUrl: Label 'https://www.youtube.com/embed/Xj5TATt7Pns', Locked = true;
    begin
        InitUrl(GetUsageVideoCode(), UsageVideoUrl);
    end;

    local procedure InitIcon70x70();
    var
        TempBlob: Record TempBlob;
        IconDescription: Label 'DXS Time Icon 70x70';
        DxTimeIcon: Codeunit DxsTimeIcon70x70;
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get70PXIconCode(), IconDescription, TempBlob);
    end;

    local procedure InitIcon150x150();
    var
        TempBlob: Record TempBlob;
        IconDescription: Label 'DXS Time Icon 150x150';
        DxTimeIcon: Codeunit DxsTimeIcon150x150;
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get150PXIconCode(), IconDescription, TempBlob);
    end;

    local procedure InitIcon240x240();
    var
        TempBlob: Record TempBlob;
        IconDescription: Label 'DXS Time Icon 240x240';
        DxTimeIcon: Codeunit DxsTimeIcon240x240;
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get240PXIconCode(), IconDescription, TempBlob);
    end;

    local procedure InitIcon250x250();
    var
        TempBlob: Record TempBlob;
        IconDescription: Label 'DXS Time Icon 250x250';
        DxTimeIcon: Codeunit DxsTimeIcon250x250;
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get250PXIconCode(), IconDescription, TempBlob);
    end;

    local procedure InitIcon417x417();
    var
        TempBlob: Record TempBlob;
        IconDescription: Label 'DXS Time Icon 417x417';
        DxTimeIcon: Codeunit DxsTimeIcon417x417;
    begin
        DxTimeIcon.GetIcon(TempBlob);
        InitIcon(Get417PXIconCode(), IconDescription, TempBlob);
    end;

    local procedure InitUrl(UrlCode: Code[50]; UrlLink: Text);
    var
        DxTimeHelpResource: Record DxsTimeHelpResource;
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
        HelpResource: Record DxsTimeHelpResource;
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
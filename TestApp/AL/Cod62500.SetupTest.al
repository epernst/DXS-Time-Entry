codeunit 62500 "DXS.Setup.Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    var
        isInitialized: Boolean;

    trigger OnRun();
    begin
        // [FEATURE] Assisted setup
        isInitialized := false;
    end;

    [Test]
    procedure "Assisted Setup Default"();
    var
        Setup: Record "DXS TimeEntrySetup";
    begin
        // [SCENARIO #1000] Assisted setup - default   
        Initialize();
        // [GIVEN] No setup exists
        Setup.Delete();

        // [WHEN] Running assisted setup with defaults / all unit of measures


        // [THEN] Setup should be enabled

    end;

    local procedure Initialize();
    begin
        if isInitialized then exit;

        isInitialized := true;
    end;
}
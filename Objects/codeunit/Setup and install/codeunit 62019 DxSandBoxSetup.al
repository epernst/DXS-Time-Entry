codeunit 62019 DxSandBoxSetup
{ 
    trigger OnRun();
    begin
        SetupSandbox;
    end;
    
    local procedure SetupSandbox();
    var
        Setup : Record DxsTimeEntrySetup;
    begin
        with Setup do begin
            if not IsEmpty then exit;    
            Get;
            "Hourly Units Only" := true;
            Validate("Fields To Show","Fields To Show"::Times);
           "Time App Enabled" := true;
           Insert;  

        end;
    end;
}
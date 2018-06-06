codeunit 62019 "DXS SandBoxSetup"
{ 
    trigger OnRun();
    begin
        SetupSandbox();
    end;
    
    local procedure SetupSandbox();
    var
        Setup : Record "DXS TimeEntrySetup";
    begin
        with Setup do begin
            if not IsEmpty() then exit;    
            Get();
            "Hourly Units Only" := true;
            Validate("Fields To Show","Fields To Show"::Times);
           "App Enabled" := true;
           Insert();  

        end;
    end;
}
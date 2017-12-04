codeunit 62010 DxTimePermissionHandler
{
    trigger OnRun();
    begin
    end;
    
    procedure CanChangeTimeSetup() : Boolean;
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
    begin
        exit(TimeEntrySetup.WritePermission);
    end;

    procedure IsSetupEnabled() : Boolean;
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
    begin
        exit(TimeEntrySetup.GetSetupIfEnabled);
    end;

    procedure CanChangeUnitOfMeasure() : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
        TimeEntrySetup : Record DxTimeEntrySetup;
    begin
        exit(UnitOfMeasure.WritePermission and TimeEntrySetup.WritePermission);
    end;

}
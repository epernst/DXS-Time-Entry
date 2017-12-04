codeunit 62010 DxsTimePermissionHandler
{
    trigger OnRun();
    begin
    end;
    
    procedure CanChangeTimeSetup() : Boolean;
    var
        TimeEntrySetup : Record DxsTimeEntrySetup;
    begin
        exit(TimeEntrySetup.WritePermission);
    end;

    procedure IsSetupEnabled() : Boolean;
    var
        TimeEntrySetup : Record DxsTimeEntrySetup;
    begin
        exit(TimeEntrySetup.GetSetupIfEnabled);
    end;

    procedure CanChangeUnitOfMeasure() : Boolean;
    var
        UnitOfMeasure : Record "Unit of Measure";
        TimeEntrySetup : Record DxsTimeEntrySetup;
    begin
        exit(UnitOfMeasure.WritePermission and TimeEntrySetup.WritePermission);
    end;

}

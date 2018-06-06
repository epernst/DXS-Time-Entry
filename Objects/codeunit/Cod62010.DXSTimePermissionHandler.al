codeunit 62010 "DXS TimePermissionHandler"
{
    trigger OnRun();
    begin
    end;

    procedure CanChangeTimeSetup(): Boolean;
    var
        TimeEntrySetup: Record "DXS TimeEntrySetup";
    begin
        exit(TimeEntrySetup.WritePermission());
    end;

    procedure IsSetupEnabled(): Boolean;
    var
        TimeEntrySetup: Record "DXS TimeEntrySetup";
    begin
        exit(TimeEntrySetup.GetSetupIfEnabled());
    end;

    procedure CanChangeUnitOfMeasure(): Boolean;
    var
        UnitOfMeasure: Record "Unit of Measure";
        TimeEntrySetup: Record "DXS TimeEntrySetup";
    begin
        exit(UnitOfMeasure.WritePermission() and TimeEntrySetup.WritePermission());
    end;

}

codeunit 62010 "DXS.Time Permission Handler"
{
    procedure CanChangeTimeSetup(): Boolean;
    var
        TimeEntrySetup: Record "DXS.Time Entry Setup";
    begin
        exit(TimeEntrySetup.WritePermission());
    end;

    procedure IsSetupEnabled(): Boolean;
    var
        TimeEntrySetup: Record "DXS.Time Entry Setup";
    begin
        exit(TimeEntrySetup.GetSetupIfEnabled());
    end;

    procedure CanChangeUnitOfMeasure(): Boolean;
    var
        UnitOfMeasure: Record "Unit of Measure";
        TimeEntrySetup: Record "DXS.Time Entry Setup";
    begin
        exit(UnitOfMeasure.WritePermission() and TimeEntrySetup.WritePermission());
    end;

}

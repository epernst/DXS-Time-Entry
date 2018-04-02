tableextension 62006 DxsResJournalLine extends "Res. Journal Line"
{
    fields
    {
        field(62000; "DXS Start Time"; Time)
        {
            Caption = 'Start Time';
            trigger OnValidate();
            var
                HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code", FieldCaption("DXS Start Date Time"), true) then begin
                    InitStartEndTimes();
                    exit;
                end;
                if "DXS Start Time" = xRec."DXS Start Time" then exit;
                Validate("DXS Start Date Time", CreateDateTime("Posting Date", "DXS Start Time"));
            end;
        }
        field(62001; "DXS End Time"; Time)
        {
            Caption = 'End Time';
            trigger OnValidate();
            var
                HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code", FieldCaption("DXS End Time"), true) then begin
                    InitStartEndTimes();
                    exit;
                end;
                if "Posting Date" = 0D then
                    "Posting Date" := WorkDate();
                if "DXS End Time" < "DXS Start Time" then
                    Validate("DXS End Date Time", CreateDateTime("Posting Date" + 1, "DXS End Time"))
                else
                    Validate("DXS End Date Time", CreateDateTime("Posting Date", "DXS End Time"));
            end;
        }
        field(62003; "DXS Start Date Time"; DateTime)
        {
            Caption = 'Start Date Time';
            trigger OnValidate();
            var
                HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code", FieldCaption("DXS Start Date Time"), true) then begin
                    InitStartEndTimes();
                    exit;
                end;
                if "DXS Start Date Time" = xRec."DXS Start Date Time" then exit;
                "DXS Start Time" := DT2Time("DXS Start Date Time");

                if("DXS Start Date Time" > "DXS End Date Time") AND ("DXS End Date Time" <> 0DT) then begin
                    "DXS End Date Time" := "DXS Start Date Time";
                    Validate("DXS End Date Time");
                end;
            end;
        }
        field(62004; "DXS End Date Time"; DateTime)
        {
            Caption = 'End Date Time';
            trigger OnValidate();
            var
                HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
                TimeChecker: Codeunit DxsTimeChecker;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code", FieldCaption("DXS End Date Time"), true) then begin
                    InitStartEndTimes();
                    exit;
                end;
                if("DXS Start Date Time" = 0DT) or ("DXS End Date Time" = 0DT) then begin
                    "DXS Total Duration" := 0;
                    exit;
                end;
                TimeChecker.ValidateStartAndEndTimes("DXS Start Date Time", "DXS End Date Time", true);
                if CurrFieldNo <> FieldNo("DXS Total Duration") then
                    Validate("DXS Total Duration", "DXS End Date Time" - "DXS Start Date Time");
                "DXS End Time" := DT2Time("DXS End Date Time");
            end;
        }
        field(62005; "DXS Total Duration"; Duration)
        {
            Caption = 'Total Duration';
            trigger OnValidate();
            var
                UnitOfMeasure: Record "Unit of Measure";
                HourlyUnitHandler: Codeunit DxsHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code", FieldCaption("DXS Total Duration"), true) then begin
                    InitStartEndTimes();
                    exit;
                end;
                if "DXS Total Duration" = 0 then exit;
                Validate(
                    Quantity,
                    Round(
                        Round("DXS Total Duration" / 3600000, 0.00001),
                        UnitOfMeasure.GetTimeRounding("Unit of Measure Code"),
                        '>'));
                if(CurrFieldNo = FieldNo("DXS Total Duration")) then
                    Validate("DXS End Date Time", "DXS Start Date Time" + "DXS Total Duration");
            end;
        }
    }
    procedure InitStartEndTimes();
    begin
        "DXS Start Time" := 0T;
        "DXS Start Date Time" := 0DT;
        "DXS End Time" := 0T;
        "DXS End Date Time" := 0DT;
        "DXS Total Duration" := 0;
    end;
}


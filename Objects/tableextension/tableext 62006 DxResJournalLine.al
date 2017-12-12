tableextension 62006 DxResJournalLine extends "Res. Journal Line" 
{
    fields
    {
        field(62000;"Start Time";Time)
        {
            Caption = 'Start Time';
            trigger OnValidate();
            var
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("Start Date Time"),true) then begin
                    InitStartEndTimes;
                    exit;
                end;
                if "Start Time" = xRec."Start Time" then exit;
                Validate("Start Date Time",CreateDateTime("Posting Date","Start Time"));
            end;
        }
        field(62001;"End Time";Time)
        {
            Caption = 'End Time';
            trigger OnValidate();
            var
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("End Time"),true) then begin
                    InitStartEndTimes;
                    exit;
                end;
                if "Posting Date" = 0D then
                    "Posting Date" := WorkDate;
                if "End Time" < "Start Time" then
                    Validate("End Date Time",CreateDateTime("Posting Date"+1,"End Time"))
                else
                    Validate("End Date Time",CreateDateTime("Posting Date","End Time"));
            end;
        }
        field(62003;"Start Date Time";DateTime)
        {
            Caption = 'Start Date Time';
            trigger OnValidate();
            var
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("Start Date Time"),true) then begin
                    InitStartEndTimes;
                    exit;
                end;
                if "Start Date Time" = xRec."Start Date Time" then exit;
                "Start Time" := DT2Time("Start Date Time");

                if ("Start Date Time" > "End Date Time") AND ("End Date Time" <> 0DT) then begin
                    "End Date Time" := "Start Date Time";
                    Validate("End Date Time");
                end;
            end;
        }
        field(62004;"End Date Time";DateTime)
        {
            Caption = 'End Date Time';
            trigger OnValidate();
            var
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
                TimeChecker : Codeunit DxsTimeChecker;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("End Date Time"),true) then begin
                    InitStartEndTimes;
                    exit;
                end;
                if ("Start Date Time" = 0DT) or ("End Date Time" = 0DT) then begin
                    "Total Duration" := 0;
                    exit;
                end;
                TimeChecker.ValidateStartAndEndTimes("Start Date Time","End Date Time",true);
                if CurrFieldNo <> FieldNo("Total Duration") then 
                    Validate("Total Duration","End Date Time"-"Start Date Time");
                "End Time" := DT2Time("End Date Time");
            end;
        }
        field(62005;"Total Duration";Duration)
        {
            Caption = 'Total Duration';
            trigger OnValidate();
            var
                UnitOfMeasure : Record "Unit of Measure";
                HourlyUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not HourlyUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("Total Duration"),true) then begin
                    InitStartEndTimes;
                    exit;
                end;
                if "Total Duration" = 0 then exit;
                Validate(
                    Quantity, 
                    Round( 
                        Round("Total Duration"/3600000,0.00001),
                        UnitOfMeasure.GetTimeRounding("Unit of Measure Code"),
                        '>'));
                if (CurrFieldNo = FieldNo("Total Duration")) then 
                    Validate("End Date Time","Start Date Time" + "Total Duration");
            end;
        }
    }
    procedure InitStartEndTimes();
    begin
        "Start Time" := 0T;
        "Start Date Time" := 0DT;
        "End Time" := 0T;
        "End Date Time" := 0DT;
        "Total Duration" := 0;         
    end;
}


tableextension 62003 DxJobPlanningLine extends "Job Planning Line" 
{
    fields
    {
        field(62000;"Start Time";Time)
        {
            Caption = 'Start Time';
            trigger OnValidate();
            var 
                SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not SpecialUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("Start Time"),true) then begin
                    InitJobTimes;
                    exit;
                end;
                if "Start Time" = xRec."Start Time" then exit;
                Validate("Start Date Time",CreateDateTime("Planning Date","Start Time"))
            end;
        }
        field(62001;"End Time";Time)
        {
            Caption = 'End Time';
            trigger OnValidate();
            var
                SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not SpecialUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("End Time"),true) then begin
                    InitJobTimes;
                    exit;
                end;
                if "End Time" < "Start Time" then
                    Validate("End Date Time",CreateDateTime("Planning Date"+1,"End Time"))
                else
                    Validate("End Date Time",CreateDateTime("Planning Date","End Time"));
            end;
        }
        field(62003;"Start Date Time";DateTime)
        {
            Caption = 'Start Date Time';
            trigger OnValidate();
            var
                SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not SpecialUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("Start Date Time"),true) then begin
                    InitJobTimes;
                    exit;
                end;
                if "Start Date Time" = xRec."Start Date Time" then exit;
                if "Start Date Time" > "End Date Time" then
                    "End Date Time" := "Start Date Time";
                Validate("End Date Time");
                "Start Time" := DT2Time("Start Date Time");
            end;
        }
        field(62004;"End Date Time";DateTime)
        {
            Caption = 'End Date Time';
            trigger OnValidate();
            var
                SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not SpecialUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("End Date Time"),true) then begin
                    InitJobTimes;
                    exit;
                end;
                if ("Start Date Time" = 0DT) or ("End Date Time" = 0DT) then begin
                    "Total Duration" := 0;
                    exit;
                end;
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
                SpecialUnitHandler : Codeunit DxHourlyUnitHandler;
            begin
                if not SpecialUnitHandler.ValidateHourlyUnitOfMeasure("Unit of Measure Code",FieldCaption("Total Duration"),true) then begin
                    InitJobTimes;
                    exit;
                end;
                if "Total Duration" = 0 then exit;
                UnitOfMeasure.get("Unit of Measure Code");
                Validate(
                    Quantity, 
                    ROUND(
                        ROUND("Total Duration"/3600000,0.00001),
                        UnitOfMeasure."Time Rounding",
                        '>'));
                if (CurrFieldNo = FieldNo("Total Duration")) and 
                    ("Start Date Time" <> 0DT) 
                then 
                    "End Date Time" := "Start Date Time" + "Total Duration";
            end;
        }
    }
    
    procedure InitJobTimes();
    begin
        "Start Time" := 0T;
        "Start Date Time" := 0DT;
        "End Time" := 0T;
        "End Date Time" := 0DT;
        "Total Duration" := 0;         
    end;
}


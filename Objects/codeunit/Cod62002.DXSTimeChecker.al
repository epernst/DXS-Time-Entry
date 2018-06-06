codeunit 62002 "DXS TimeChecker"
{
    trigger OnRun();
    begin
    end;
    
    var
        EndTimeNotTodayErr : Label 'The end time must be on the same date as the start date-time.';
        EndTimeNotTodayMsg : Label 'You need to create a new line to enter an end time after %1.';
        EndTimeNotNextDayErr : Label 'The end date-time %1 is too late. It can only be same or next day from %2.';

    procedure ValidateStartAndEndTimes(StartDateTime : DateTime; EndDateTime : DateTime; ShowError : Boolean) : Boolean;
    var
        TimeEntrySetup : Record "DXS TimeEntrySetup";
        ErrorText : Text;
        IsValidated : Boolean;
    begin
        IsValidated := true;
        with TimeEntrySetup do begin
            if not GetSetupIfEnabled() then exit(false);
            case "Allow Entries to Pass Midnight" of
                "Allow Entries to Pass Midnight"::No :
                    if DT2Date(StartDateTime) < DT2Date(EndDateTime) then begin
                        IsValidated := false;
                        ErrorText := StrSubstNo(EndTimeNotTodayErr,DT2Date(StartDateTime)) + ' ' +
                            StrSubstNo(EndTimeNotTodayMsg,DT2Date(StartDateTime));
                    end;
                "Allow Entries to Pass Midnight"::NextDay : 
                    if DT2Date(StartDateTime) + 1 < DT2Date(EndDateTime) then begin
                        IsValidated := false;
                        ErrorText := StrSubstNo(EndTimeNotNextDayErr,DT2Date(EndDateTime),DT2Date(StartDateTime));
                    end;
                "Allow Entries to Pass Midnight"::MultipleDays : IsValidated := true;
            end;
        end;

        OnAfterValidateStartAndEndTimes(StartDateTime,EndDateTime,ErrorText,IsValidated);
        if ShowError and not IsValidated then
            error(ErrorText);
        
        exit(IsValidated);

    end;

    [BusinessEvent(false)]
    local procedure OnAfterValidateStartAndEndTimes(StartDateTime : DateTime; EndDateTime : DateTime; var ErrorText : Text; var IsValidated : Boolean);
    begin
    end;
}
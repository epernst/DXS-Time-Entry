page 62001 DxsTimeEntrySetupWizard
{
    Caption = 'Time Entry Setup';
    PageType = NavigatePage;
    SourceTable = DxsTimeEntrySetup;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(TopBannerStart)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and not FinishStepVisible;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(TopBannersFinish)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and FinishStepVisible;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(StartStep)
            {
                Caption = '';
                Visible = StartStepVisible;
                group(WelcomeToSetup)
                {
                    Caption = 'Welcome to Time Entry Setup';
                    group(Welcome)
                    {
                        Caption = '';
                        InstructionalText = 'This Time Entry App will allow you to enter Start and End times into job planning lines, job journals or resource journals.';
                    }
                    group(Welcome2)
                    {
                        Caption = '';
                        InstructionalText = 'The app will use the entries to calculate the actual used time as a quantity in hours. The times are posted on the job and resource ledger entries.';
                    }
                }
                group(LetsGo)
                {
                    Caption = 'Let''s go!';
                    group(LetsGoGo)
                    {
                        Caption = '';
                        InstructionalText = 'This wizard will take you through the setup in just a few steps, and you are ready to use it.';
                    }
                }
            }

            group(HourlyUnitsStep)
            {
                Caption = '';
                Visible = HourlyUnitsStepVisible;

                group(LimitUse)
                {
                    Caption = 'Where to use Start and End times?';
                    InstructionalText = 'Limit the use of Start and End times to selected hourly units of measure codes?';
                }
                group(LimitUse2)
                {
                    Caption = '';
                    InstructionalText = ' If not selected then Start and End times can be used on all entries. If selected, then on the next step you must specify which unit of measure codes to use.';
                }

                group(HourlyUnits)
                {
                    Caption = '';
                    field("Hourly Units Only"; "Hourly Units Only")
                    {
                        ApplicationArea = All;
                    }
                }
                group(DefaultTimeRounding)
                {
                    Caption = '';
                    Visible = not "Hourly Units Only";
                    InstructionalText = 'Please enter need a Time Default Rounding. Default value "0.25" will round up to nearest 15 minute interval. "1" will round up to nearest full hour.';
                    field("Default Time Rounding"; "Default Time Rounding")
                    {
                        ToolTip = 'Specify how to round start and end time based entries. For example enter 0.25 to have 15 minutes as the minimum time to use. The field is mandatory if "Hourly Units Only" has not been selected.';
                        ApplicationArea = All;
                    }
                }
            }

            group(UnitOfMeasureStep)
            {
                InstructionalText = 'Please specify which unit of measure codes to use as "Hourly Units". I have already marked codes which might be hours. ';
                Caption = '';
                Visible = UnitOfMeasureStepVisible;
                part(UnitOfMeasurePart; DxsUnitOfMeasurePart)
                {
                    ApplicationArea = All;
                    Caption = '';
                }
                group(TimeRounding)
                {
                    Caption = '';
                    InstructionalText = 'Hourly Units also need a Time Rounding. Default value "0.25" will round up to nearest 15 minute interval. "1" will round up to nearest full hour.';
                }
            }
            group(MultiDayStep)
            {
                Caption = '';
                Visible = MultiDayStepVisible;
                InstructionalText = 'Do you want to allow times to pass midnight, or be multiple days?';
                field("Allow Entries to Pass Midnight"; "Allow Entries to Pass Midnight")
                {
                    ApplicationArea = All;
                }
                field("Fields To Show"; "Fields To Show")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        ShowMixTimes := "Fields To Show" = "Fields To Show"::Mix;
                    end;
                }
                group(ShowMix)
                {
                    Caption = '';
                    Visible = ShowMixTimes;
                    field("Show Start Times"; "Show Start Times")
                    {
                        ApplicationArea = All;
                    }
                    field("Show End Times"; "Show End Times")
                    {
                        ApplicationArea = All;
                    }
                    field("Show Start Date-Times"; "Show Start Date-Times")
                    {
                        ApplicationArea = All;
                    }
                    field("Show End Date-Times"; "Show End Date-Times")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(FinishStep)
            {
                Caption = '';
                Visible = FinishStepVisible;
                group(FinishStepInstuction)
                {
                    Caption = '';
                    InstructionalText = 'Only thing left is to Finish. This will enable the app and make it visible to your users.';
                }
                group(ThatsIt)
                {
                    Caption = 'That''s it!';
                    group(ThatsItGrp)
                    {
                        Caption = '';
                        InstructionalText = 'To save this setup, choose Finish.';
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction();
                begin
                    FinishAction;
                end;
            }
        }
    }

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        Step: Option Start, HourlyUnitsStep, UnitOfMeasureStep, MultiDayStep, Finish;
        LastStep: Option Start, HourlyUnitsStep, UnitOfMeasureStep, MultiDayStep, Finish;
        HasHourlyUnitsOfMeasure: Boolean;
        ShowMixTimes: Boolean;
        UnitOfMeasureVisible: Boolean;
        TopBannerVisible: Boolean;
        StartStepVisible: Boolean;
        HourlyUnitsStepVisible: Boolean;
        UnitOfMeasureStepVisible: Boolean;
        MultiDayStepVisible: Boolean;
        RegistrationStepVisible: Boolean;
        FinishStepVisible: Boolean;
        FinishActionEnabled: Boolean;
        BackActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        TempUnitOfMeasure: Record "Unit of Measure" temporary;
        NoHourlyUnitsSelectedErr: Label 'You have not selected any hourly units of measures. Please select at least one, before you continue.';
        SetupNotCompleteQst: Label 'DXS Time Entry setup have not been completed.\\Are you sure you want to exit?';

    trigger OnInit();
    begin
        LoadTopBanners;
    end;

    trigger OnOpenPage();
    var
        TimeEntrySetup: Record DxsTimeEntrySetup;
        AssistedSetup: Codeunit DxsTimeAssistedSetup;
    begin
        AssistedSetup.VerifyUserAccess;
        Init;
        if TimeEntrySetup.Get then
            TransferFields(TimeEntrySetup);
        Insert;

        Step := Step::Start;
        EnableControls;
        ResetTempUnitOfMeasure;
    end;

    local procedure EnableControls();
    begin
        ResetControls;

        case Step of
            Step::Start :
                ShowStartStep;
        Step::HourlyUnitsStep :
                ShowHourlyUnitsStep;
        Step::UnitOfMeasureStep :
                ShowUnitOfMeasureStep;
        Step::MultiDayStep :
                ShowMultiDayStep;
        Step::Finish :
                ShowFinishStep;
        end;
    end;

    local procedure FinishAction();
    begin
        Status := Status::Completed;

        StoreTimeEntrySetup;
        if "Hourly Units Only" then
            StoreUnitOfMeasure;
        CurrPage.Close;
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        LastStep := Step;
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls;
    end;

    local procedure ShowStartStep();
    begin
        StartStepVisible := true;

        BackActionEnabled := false;
    end;

    local procedure ShowHourlyUnitsStep();
    begin
        HourlyUnitsStepVisible := true;
    end;

    local procedure ShowUnitOfMeasureStep();
    begin
        if not "Hourly Units Only" then begin
            NextStep(LastStep > Step);
            Exit;
        end;

        UnitOfMeasureStepVisible := true;

        CurrPage.UnitOfMeasurePart.Page.SetRecords(TempUnitOfMeasure);
    end;

    local procedure ShowMultiDayStep();
    var
        OldStep: Integer;
    begin
        if LastStep = LastStep::UnitOfMeasureStep then
            CurrPage.UnitOfMeasurePart.Page.GetRecords(TempUnitOfMeasure);
        if "Hourly Units Only" and(not HasHourlyUnitsOfMeasureTemp) then begin
            OldStep := Step;
            Step := LastStep;
            LastStep := OldStep;
            Message(NoHourlyUnitsSelectedErr);
            EnableControls;
            Exit;
        end;

        Validate("Fields To Show");
        ShowMixTimes := "Fields To Show" = "Fields To Show"::Mix;
        MultiDayStepVisible := true;
        FinishActionEnabled := false;
    end;

    local procedure ShowRegistrationStep();
    var
        OldStep: Integer;
    begin
        RegistrationStepVisible := true;
        FinishActionEnabled := false;
        NextActionEnabled := "Registration E-Mail Address" <> '';
    end;

    local procedure ShowFinishStep();
    begin
        FinishStepVisible := true;
        NextActionEnabled := false;

        FinishActionEnabled := true;
    end;

    local procedure SkipStep(): Integer;
    begin
        if LastStep < Step then
            Exit(Step + 1);
        Exit(Step - 1);
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        StartStepVisible := false;
        HourlyUnitsStepVisible := false;
        UnitOfMeasureStepVisible := false;
        MultiDayStepVisible := false;
        RegistrationStepVisible := false;
        FinishStepVisible := false;
        UnitOfMeasureVisible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType)) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HASVALUE;
    end;

    local procedure ResetTempUnitOfMeasure();
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        TempUnitOfMeasure.DeleteAll;
        with UnitOfMeasure do
        begin
            if IsEmpty then exit;
            FindSet;
            repeat
                TempUnitOfMeasure.TransferFields(UnitOfMeasure);
                TempUnitOfMeasure.Insert;
            until next = 0;
        end;
    end;

    local procedure StoreUnitOfMeasure();
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        HasHourlyUnitsOfMeasure := false;
        with TempUnitOfMeasure do
        begin
            if IsEmpty then exit;
            FindSet;
            repeat
                UnitOfMeasure.TransferFields(TempUnitOfMeasure);
                if UnitOfMeasure.Modify then;
                if "DXS Hourly Unit" then HasHourlyUnitsOfMeasure := true;
            until next = 0;
        end;
    end;

    local procedure HasHourlyUnitsOfMeasureTemp(): Boolean;
    var
        NotEmpty: Boolean;
    begin
        with TempUnitOfMeasure do
        begin
            SetRange("DXS Hourly Unit", true);
            NotEmpty := Not IsEmpty;
            SetRange("DXS Hourly Unit");
            exit(NotEmpty);
        end;
    end;

    local procedure StoreTimeEntrySetup();
    var
        TimeEntrySetup: Record DxsTimeEntrySetup;
    begin
        if not TimeEntrySetup.Get then begin
            TimeEntrySetup.Init;
            TimeEntrySetup.Insert;
        end;

        TimeEntrySetup.TransferFields(Rec, false);
        TimeEntrySetup."App Enabled" := true;
        TimeEntrySetup.Modify(true);
        Commit;
    end;

}

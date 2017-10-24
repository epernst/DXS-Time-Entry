page 62001 DxTimeEntrySetupWizard
{
    CaptionML=ENU='Time Entry Setup';
    PageType = NavigatePage;
    SourceTable = DxTimeEntrySetup;
    SourceTableTemporary=true;

    layout
    {
        area(content)
        {
            group(TopBannerStart)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible AND NOT FinishStepVisible;
                field(MediaResourcesStandard;MediaResourcesStandard."Media Reference")
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
                Visible = TopBannerVisible AND FinishStepVisible;
                field(MediaResourcesDone;MediaResourcesDone."Media Reference")
                {
                  Editable=false;
                  ShowCaption=false;
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
                Caption = 'Where to use Start and End times?';
                InstructionalText = 'Use start and end times with all entries or limit to hourly units of measure codes?';
                Visible = HourlyUnitsStepVisible;

                group(HourlyUnits)
                {
                    Caption = '';
                    field("Hourly Units Only";"Hourly Units Only")
                    {
                        Caption = 'Only with hourly marked unit of measure codes (recommended)?';
                        ApplicationArea = All;
                        
                        trigger OnValidate();
                        begin
                            NextActionEnabled := true;
                            UnitOfMeasureVisible := "Hourly Units Only";
                            AllUnits := NOT "Hourly Units Only";                       
                        end;
                    }
                    field(AllUnits;AllUnits)
                    {
                        Caption = 'Use in all type of entries, no matter unit of measure?';
                        ApplicationArea = All;
                        
                        trigger OnValidate();
                        begin
                            NextActionEnabled := true;
                            "Hourly Units Only" := not AllUnits;
                            UnitOfMeasureVisible := "Hourly Units Only"                         
                        end;
                    }
                    group(SelectToGo)
                    {
                        Caption = '';
                        InstructionalText = 'If selected, then the next page will allow you to specify which unit of measure codes to use.';
                    }
                }   
            }
            
            group(UnitOfMeasureStep)
            {
                InstructionalText = 'Please specify which unit of measure codes to use as "hourly". ';
                Caption = '';
                Visible = UnitOfMeasureStepVisible;
                part(UnitOfMeasurePart;DxUnitOfMeasurePart)
                {
                    ApplicationArea = All;
                    Caption = '';
                }
            }
            group(HourlyUnitOfMeasureStep)
            {
                InstructionalText = 'For the hourly units, also specify how they are rounded. Default value is "0.25", which will round up to nearest 15 minutes. "1" would round up a full hour.  .';
                Caption = '';
                Visible = HourlyUnitOfMeasureStepVisible;
                part(HourlyUnitOfMeasurePart;DxUnitOfMeasurePart)
                {
                    ApplicationArea = All;
                    Caption = '';
                }
            }
            group(MultiDayStep)
            {
                Caption = '';
                Visible = MultiDayStepVisible;
                InstructionalText = 'Do you want to allow times to pass midnight, or be multiple days?';
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
                    group(Group25)
                    {
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
                ApplicationArea=All;
                Caption='Back';
                Enabled=BackActionEnabled;
                Image=PreviousRecord;
                InFooterBar=true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea=All;
                Caption='Next';
                Enabled=NextActionEnabled;
                Image=NextRecord;
                InFooterBar=true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }      
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled=FinishActionEnabled;
                Image=Approve;
                InFooterBar=true;
                trigger OnAction();
                begin
                    FinishAction;
                end;
            }
        }
    }

    var
        MediaRepositoryStandard : Record "Media Repository";
        MediaRepositoryDone : Record "Media Repository";
        MediaResourcesStandard : Record "Media Resources";
        MediaResourcesDone : Record "Media Resources";
        Step : Option Start,HourlyUnitsStep,UnitOfMeasureStep,HourlyUnitOfMeasureStep,MultiDayStep,Finish;
        LastStep : Option Start,HourlyUnitsStep,UnitOfMeasureStep,HourlyUnitOfMeasureStep,MultiDayStep,Finish;
        AllUnits : Boolean;
        HasHourlyUnitsOfMeasure : Boolean;
        UnitOfMeasureVisible : Boolean;
        TopBannerVisible : Boolean;
        StartStepVisible : Boolean;
        HourlyUnitsStepVisible : Boolean;
        HourlyUnitOfMeasureStepVisible : Boolean;
        UnitOfMeasureStepVisible : Boolean;
        MultiDayStepVisible : Boolean;
        FinishStepVisible : Boolean;
        FinishActionEnabled : Boolean;
        BackActionEnabled : Boolean;
        NextActionEnabled : Boolean;
        TempUnitOfMeasure : Record "Unit of Measure" temporary;
        NoHourlyUnitsSelectedErr : Label 'You have not selected any hourly units of measures. Please select at least one, before you continue.';

    trigger OnInit();
    begin
        LoadTopBanners;
    end;

    trigger OnOpenPage();
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
    begin
        init;
        if TimeEntrySetup.Get then
            TransferFields(TimeEntrySetup);
        Insert;

        AllUnits := false;  
        Step := Step::Start;
        EnableControls;

    end;

    local procedure EnableControls();
    begin
        ResetControls;

        case Step of
            Step::Start:
                ShowStartStep;
            Step::HourlyUnitsStep:
                ShowHourlyUnitsStep;
            Step::UnitOfMeasureStep:
                ShowUnitOfMeasureStep;
            Step::HourlyUnitOfMeasureStep:
                ShowHourlyUnitOfMeasureStep;
            Step::MultiDayStep:
                ShowMultiDayStep;
            Step::Finish:
                ShowMultiDayStep;
        end;
    end;

    local procedure FinishAction();
    begin
        StoreTimeEntrySetup;
        CurrPage.Close;
    end;

    local procedure NextStep(Backwards : Boolean);
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

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowHourlyUnitsStep();
    begin
        HourlyUnitsStepVisible := true;
        UnitOfMeasureVisible := "Hourly Units Only";

        FinishActionEnabled := false;
        NextActionEnabled := "Hourly Units Only";
        BackActionEnabled := false;
    end;

    local procedure ShowUnitOfMeasureStep();
    begin
        if not "Hourly Units Only" then begin
            if LastStep < Step then
                step += 1
            else 
                step -= 1; 
            NextStep(LastStep > step);
            Exit;
        end;

        UnitOfMeasureStepVisible := true;
        FinishActionEnabled := true;
        NextActionEnabled := true;
        BackActionEnabled := true;

        SetUnitOfMeasure(false);
    end;
    local procedure ShowHourlyUnitOfMeasureStep();
    begin
        if not "Hourly Units Only" then begin
            if LastStep < Step then
                step += 1
            else 
                step -= 1; 
            NextStep(LastStep > step);
            Exit;
        end;
        CurrPage.UnitOfMeasurePart.Page.Get(TempUnitOfMeasure);
        if not HasHourlyUnitsOfMeasureTemp(true) then begin
            step := LastStep;
            Message(NoHourlyUnitsSelectedErr);
            NextStep(true);
            Exit;           
        end;

        SetUnitOfMeasure(true);
        HourlyUnitOfMeasureStepVisible := true;
        FinishActionEnabled := true;
        NextActionEnabled := true;
        BackActionEnabled := true;
    end;

    local procedure ShowMultiDayStep();
    begin
        MultiDayStepVisible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        StartStepVisible := false;
        HourlyUnitsStepVisible := false;
        UnitOfMeasureStepVisible := false;
        HourlyUnitOfMeasureStepVisible := false;
        MultiDayStepVisible := false;
        FinishStepVisible := false;
        UnitOfMeasureVisible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png',Format(CURRENTCLIENTTYPE)) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png',Format(CURRENTCLIENTTYPE))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HASVALUE;
    end;

    local procedure SetUnitOfMeasure(HourlyUnitsFilter : Boolean);
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin
        TempUnitOfMeasure.deleteall;
        HasHourlyUnitsOfMeasure := false;
        with UnitOfMeasure do begin
            if HourlyUnitsFilter then
                SetRange("Hourly Unit");
            if IsEmpty then exit;
            FindSet;
            repeat 
                TempUnitOfMeasure.TransferFields(UnitOfMeasure);
                TempUnitOfMeasure.insert;
                if "Hourly Unit" then HasHourlyUnitsOfMeasure := true;
            until next = 0;
            if HourlyUnitsFilter then
                CurrPage.HourlyUnitOfMeasurePart.Page.Set(TempUnitOfMeasure)
            else
                CurrPage.UnitOfMeasurePart.Page.Set(TempUnitOfMeasure);            
        end;
    end;

    local procedure StoreUnitOfMeasure(HourlyUnitsFilter : Boolean);
    var
        UnitOfMeasure : Record "Unit of Measure";
    begin
        HasHourlyUnitsOfMeasure := false;
        if HourlyUnitsFilter then
            CurrPage.HourLyUnitOfMeasurePart.Page.Get(TempUnitOfMeasure)
        else
            CurrPage.UnitOfMeasurePart.Page.Get(TempUnitOfMeasure);
        with TempUnitOfMeasure do begin
            if IsEmpty then exit;
            FindSet;
            repeat 
                UnitOfMeasure.TransferFields(TempUnitOfMeasure);
                if UnitOfMeasure.Modify then;
                if "Hourly Unit" then HasHourlyUnitsOfMeasure := true;
            until next = 0;
        end;
    end;
    local procedure HasHourlyUnitsOfMeasureTemp(HourlyUnitsFilter : Boolean) : Boolean;
    begin
        if HourlyUnitsFilter then
            CurrPage.HourLyUnitOfMeasurePart.Page.Get(TempUnitOfMeasure)
        else
            CurrPage.UnitOfMeasurePart.Page.Get(TempUnitOfMeasure);
        with TempUnitOfMeasure do begin
            SetRange("Hourly Unit", true);
            exit(isempty);
        end;
    end;

    local procedure StoreTimeEntrySetup();
    var
        TimeEntrySetup : Record DxTimeEntrySetup;
    begin
        if not TimeEntrySetup.Get then begin
            TimeEntrySetup.Init;
            TimeEntrySetup.Insert;
        end;

        TimeEntrySetup.TransferFields(Rec,false);
        TimeEntrySetup.Modify(true);
        Commit;
    end;

}

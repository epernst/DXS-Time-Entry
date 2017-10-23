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
                Visible = TopBannerVisible AND NOT Step3Visible;
                field(MediaResourcesStandard;MediaResourcesStandard."Media Reference")
                {
                  ApplicationArea = All;
                  Editable = false;
                  ShowCaption = false;
                }
            }
            group(TopBannersEnd)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible AND Step3Visible;
                field(MediaResourcesDone;MediaResourcesDone."Media Reference")
                {
                  Editable=false;
                  ShowCaption=false;
                }
            }

            group(StartStep)
            {
                Caption = '';
                Visible=StartStepVisible;
                group(WelcomeToSetup)
                {
                    Caption = 'Welcome to Time Entry Setup';
                    Visible = HourlyUnitsStepVisible;
                    group(Welcome)
                    {
                        InstructionalText = 'This "Time Entry App" allow you to use Start and end times when entering into the job planning liens, job or resource journals. It uses the entries to calculate the actual used quantity in hours.';
                    }
                }
                group(LetsGo)
                {
                    Caption='Let''s go!';
                    group(LetsGoGo)
                    {
                        InstructionalText = 'This wizard will take you through the setup in just a few steps, and you are ready to use it.';
                    }
                }
            }

            group(HourlyUnitsStep)
            {
                Caption = '';
                InstructionalText = 'Use start and end times with all entris or limit to hourly units of measure codes?';
                Visible = HourlyUnitsStepVisible;

                group(HourlyUnits)
                {
                    InstructionalText = 'Allow only use of start and end times with unit of measure codes(ex. HOUR). if selected, then the next page will allow you to specify which unit of measure codes to use.';
                    field("Hourly Units Only";"Hourly Units Only")
                    {
                        ApplicationArea = All;
                        
                        trigger OnValidate();
                        begin
                            UnitOfMeasureVisible := "Hourly Units Only";
                            AllUnits := NOT "Hourly Units Only";                       
                        end;
                    }
                    field(AllUnits;AllUnits)
                    {
                        Caption = 'All Units Allowed';
                        ApplicationArea = All;
                        
                        trigger OnValidate();
                        begin
                            "Hourly Units Only" := not AllUnits;
                            UnitOfMeasureVisible := "Hourly Units Only"                         
                        end;
                    }
                }   
                group(UnitOfMeasures)
                {
                    InstructionalText = 'Please specify which unit of measure codes to use as "hourly". ';
                    Visible = UnitOfMeasureVisible;
                    Caption = '';
                }
            }
            
            group(Step2)
            {
                InstructionalText = 'You have allow only to use start and end times with unit of measure codes(ex. HOUR), marked as "Hourly Unis". Please select the hourly unit of measure codes.';
                Visible = Step2Visible;

            }
            group(Step3)
            {
                Visible=Step3Visible;
                group(Group23)
                {
                    InstructionalText = 'Step3 - Replace this text with some instructions.';
                }
                group("That's it!")
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
        Step : Option Start,HourlyUnitsStep,Step2,Finish;
        AllUnits : Boolean;
        UnitOfMeasureVisible : Boolean;
        TopBannerVisible : Boolean;
        StartStepVisible : Boolean;
        HourlyUnitsStepVisible : Boolean;
        Step2Visible : Boolean;
        Step3Visible : Boolean;
        FinishStepVisible : Boolean;
        FinishActionEnabled : Boolean;
        BackActionEnabled : Boolean;
        NextActionEnabled : Boolean;

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

        AllUnits := NOT "Hourly Units Only";                       
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
            Step::Step2:
                ShowStep2;
            Step::Finish:
                ShowStep3;
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


    local procedure FinishAction();
    begin
        StoreTimeEntrySetup;
        CurrPage.Close;
    end;

    local procedure NextStep(Backwards : Boolean);
    begin
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
        BackActionEnabled := false;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;
        FinishActionEnabled := true;
        BackActionEnabled := true;
    end;

    local procedure ShowStep3();
    begin
        Step3Visible := true;

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
        Step2Visible := false;
        Step3Visible := false;
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
}
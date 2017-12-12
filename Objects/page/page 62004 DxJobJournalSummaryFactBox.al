page 62004 DxJobJournalSummaryFactBox
{
    Caption = 'Job Summary';
    PageType=CardPart;
    SourceTable="Job Journal Line";

    layout
    {
        area(content)
        {
            group(Journal)
            {
                Caption = 'Job Journal - This job';
              
                field(BillableHoursJournal;BillableHours[1])
                {
                    Caption = 'Hours, billable';
                    ToolTip = 'Shows the number of billable hours for this job in this job journal.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobJournal(
                            "Journal Template Name",
                            "Journal Batch Name",
                            "Job No.",
                            DrillDownField::BillableHours)
                    end;
                }
                field(NonBillableHoursJournal;NonBillableHours[1])
                {
                    Caption = 'Hours, non-billable';
                    ToolTip = 'Shows the number of non-billable hours for this job in this job journal.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobJournal(
                            "Journal Template Name",
                            "Journal Batch Name",
                            "Job No.",
                            DrillDownField::NonBillableHours)
                    end;
                }
                field(TotalSalesJournal;TotalSales[1])
                {
                    Caption = 'Total sales, job';
                    ToolTip = 'Shows sales total for this job in this job journal.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobJournal(
                            "Journal Template Name",
                            "Journal Batch Name",
                            "Job No.",
                            DrillDownField::TotalSales);
                    end;
                }
                field(TotalCost1;TotalCost[1])
                {
                    Caption = 'Total costs, job';
                    ToolTip = 'Shows the cost total for this job in this job journal.';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobJournal(
                            "Journal Template Name",
                            "Journal Batch Name",
                            "Job No.",
                            DrillDownField::TotalCost)
                    end;
                }
                field(TotalProfit1;TotalProfit[1])
                {
                    Caption = 'Total profit, job';
                    ToolTip = 'Shows the total profit this job in this job journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PricePerHour1;AvgPricePerUOM[1])
                {
                    Caption = 'Price per hour';
                    ToolTip = 'Shows the average price per hour job in this job journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Usage)
            {
                Caption = 'Job Usage';
                field(TimeInvoiceable3;BillableHours[3])
                {
                    Caption = 'Hours, billable';
                    ToolTip = 'Shows the number of billable hours previously used for this job.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobLedgerEntry(
                            "Job No.",
                            DrillDownField::BillableHours);
                    end;
                }
                field(TimeNonInvoice3;NonBillableHours[3])
                {
                    Caption = 'Hours, not billable';
                    ToolTip = 'Shows the number of non-billable hours previously used for this job.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobLedgerEntry(
                            "Job No.",
                            DrillDownField::NonBillableHours);
                    end;
                }
                field(TotalSales3;TotalSales[3])
                {
                    Caption = 'Total sales, job';
                    ToolTip = 'Shows the total sales previously posted for this job.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                      DrillDownFactbox.DrillDownJobLedgerEntry(
                        "Job No.",
                        DrillDownField::TotalSales);
                    end;
                }
                field(TotalCost3;TotalCost[3])
                {
                    Caption = 'Total costs, job';
                    ToolTip = 'Shows the total costs previously posted for this job.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        DrillDownFactbox.DrillDownJobLedgerEntry(
                            "Job No.",
                            DrillDownField::TotalCost)
                    end;
                }
                field(TotalProfit3;TotalProfit[3])
                {
                  Caption = 'Total profit, job';
                  ToolTip = 'Shows the total previously posted for this job.';
                  Editable = false;
                  ApplicationArea = All;
                }
                field(PricePerHour3;AvgPricePerUOM[3])
                {
                  Caption = 'Price per hour';
                  ToolTip = 'Shows the average hourly rate previously used for this job.';
                  Editable = false;
                  ApplicationArea = All;
                  trigger OnDrillDown();
                  begin
                      DrillDownFactbox.DrillDownJobLedgerEntry(
                          "Job No.",
                          DrillDownField::TotalProfit)
                  end;
                }
            }
            group(Total)
            {
                Caption = 'Job Journal - All Jobs';
                field(TimeInvoiceable4;BillableHours[4])
                {
                    Caption = 'Hours, billable';
                    ToolTip = 'Shows the number of billable hours for, all job in this journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TimeNonInvoice4;NonBillableHours[4])
                {
                    Caption = 'Hours, not billable';
                    ToolTip = 'Shows the number of non-billable hours, for all job in this journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalSales4;TotalSales[4])
                {
                    Caption = 'Total sales, job';
                    ToolTip = 'Shows the number of total sales, for all job in this journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalCost4;TotalCost[4])
                {
                    Caption = 'Total costs, job';
                    ToolTip = 'Shows the number of total costs, for all job in this journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalProfit4;TotalProfit[4])
                {
                    Caption = 'Total profit, job';
                    ToolTip = 'Shows the number of total profit, for all job in this journal.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PricePerHour4;AvgPricePerUOM[4])
                {
                    Caption = 'Price per hour';
                    ToolTip = 'Shows the average hourly rate, for all job in this journal.';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
       UpdateData(Rec);
    end;

    trigger OnFindRecord(Which : Text) : Boolean;
    begin
        CLEAR(BillableHours);
        CLEAR(NonBillableHours);
        CLEAR(TotalSales);
        CLEAR(TotalCost);
        CLEAR(TotalProfit);
        CLEAR(AvgPricePerUOM);

        exit(FIND(Which));
    end;

    trigger OnOpenPage();
    begin
        UpdateData(Rec);
    end;

    var
        DrillDownFactbox : Codeunit DxsDrillDownJobFactBox;
        BillableHours : array [5] of Decimal;
        NonBillableHours : array [5] of Decimal;
        TotalSales : array [5] of Decimal;
        TotalCost : array [5] of Decimal;
        TotalProfit : array [5] of Decimal;
        AvgPricePerUOM : array [5] of Decimal;
        DrillDownField : Option BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit;
        Job : Record Job;

    procedure UpdateData(JobJournalLine : Record "Job Journal Line");
    var
        UpdateFactbox : Codeunit DxsJobFactboxUpdater;
    begin
        if not Job.GET("Job No.") then Job.INIT;
        UpdateFactbox.UpdateJobJurnalData(JobJournalLine,BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit,AvgPricePerUOM);    
    end;
}

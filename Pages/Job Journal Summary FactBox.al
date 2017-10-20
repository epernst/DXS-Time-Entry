page 62004 "Job Journal Summary FactBox"
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
        Caption = 'Job Journal';
        field("Job Name";Job.Description)
        {
          Caption = 'Job Name';
          ApplicationArea = All;
        }
        field(BillableHoursJournal;BillableHours[1])
        {
          Caption = 'Hours, billable';
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
          Caption = 'Hours, not billable';
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
          Editable = false;
          ApplicationArea = All;
        }
        field(PricePerHour1;AvgPricePerUOM[1])
        {
          Caption = 'Price per hour';
          Editable = false;
          ApplicationArea = All;
        }
      }
      group(TimeSheet)
      {
        Caption = 'Time Sheet';
        Visible=ShowTimeSheet;
        field(TimeInvoiceable2;BillableHours[2])
        {
          Caption = 'Hours, billable';
          Editable = false;
          ApplicationArea = All;
        }
        field(TimeNonInvoice2;NonBillableHours[2])
        {
          Caption = 'Hours, not billable';
          ApplicationArea = All;
          Editable = false;
        }
        field(TotalSales2;TotalSales[2])
        {
          Caption = 'Total sales, time';
          Editable = false;
          ApplicationArea = All;
        }
        field(TotalCost2;TotalCost[2])
        {
          Caption = 'Total costs, job';
          Editable = false;
          ApplicationArea = All;
        }
        field(TotalProfit2;TotalProfit[2])
        {
          Caption = 'Total profit, job';
          Editable = false;
          ApplicationArea = All;
        }
        field(PricePerHour2;AvgPricePerUOM[2])
        {
          Caption = 'Price per hour';
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
          Editable = false;
          ApplicationArea = All;
        }
        field(PricePerHour3;AvgPricePerUOM[3])
        {
          Caption = 'Price per hour';
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
        Caption = 'Job Usage';
        field(TimeInvoiceable4;BillableHours[4])
        {
          Caption = 'Hours, billable';
          Editable = false;
          ApplicationArea = All;
        }
        field(TimeNonInvoice4;NonBillableHours[4])
        {
          Caption = 'Hours, not billable';
          Editable = false;
          ApplicationArea = All;
        }
        field(TotalSales4;TotalSales[4])
        {
          Caption = 'Total sales, job';
          Editable = false;
          ApplicationArea = All;
        }
        field(TotalCost4;TotalCost[4])
        {
          Caption = 'Total costs, job';
          Editable = false;
          ApplicationArea = All;
        }
        field(TotalProfit4;TotalProfit[4])
        {
          Caption = 'Total profit, job';
          Editable = false;
          ApplicationArea = All;
        }
        field(PricePerHour4;AvgPricePerUOM[4])
        {
          Caption = 'Price per hour';
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
    DrillDownFactbox : Codeunit DxDrillDownJobFactBoxes;
    BillableHours : array [5] of Decimal;
    NonBillableHours : array [5] of Decimal;
    TotalSales : array [5] of Decimal;
    TotalCost : array [5] of Decimal;
    TotalProfit : array [5] of Decimal;
    AvgPricePerUOM : array [5] of Decimal;
    ShowTimeSheet : Boolean;
    DrillDownField : Option BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit;
    Job : Record Job;

  procedure UpdateData(JobJournalLine : Record "Job Journal Line");
  var
    UpdateFactbox : Codeunit DxUpdateFactboxData;
  begin
    if not Job.GET("Job No.") then Job.INIT;
    UpdateFactbox.UpdateData(JobJournalLine,BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit,AvgPricePerUOM,ShowTimeSheet);    
  end;
}

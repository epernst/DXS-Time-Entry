page 62005 "Job Summary FactBox"
{
  Caption='Job Summary';
  PageType=CardPart;
  SourceTable=Job;

  layout
  {
    area(content)
    {
      group(JobJournal)
      {
        Caption = 'Job Journal';
        field(TimeInvoicableJournal;TimeInvoicable[1])
        {
          Caption='Hours, chargeable';
          Editable=false;
        }
        field(TimeNonChargableJournal;TimeNonInvoice[1])
        {
          Caption='Hours, non-chargeable';
          Editable=false;
        }
        field(PricePerHourJournal;AvgPricePerUOM[1])
        {
          Caption='Price per hour';
          Editable=false;
        }
      }
      group(TimeSheet)
      {
        Caption = 'Time Sheets';
        field(TimeInvoicableTimeSheet;TimeInvoicable[2])
        {
          Caption='Hours, chargeable';
          Editable=false;
        }
        field(TimeNonChargableTimeSheet;TimeNonInvoice[2])
        {
          Caption='Hours, non-chargeable';
          Editable=false;
        }
      }
      group(JobUsage)
      {
        Caption='Job Usage';
        field(TimeInvoicableUsage;TimeInvoicable[3])
        {
          Caption='Hours, chargeable';
          Editable=false;
        }
        field(TimeNonInvoiceUsage;TimeNonInvoice[3])
        {
          Caption='Hours, non-chargeable';
          Editable=false;
        }
        field(TotalSales;TotalSales[3])
        {
          Caption='Total sales, job';
          Editable=false;
        }
        field(TotalCost;TotalCost[3])
        {
          Caption='Total costs, job';
          Editable=false;
        }
        field(TotalProfit;TotalProfit[3])
        {
          Caption='Total profit, job';
          Editable=false;
        }
        field(PricePerHour3;AvgPricePerUOM[3])
        {
          Caption='Price per hour';
          Editable=false;
        }
      }
    }
  }

  trigger OnAfterGetRecord();
  begin
    UpdateData(Rec);
  end;

  trigger OnFindRecord(Which : Text) : Boolean;
  begin
    CLEAR(TimeInvoicable);
    CLEAR(TimeNonInvoice);
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
    DxJobMgt : Codeunit DxJobFactboxManagement;
    TimeInvoicable : array [5] of Decimal;
    TimeNonInvoice : array [5] of Decimal;
    TotalSales : array [5] of Decimal;
    TotalCost : array [5] of Decimal;
    TotalProfit : array [5] of Decimal;
    AvgPricePerUOM : array [5] of Decimal;

  procedure UpdateData(Job : Record Job);
  begin
    DxJobMgt.CalcJobFactBoxData(
      Job,
      1,
      TimeInvoicable[1],
      TimeNonInvoice[1],
      TotalSales[1],
      TotalCost[1],
      TotalProfit[1],
      AvgPricePerUOM[1]);
    DxJobMgt.CalcJobFactBoxData(
      Job,
      2,
      TimeInvoicable[2],
      TimeNonInvoice[2],
      TotalSales[2],
      TotalCost[2],
      TotalProfit[2],
      AvgPricePerUOM[2]);
    DxJobMgt.CalcJobFactBoxData(
      Job,
      3,
      TimeInvoicable[3],
      TimeNonInvoice[3],
      TotalSales[3],
      TotalCost[3],
      TotalProfit[3],
      AvgPricePerUOM[3]);

    CurrPage.UPDATE(false);
  end;
}

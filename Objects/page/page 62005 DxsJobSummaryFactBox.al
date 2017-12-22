page 62005 DxsJobSummaryFactBox
{
    Caption = 'Job Summary';
    PageType = CardPart;
    SourceTable = Job;

    layout
    {
        area(content)
        {
            group(JobJournal)
            {
                Caption = 'Job Journal';
                field(TimeInvoicableJournal;BillableHours[1])
                {
                    Caption='Hours, billable';
                    Editable=false;
                }
                field(TimeNonChargableJournal;NonBillableHours[1])
                {
                    Caption='Hours, non-billable';
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
                field(TimeInvoicableTimeSheet;BillableHours[2])
                {
                    Caption='Hours, billable';
                    Editable=false;
                }
                field(TimeNonChargableTimeSheet;NonBillableHours[2])
                {
                    Caption='Hours, non-billable';
                    Editable=false;
                }
            }
            group(JobUsage)
            {
                Caption='Job Usage';
                field(TimeInvoicableUsage;BillableHours[3])
                {
                    Caption='Hours, billable';
                    Editable=false;
                }
                field(TimeNonInvoiceUsage;NonBillableHours[3])
                {
                    Caption='Hours, non-billable';
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
        BillableHours : array [5] of Decimal;
        NonBillableHours : array [5] of Decimal;
        TotalSales : array [5] of Decimal;
        TotalCost : array [5] of Decimal;
        TotalProfit : array [5] of Decimal;
        AvgPricePerUOM : array [5] of Decimal;

        procedure UpdateData(Job : Record Job);
        var
            UpdateFactbox : Codeunit DxsJobFactboxUpdater;
        begin
            if not Job.GET(Job."No.") then Job.INIT;
            UpdateFactbox.UpdateJobData(Job,BillableHours,NonBillableHours,TotalSales,TotalCost,TotalProfit,AvgPricePerUOM);    

            CurrPage.UPDATE(false);
        end;
}

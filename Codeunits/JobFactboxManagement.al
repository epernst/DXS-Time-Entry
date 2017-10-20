codeunit 62000 DxJobFactboxManagement
{
  
  procedure CalcJobJnlFactBoxData(
    JobJournalLine : Record "Job Journal Line";
    ViewType : Option CurrentJobJournal,TimeSheet,JobLedgerEntry,TotalJobJournal;
    var BillableHours : Decimal;
    var NonBillableHours : Decimal;
    var TotalSales : Decimal;
    var TotalCost : Decimal;
    var TotalProfit : Decimal;
    var AvgPricePerUOM : Decimal);
  var
    Job : Record Job;
    JobUOM : Codeunit SpecialUnitHandler;
  begin
    if JobUOM.GetUnitOfMeasureHourFilter = '' THEN exit;
    if (not Job.GET(JobJournalLine."Job No.")) and (ViewType <> ViewType::TotalJobJournal) then exit;

    BillableHours := 0;
    NonBillableHours := 0;
    TotalSales := 0;
    TotalCost := 0;
    TotalProfit := 0;
    AvgPricePerUOM := 0;

    case ViewType of
      ViewType::CurrentJobJournal :
        CalculateJobJournal(Job."No.",TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM );
      ViewType::TimeSheet:
        CalculateTimeSheet(job."No.",BillableHours, NonBillableHours);
      ViewType::JobLedgerEntry:
        CalculateJobLedgerEntry(Job."No.",TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
      ViewType::TotalJobJournal:
        CalculateJobJournal('',TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM );
    end;
  end;

  procedure CalcJobFactBoxData(
    Job : Record Job;
    ViewType : Option CurrentJobJournal,TimeSheet,JobLedgerEntry,TotalJobJournal;
    var BillableHours : Decimal;
    var NonBillableHours : Decimal;
    var TotalSales : Decimal;
    var TotalCost : Decimal;
    var TotalProfit : Decimal;
    var AvgPricePerUOM : Decimal);
  var
    JobUOM : Codeunit SpecialUnitHandler;
  begin
    if Job."No." = '' then
      exit;
    if JobUOM.GetUnitOfMeasureHourFilter = '' THEN exit;

    BillableHours := 0;
    NonBillableHours := 0;
    TotalSales := 0;
    TotalCost := 0;
    TotalProfit := 0;
    AvgPricePerUOM := 0;

    case ViewType of
      ViewType::CurrentJobJournal :
        CalculateJobJournal(Job."No.",TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM );
      ViewType::TimeSheet:
        CalculateTimeSheet(job."No.",BillableHours, NonBillableHours);
      ViewType::JobLedgerEntry:
        CalculateJobLedgerEntry(Job."No.",TotalSales, TotalCost, TotalProfit, BillableHours, NonBillableHours, AvgPricePerUOM);
    end;
  end;

  procedure CalculateJobJournal(
    JobNo : Code[20];
    var TotalSales : Decimal;
    var TotalCost : Decimal;
    var TotalProfit : Decimal;
    var BillableHours : Decimal;
    var NonBillableHours : Decimal;
    var AvgPricePerUOM : Decimal);
  var
    JobJournalLine: Record "Job Journal Line";
    JobUOM : Codeunit SpecialUnitHandler;
  begin
    with JobJournalLine do begin
      IF JobNo <> '' then
        SetRange("Job No.",JobNo);
      CALCSUMS("Total Cost (LCY)","Total Price (LCY)");
      TotalSales := "Total Price (LCY)";
      TotalCost := "Total Cost (LCY)";

      SetFilter("Unit of Measure Code",JobUOM.GetUnitOfMeasureHourFilter);
      SetRange(Chargeable,true);
      CALCSUMS(Quantity);
      BillableHours := Quantity;

      SetRange(Chargeable,false);
      CALCSUMS(Quantity);
      NonBillableHours := Quantity;

      AvgPricePerUOM :=
        CalcAvgRate(TotalSales,BillableHours + NonBillableHours);

      TotalProfit := TotalSales - TotalCost;
    end;
  end;

  procedure CalculateJobLedgerEntry(
    JobNo : Code[20];
    var TotalSales : Decimal;
    var TotalCost : Decimal;
    var TotalProfit : Decimal;
    var BillableHours : Decimal;
    var NonBillableHours : Decimal;
    var AvgPricePerUOM : Decimal);
  var
    JobLedgerEntry: Record "Job Ledger Entry";
    JobUOM : Codeunit SpecialUnitHandler;
  begin
    with JobLedgerEntry do begin
      IF JobNo <> '' then
        SetRange("Job No.",JobNo);
      SetRange("Entry Type","Entry Type"::Usage);
      CALCSUMS("Total Cost (LCY)","Total Price (LCY)","Line Amount (LCY)");
      TotalSales := "Line Amount (LCY)";
      TotalCost := "Total Cost (LCY)";

      SetRange("Unit of Measure Code",JobUOM.GetUnitOfMeasureHourFilter);
      SETFILTER("Total Price (LCY)",'<>%1',0);

      CALCSUMS(Quantity);
      BillableHours := Quantity;

      SETFILTER("Total Price (LCY)",'%1',0);
      CALCSUMS(Quantity);
      NonBillableHours := Quantity;

      AvgPricePerUOM :=
        CalcAvgRate(TotalSales,BillableHours + NonBillableHours);

      TotalProfit := TotalSales - TotalCost;
    end;
  end;

  procedure CalculateTimeSheet(
    JobNo : Code[20];
    var BillableHours : Decimal;
    var NonBillableHours : Decimal);
  var
    TimeSheetLine : Record "Time Sheet Line";
    TimeSheetDetail : Record "Time Sheet Detail";
    JobUOM : Codeunit SpecialUnitHandler;
  begin
    BillableHours := 0;
    NonBillableHours := 0;
    with TimeSheetLine do begin
      SetRange(Type,Type::Job);
      SetRange("Job No.",JobNo);
      SetRange(Posted,false);
      SetRange(Chargeable,true);
      if FINDSET then
        repeat
          TimeSheetDetail.SetRange("Time Sheet No.","Time Sheet No.");
          TimeSheetDetail.SetRange("Time Sheet Line No.","Line No.");
          TimeSheetDetail.CALCSUMS(Quantity);
          BillableHours += TimeSheetDetail.Quantity;
        until NEXT = 0;

      SetRange(Chargeable,false);
      if FINDSET then
        repeat
          TimeSheetDetail.SetRange("Time Sheet No.","Time Sheet No.");
          TimeSheetDetail.SetRange("Time Sheet Line No.","Line No.");
          TimeSheetDetail.CALCSUMS(Quantity);
          NonBillableHours += TimeSheetDetail.Quantity;
        until NEXT = 0;
    end;
  end;

  procedure CalcAvgRate(
    SalesTotal : Decimal;
    TotalHours : Decimal) : Decimal;
  begin
    if (SalesTotal <> 0) and (TotalHours <> 0) then
      exit(SalesTotal / TotalHours)
    else
      exit(0);
  end;

  procedure ShowTimeSheet() : Boolean;
  begin
    exit(false);
  end;

}


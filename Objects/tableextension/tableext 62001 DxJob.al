tableextension 62001 DxJob extends Job 
// To be removed?
{
  fields
  {
    field(62001;"Invoicable Amount";Decimal)
    {
      CalcFormula=Sum("Job Planning Line"."Line Amount" WHERE ("Job No."=FIELD("No."),
                                                               "Contract Line"=CONST(true),
                                                               "Qty. to Transfer to Invoice"=FILTER(>0)));
      Caption='Invoicable Amount';
      FieldClass=FlowField;
    }
  }
  keys
  {
  }
}


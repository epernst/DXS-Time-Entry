tableextension 62001 "DXSJob" extends Job
// To be removed?
{
    fields
    {
        field(62001;"DXS Invoicable Amount"; Decimal)
        {
            CalcFormula = Sum ("Job Planning Line"."Line Amount"
              where ("Job No." = field ("No."),
                "Contract Line" = const (true),
                "Qty. to Transfer to Invoice" = filter (> 0)));
            Caption = 'Invoicable Amount';
            FieldClass = FlowField;
            Editable = false;
        }
    }
    keys
    {
    }
}


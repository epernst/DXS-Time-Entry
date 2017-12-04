tableextension 62001 DxsJob extends Job
{
    fields
    {
        field(62001; "DXS Invoiceable Amount"; Decimal)
        {
            CalcFormula = Sum ("Job Planning Line"."Line Amount" WHERE ("Job No." = FIELD ("No."),
                                                               "Contract Line" = CONST (true),
                                                               "Qty. to Transfer to Invoice" = FILTER (> 0)));
            Caption = 'Invoiceable Amount';
            FieldClass = FlowField;
        }
    }
    keys
    {
    }
}


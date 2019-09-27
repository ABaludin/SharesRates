tableextension 50010 "AB_Customer Extension" extends Customer
{
    fields
    {
        field(50000; "Symbols"; Code[10])
        {
            Caption = 'Symbols';
            DataClassification = CustomerContent;
        }
        field(50001; "Rate"; Decimal)
        {
            Caption = 'Stock rate';
            DataClassification = CustomerContent;
        }
    }
}

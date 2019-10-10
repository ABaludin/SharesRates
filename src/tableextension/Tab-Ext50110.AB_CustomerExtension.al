tableextension 50110 "AB_Customer Extension" extends Customer
{
    fields
    {
        field(50000; "Symbols"; Code[10])
        {
            Caption = 'Ticker Symbols';
            DataClassification = CustomerContent;
        }
        field(50001; "Rate"; Decimal)
        {
            Caption = 'Stock rate';
            DataClassification = CustomerContent;
        }
    }
}

table 50011 "AB_DailyRates"
{
    Caption = 'Daily Rates';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Symbols; Code[10])
        {
            Caption = 'Symbols';
            DataClassification = CustomerContent;
        }
        field(2; "Rate Date"; Date)
        {
            Caption = 'Rate Date';
            DataClassification = CustomerContent;
        }
        field(3; Open; Decimal)
        {
            Caption = 'Open';
            DataClassification = CustomerContent;
        }
        field(4; High; Decimal)
        {
            Caption = 'High';
            DataClassification = CustomerContent;
        }
        field(5; Low; Decimal)
        {
            Caption = 'Low';
            DataClassification = CustomerContent;
        }
        field(6; Close; Decimal)
        {
            Caption = 'Close';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Symbols, "Rate Date")
        {
            Clustered = true;
        }
    }

}

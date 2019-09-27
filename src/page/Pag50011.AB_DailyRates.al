page 50011 "AB_Daily Rates"
{

    PageType = List;
    SourceTable = AB_DailyRates;
    Caption = 'Daily Rates';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Symbols; Symbols)
                {
                    ApplicationArea = All;
                }
                field("Rate Date"; "Rate Date")
                {
                    ApplicationArea = All;
                }
                field(Open; Open)
                {
                    ApplicationArea = All;
                }
                field(High; High)
                {
                    ApplicationArea = All;
                }
                field(Low; Low)
                {
                    ApplicationArea = All;
                }
                field(Close; Close)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}

pageextension 50110 "AB_Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(Symbols; Symbols)
            {
                ApplicationArea = All;
            }
            field(Rate; Rate)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            action(AB_GetRate)
            {
                Image = Web;
                Caption = 'Get Rate';
                ApplicationArea = All;

                trigger OnAction()
                var
                    AlphaMgt: Codeunit "AB_Alpha Vantage management";
                begin
                    TestField(Symbols);
                    Rate := AlphaMgt.GetLastRate(Symbols);
                    Modify();
                end;
            }
            action(AB_GetDailyRate)
            {
                Image = Web;
                Caption = 'Get DailyRate';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DailyRates: Record AB_DailyRates;
                    AlphaMgt: Codeunit "AB_Alpha Vantage management";
                begin
                    TestField(Symbols);
                    AlphaMgt.GetDailyRates(Symbols);
                    DailyRates.SetRange(Symbols, Symbols);
                    Page.Run(Page::"AB_Daily Rates", DailyRates);
                end;
            }
        }
    }
}
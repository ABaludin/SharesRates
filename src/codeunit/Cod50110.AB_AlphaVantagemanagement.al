codeunit 50110 "AB_Alpha Vantage management"
{
    procedure GetLastRate(Symbols: code[10]): Decimal
    var
        IntegrationSetup: Record "AB_Integration Setup";
        URL: Text;
        Client: HttpClient;
        Response: HttpResponseMessage;
        ResponseText: Text;
    begin
        IntegrationSetup.Get();
        IntegrationSetup.TestField("API URL");
        IntegrationSetup.TestField("API Token");
        IntegrationSetup.TestField("Last Rate function");

        //https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo

        URL := IntegrationSetup."API URL" +
                '?function=' + IntegrationSetup."Last Rate function" +
                '&symbol=' + Symbols +
                '&apikey=' + IntegrationSetup."API Token";

        if not Client.Get(URL, Response) then
            Error(Text001_Err);

        Response.Content().ReadAs(ResponseText);

        if not Response.IsSuccessStatusCode() then
            Error(Text002_Err, Response.HttpStatusCode(), ResponseText);

        Exit(ParseResponse(ResponseText));

    end;

    local procedure ParseResponse(ResponseText: Text): Decimal
    var
        ContentToken: JsonToken;
        QuoteToken: JsonToken;
        PriceToken: JsonToken;
    begin
        ContentToken.ReadFrom(ResponseText);
        ContentToken.AsObject().Get('Global Quote', QuoteToken);
        QuoteToken.AsObject().Get('05. price', PriceToken);

        Exit(PriceToken.AsValue().AsDecimal());
    end;

    procedure GetDailyRates(Symbols: code[10])
    var
        IntegrationSetup: Record "AB_Integration Setup";
        URL: Text;
        Client: HttpClient;
        Response: HttpResponseMessage;
        ResponseText: Text;
    begin
        IntegrationSetup.Get();
        IntegrationSetup.TestField("API URL");
        IntegrationSetup.TestField("API Token");
        IntegrationSetup.TestField("Daily Rate Function");

        URL := IntegrationSetup."API URL" +
                '?function=' + IntegrationSetup."Daily Rate function" +
                '&symbol=' + Symbols +
                '&apikey=' + IntegrationSetup."API Token";

        if not Client.Get(URL, Response) then
            Error(Text001_Err);

        Response.Content().ReadAs(ResponseText);

        if not Response.IsSuccessStatusCode() then
            Error(Text002_Err, Response.HttpStatusCode(), ResponseText);

        ParseDailyResponse(ResponseText, Symbols);
    end;

    local procedure ParseDailyResponse(ResponseText: Text; Symbols: code[10])
    var
        DailyRate: Record AB_DailyRates;
        ContentToken: JsonToken;
        SeriesToken: JsonToken;
        PriceToken: JsonToken;
        ValueToken: JsonToken;
        StartTokenDate: Date;
        EndTokenDate: Date;
    begin
        ContentToken.ReadFrom(ResponseText);
        ContentToken.AsObject().Get('Time Series (Daily)', SeriesToken);

        DailyRate.SetRange(Symbols, Symbols);
        if DailyRate.FindLast() then
            EndTokenDate := CalcDate('<1D>', DailyRate."Rate Date")
        else
            EndTokenDate := CalcDate('<-100D>', Today());

        If EndTokenDate >= CalcDate('<-1D>', Today()) then
            exit;

        for StartTokenDate := CalcDate('<-1D>', Today()) Downto EndTokenDate do
            if SeriesToken.AsObject().Get(Format(StartTokenDate, 0, 9), PriceToken) then begin

                DailyRate.Init();
                DailyRate.Symbols := Symbols;
                DailyRate."Rate Date" := StartTokenDate;

                PriceToken.AsObject().Get('1. open', ValueToken);
                DailyRate.Open := ValueToken.AsValue().AsDecimal();

                PriceToken.AsObject().Get('4. close', ValueToken);
                DailyRate.Close := ValueToken.AsValue().AsDecimal();

                PriceToken.AsObject().Get('2. high', ValueToken);
                DailyRate.High := ValueToken.AsValue().AsDecimal();

                PriceToken.AsObject().Get('3. low', ValueToken);
                DailyRate.low := ValueToken.AsValue().AsDecimal();

                DailyRate.Insert();
            end;
    end;

    var
        Text001_Err: Label 'Service inaccessible';
        Text002_Err: Label 'The web service returned an error message:\ Status code: %1\ Description: %2';

}
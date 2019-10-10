page 50110 "AB_Integration Setup"
{

    PageType = Card;
    SourceTable = "AB_Integration Setup";
    Caption = 'Integration Setup';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("API Token"; "API Token")
                {
                    ApplicationArea = All;
                }
                field("API URL"; "API URL")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate Function"; "Daily Rate Function")
                {
                    ApplicationArea = All;
                }
                field("Last Rate function"; "Last Rate function")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}

table 50110 "AB_Integration Setup"
{
    Caption = 'AB_Integration Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Code[10])
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "API URL"; Text[250])
        {
            Caption = 'API URL';
            DataClassification = CustomerContent;
        }
        field(3; "API Token"; Text[100])
        {
            Caption = 'API Token';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
        field(4; "Last Rate function"; Code[50])
        {
            Caption = 'Last Rate function';
            DataClassification = CustomerContent;
        }
        field(5; "Daily Rate Function"; Code[50])
        {
            Caption = 'Daily Rate Function';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}

using CatalogService as service from '../../srv/CatalogService';


annotate service.POs with @(
    UI.SelectionFields: [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,   
        OVERALL_STATUS
            ],
    UI.LineItem: [
        {$Type: 'UI.DataField', Value: PO_ID},
        {$Type: 'UI.DataField', Value: PARTNER_GUID.COMPANY_NAME},
        {$Type: 'UI.DataField', Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY},
        {$Type: 'UI.DataField', Value: GROSS_AMOUNT},
        {$Type: 'UI.DataFieldForAction', Action:'CatalogService.boost', Label: 'Boost', Inline: true},
        {$Type: 'UI.DataField', Value: OVERALL_STATUS_TEXT ,Criticality: OVERALL_STATUS_COLOR}
    ],
    UI.HeaderInfo: {
        TypeName: 'Purchase Orders',
        TypeNamePlural: 'Purchase Orders',
        Title: {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        Description: {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        ImageUrl: 'sap-icon://sales-order',
    },
    UI.Facets: [
                {
                    $Type: 'UI.CollectionFacet',
                    Label: 'More Information',
                    Facets: [
                        {
                          $Type: 'UI.ReferenceFacet',
                            Target: '@UI.Identification',
                        },
                        {
                            $Type: 'UI.ReferenceFacet',
                            Target: '@UI.FieldGroup#guts',
                        },
                        {
                            $Type: 'UI.ReferenceFacet',
                            Target: '@UI.FieldGroup#casca',
                        },
                    ],
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Target: 'Items/@UI.LineItem',
                },
    ],
    UI.Identification :[
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS_TEXT,
        },
    ],
    UI.FieldGroup #guts:{
        Label: 'price details',
        Data: [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },        
        ],
    },
    UI.FieldGroup #casca:{
        Label: 'status',
        Data: [
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,
            },
            {
                $Type: 'UI.DataField',
                Value: OVERALL_STATUS_TEXT,
            },
            {
                $Type: 'UI.DataField',
                Value: OVERALL_STATUS_COLOR,
            },
        ],
    },
);
annotate service.POItems with @(
    UI.LineItem: [
        {$Type: 'UI.DataField', Value: PO_ITEM_POS},
        {$Type: 'UI.DataField', Value: PRODUCT_GUID_NODE_KEY},
        {$Type: 'UI.DataField', Value: GROSS_AMOUNT},
        {$Type: 'UI.DataField', Value: CURRENCY_code},
    ],
);


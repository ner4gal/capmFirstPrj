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
        
    ]
);

namespace nergal.cds;

using { nergal.db.master  , nergal.db.transaction } from '../db/data-model';




context CDSViews {
    define view![POWorklist] as select from transaction.purchaseorder{
        key PO_ID as![PurchaseOrderNo],
        key Items.PO_ITEM_POS as![Position],
        PARTNER_GUID.BP_ID as![VendorID],
        PARTNER_GUID.COMPANY_NAME as![Company],
        Items.NET_AMOUNT as![NetAmount],
        Items.GROSS_AMOUNT as![GrossAmount],    
        Items.TAX_AMOUNT as![TaxAmount],
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            when  'D' then 'Delivered'
        end as![Status],
        Items.PRODUCT_GUID.DESCRIPTION as![ProductDescription],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country]

        };
    define view![ProductVH] as select from master.product{
        @EnduserText.label:[
             {
                language: 'en',
                text: 'Product ID'
             },
            {
                language: 'de',
                text: 'Produkt ID'
            }
        ]
        PRODUCT_ID as![ProductID],
        @EnduserText.label:[
             {
                language: 'en',
                text: 'Product Name'
             },
            {
                language: 'de',
                text: 'Produkt Name'
            }
        ]
        DESCRIPTION as![ProductDescription],
        PRICE as![Price]
        
    };
    define view![ItemView] as select from transaction.poitems{
        PARENT_KEY.PARTNER_GUID.NODE_KEY as ![VendorID],
        PRODUCT_GUID.NODE_KEY as ![ProductID],
        GROSS_AMOUNT as![GrossAmount],
        TAX_AMOUNT as![TaxAmount],
        CURRENCY as![Currency],
        NET_AMOUNT as![NetAmount],
        PARENT_KEY.OVERALL_STATUS as![Status],
    };
    define view ProductOrders as select from master.product
    mixin{
      PO_ORDERS : Association[*] to ItemView on PO_ORDERS.ProductID = $projection.ProductKey
    } into 
    {
        NODE_KEY as![ProductKey],
        DESCRIPTION as![ProductDescription],
        PRICE as![Price],
        SUPPLIER_GUID.BP_ID as![SupplierID],
        SUPPLIER_GUID.COMPANY_NAME as![SupplierName],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
        PO_ORDERS 
    };
    define view![CProductAnalytics] as select from ProductOrders{
         ProductDescription,
         Country,
         round(sum(PO_ORDERS.GrossAmount),2) as![TotalGrossAmount]: Decimal(10,2),
         PO_ORDERS.Currency 
     } group by ProductDescription, Country, PO_ORDERS.Currency
    
    }
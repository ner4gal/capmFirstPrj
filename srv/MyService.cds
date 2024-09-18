using { nergal.cds } from '../db/CDSViews';

service MyService @(path: 'MyService') {


    function nergal(name:String(20)) returns String;
    entity ProductOrderSet as projection on cds.CDSViews.ProductOrders{
        *,
        PO_ORDERS
    };

}
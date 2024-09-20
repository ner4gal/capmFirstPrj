using { nergal.db.master, nergal.db.transaction } from '../db/data-model';

service CatalogService @(path:'CatalogService', requires: 'authenticated-user') {
    
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity EmployeeSet  @(restrict : [ { grant : 'READ' , to: 'Viewer', where: 'bankName = $user.BankName '}, { grant : 'WRITE' , to: 'Admin' }] ) as projection on master.employees;
    entity ProductSet as projection on master.product;
    entity POs @( odata.draft.enabled: true )as projection on transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'In Process'
            when 'C' then 'Completed'
            when 'X' then 'Rejected'
            when 'O' then 'Open'
            when 'D' then 'Delivered'
            when 'A' then 'Approved' end as OVERALL_STATUS_TEXT: String(20),
        case OVERALL_STATUS
            when 'N' then '0'
            when 'P' then '2'
            when 'C' then '3'
            when 'X' then '4'
            when 'O' then '0'
            when 'D' then '5'
            when 'A' then '6' end as OVERALL_STATUS_COLOR: Integer,
        Items
    }
    actions{
        @cds.odata.bindingparameter.name:'_boost'
        @Common.SideEffects: {
            TargetProperties: ['_boost/GROSS_AMOUNT']
        }
         action boost() returns POs;
    };
    function largestOrder() returns POs;

    entity POItems as projection on transaction.poitems;
}

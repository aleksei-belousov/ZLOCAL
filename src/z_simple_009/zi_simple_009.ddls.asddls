@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_009'
define root view entity ZI_SIMPLE_009 as select from zsimple_009 as Simple
composition [0..*] of ZI_ITEM_009 as _Item
{
    key header_uuid as HeaderUUID,
    header_id as HeaderID,
    data1 as Data1,
    data2 as Data2,
    data3 as Data3,
    customer as Customer,
    _Item // Make association public
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_006'
define root view entity ZI_SIMPLE_006X as select from zsimple_006 as Simple
composition [0..*] of ZI_ITEM_006X as _Item
{
    key uuid as Uuid,
    id as Id,
    data1 as Data1,
    data2 as Data2,
    data3 as Data3,
    /* associations */
    _Item
}

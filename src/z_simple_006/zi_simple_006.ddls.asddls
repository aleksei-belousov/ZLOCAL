@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_006'
define root view entity ZI_SIMPLE_006 as select from zsimple_006
association [0..*] to ZC_ITEM_006 as _Item  on  $projection.Uuid  = _Item.Simpleuuid
{
    key uuid as Uuid,
    id as Id,
    data1 as Data1,
    data2 as Data2,
    data3 as Data3,
    /* associations */
    _Item
}

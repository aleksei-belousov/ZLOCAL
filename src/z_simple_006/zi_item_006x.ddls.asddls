@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ITEM_006'
define view entity ZI_ITEM_006X as select from zitem_006 as Item
association to parent ZI_SIMPLE_006X as _Simple on $projection.Simpleuuid = _Simple.Uuid
{
    key uuid as Uuid,
    id as Id,
    simpleuuid as Simpleuuid,
    simpleid as Simpleid,
    data4 as Data4,
    data5 as Data5,
    /* associations */
    _Simple
}

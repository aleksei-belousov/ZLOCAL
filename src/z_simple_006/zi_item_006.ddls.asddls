@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ITEM_006'
define root view entity ZI_ITEM_006 as select from zitem_006
{
    key uuid as Uuid,
    id as Id,
    simpleuuid as Simpleuuid,
    simpleid as Simpleid,
    data4 as Data4,
    data5 as Data5
}

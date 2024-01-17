@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ITEM_009'
define view entity ZI_ITEM_009 as select from zitem_009 as Item 
association to parent ZI_SIMPLE_009 as _Simple on $projection.HeaderUUID = _Simple.HeaderUUID
{
    key item_uuid as ItemUUID,
    item_id as ItemID,
    header_uuid as HeaderUUID,
    data4 as Data4,
    data5 as Data5,
    data6 as Data6,
    /* associations */
    _Simple // Make association public
}

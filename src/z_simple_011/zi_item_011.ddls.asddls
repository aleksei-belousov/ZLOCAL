@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ITEM_011'
define view entity ZI_ITEM_011 as select from zitem_011 as Item
association to parent ZI_SIMPLE_011 as _Simple on $projection.SimpleUUID = _Simple.SimpleUUID
{
    key itemuuid as ItemUUID,
    itemid as ItemID,
    simpleuuid as SimpleUUID,
    data4 as Data4,
    data5 as Data5,
    data6 as Data6,
    createdby as CreatedBy, 
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt,
    /* associations */
    _Simple
}

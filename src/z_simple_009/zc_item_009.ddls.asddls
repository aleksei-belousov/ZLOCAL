@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_ITEM_009'
@Metadata.allowExtensions: true
define view entity ZC_ITEM_009 as projection on ZI_ITEM_009 as Item
{
    key ItemUUID,
    ItemID,
    HeaderUUID,
    Data4,
    Data5,
    Data6,
    /* Associations */
    _Simple : redirected to parent ZC_SIMPLE_009
}

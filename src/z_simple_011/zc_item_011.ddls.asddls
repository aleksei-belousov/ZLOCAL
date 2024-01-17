@EndUserText.label: 'ZC_ITEM_011'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define view entity ZC_ITEM_011 as projection on ZI_ITEM_011 as Item
{
    key ItemUUID,
    ItemID,
    SimpleUUID,
    Data4,
    Data5,
    Data6,
    CreatedBy, 
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
     _Simple : redirected to parent ZC_SIMPLE_011
}

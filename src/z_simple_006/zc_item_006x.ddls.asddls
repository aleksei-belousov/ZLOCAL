@EndUserText.label: 'ZC_ITEM_006X'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_ITEM_006X as projection on ZI_ITEM_006X
{
    key Uuid,
    @Search.defaultSearchElement: true
    Id,
    Simpleuuid,
    Simpleid,
    Data4,
    Data5,
    /* Associations */
    _Simple : redirected to parent ZC_SIMPLE_006X
}

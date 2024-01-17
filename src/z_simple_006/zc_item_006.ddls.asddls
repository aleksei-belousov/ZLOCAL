@EndUserText.label: 'ZC_ITEM_006'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_ITEM_006 provider contract transactional_query as projection on ZI_ITEM_006
{
    key Uuid,
    Id,
    Simpleuuid,
    Simpleid,
    Data4,
    Data5
}

@EndUserText.label: 'ZC_SIMPLE_011'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_SIMPLE_011 provider contract transactional_query as projection on ZI_SIMPLE_011
{
    key SimpleUUID,
    @Search.defaultSearchElement: true
    SimpleID,
    Data1,
    Data2,
    Data3,
    CreatedBy, 
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    _Item : redirected to composition child ZC_ITEM_011
}

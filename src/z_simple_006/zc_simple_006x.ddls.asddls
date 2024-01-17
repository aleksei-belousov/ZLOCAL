@EndUserText.label: 'ZC_SIMPLE_006X'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_006X provider contract transactional_query as projection on ZI_SIMPLE_006X as Simple
{
    key Uuid,
    @Search.defaultSearchElement: true
    Id,
    Data1,
    Data2,
    Data3,
    /* Associations */
    _Item : redirected to composition child ZC_ITEM_006X
}

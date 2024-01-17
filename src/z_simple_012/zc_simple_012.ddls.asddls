@EndUserText.label: 'ZC_SIMPLE_012'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_012 provider contract transactional_query as projection on ZI_SIMPLE_012
{
    key Uuid,
    Id,
    Data1,
    URL
}

@EndUserText.label: 'ZC_SIMPLE_006'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_006 provider contract transactional_query as projection on ZI_SIMPLE_006
{
    key Uuid,
    Id,
    Data1,
    Data2,
    Data3
}

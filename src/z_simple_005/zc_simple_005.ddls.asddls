@EndUserText.label: 'ZC_SIMPLE_005 - projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_005 provider contract transactional_query as projection on ZI_SIMPLE_005
{
    key Uuid,
    Id,
    Data1,
    Data2,
    Data3
}

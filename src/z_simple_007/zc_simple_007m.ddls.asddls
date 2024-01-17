@EndUserText.label: 'ZC_SIMPLE_007M'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_007M as projection on ZI_SIMPLE_007M
{
    key Id,
    Data0,
    Data1,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}

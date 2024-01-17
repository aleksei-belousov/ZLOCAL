@EndUserText.label: 'ZC_SIMPLE_007'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_007 as projection on ZI_SIMPLE_007 as Simple
{
    key Id,
    Data0,
    Data1
}

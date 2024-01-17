@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_012'
define root view entity ZI_SIMPLE_012 as select from zsimple_012
{
    key uuid as Uuid,
    id as Id,
    data1 as Data1,
    url as URL
}

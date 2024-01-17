@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_007'
define root view entity ZI_SIMPLE_007 as select from zsimple_007 as Simple
{
    key id as Id,
    data0 as Data0,
    data1 as Data1
}

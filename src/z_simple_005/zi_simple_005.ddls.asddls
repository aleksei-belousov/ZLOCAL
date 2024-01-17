@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_005 - selection'
define root view entity ZI_SIMPLE_005 as select from zsimple_005
{
    key uuid as Uuid,
    id as Id,
    data1 as Data1,
    data2 as Data2,
    data3 as Data3
}

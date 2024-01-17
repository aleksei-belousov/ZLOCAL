@EndUserText.label: 'simple projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_004
  as projection on ZI_SIMPLE_004
{
  key Uuid,
      Id,
      Data
//      _Qaf.data2 as Data2
}

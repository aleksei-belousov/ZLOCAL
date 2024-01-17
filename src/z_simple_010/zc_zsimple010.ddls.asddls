@EndUserText.label: 'ZSIMPLE 010 - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_Zsimple010
  as projection on ZI_Zsimple010
{
  key Simpleuuid,
  Simpleid,
  Data1,
  Data2,
  Data3,
  Customer,
  Lastchange,
  @Consumption.hidden: true
  LocinstLastchange,
  @Consumption.hidden: true
  SingletonID,
  _Zsimple010All : redirected to parent ZC_Zsimple010_S
  
}

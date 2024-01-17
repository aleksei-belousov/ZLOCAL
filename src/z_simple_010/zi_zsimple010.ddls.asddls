@EndUserText.label: 'ZSIMPLE 010'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_Zsimple010
  as select from ZSIMPLE_010
  association to parent ZI_Zsimple010_S as _Zsimple010All on $projection.SingletonID = _Zsimple010All.SingletonID
{
  key SIMPLEUUID as Simpleuuid,
  SIMPLEID as Simpleid,
  DATA1 as Data1,
  DATA2 as Data2,
  DATA3 as Data3,
  CUSTOMER as Customer,
  @Semantics.systemDateTime.lastChangedAt: true
  LASTCHANGE as Lastchange,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCINST_LASTCHANGE as LocinstLastchange,
  1 as SingletonID,
  _Zsimple010All
  
}

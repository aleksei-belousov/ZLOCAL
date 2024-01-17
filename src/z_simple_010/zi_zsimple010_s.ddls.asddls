@EndUserText.label: 'ZSIMPLE 010 Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_Zsimple010_S
  as select from I_Language
    left outer join ZSIMPLE_010 on 0 = 0
  composition [0..*] of ZI_Zsimple010 as _Zsimple010
{
  key 1 as SingletonID,
  _Zsimple010,
  max( ZSIMPLE_010.LASTCHANGE ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language

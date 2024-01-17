@EndUserText.label: 'ZSIMPLE 010 Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_Zsimple010_S
  provider contract transactional_query
  as projection on ZI_Zsimple010_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _Zsimple010 : redirected to composition child ZC_Zsimple010
  
}

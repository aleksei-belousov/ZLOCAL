define abstract entity ZXCO_DEMO_PRODUCTY
  with parameters
    p_language : abap.lang( 1 )
{
  @UI.lineItem: [ {
    position: 1 , 
    label: 'ProductY'
  } ]
  key ID : abap.char( 30 );
  @UI.lineItem: [ {
    position: 2 , 
    label: 'Description'
  } ]
  description : abap.char( 60 );
  
}

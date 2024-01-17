@EndUserText.label: 'Data model for zsimple'
@AccessControl.authorizationCheck: #CHECK
//define root view entity ZI_SIMPLE_004
//  as select from zsimple_004
//  association [1..1] to zsimple_qaf_004 as _Qaf on 
//  $projection.Uuid = _Qaf.uuid
define root view entity ZI_SIMPLE_004 as select from zsimple_004
{

  key uuid          as Uuid,
      id            as Id,
      data          as Data
//      _Qaf.data2    as Data2,

      /*Associations*/
//      _Qaf
}

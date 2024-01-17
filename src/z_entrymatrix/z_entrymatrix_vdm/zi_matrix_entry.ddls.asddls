@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data model for matrix entry'
define root view entity ZI_MATRIX_ENTRY
  as select from zmatrixentry as Entry
  composition [0..*] of ZI_MATRIX_SIZE  as _Size 
  composition [0..*] of ZI_MATRIX_TABLE as _Table
{
  key order_uuid   as Order_Uuid,
      order_id     as Order_Id,
      modelno      as Modelno,
      colorno      as Colorno,


      /*Associations*/
      _Size,
      _Table
}

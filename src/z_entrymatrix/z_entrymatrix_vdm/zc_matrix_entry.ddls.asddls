@EndUserText.label: 'Projection view for matrix entry'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_MATRIX_ENTRY provider contract transactional_query
    as projection on ZI_MATRIX_ENTRY as Entry
{
    key Order_Uuid,
      @Search.defaultSearchElement: true
      Order_Id,
      Modelno,
      Colorno,
      
      /* Associations */
      _Table : redirected to composition child ZC_MATRIX_TABLE,
      _Size : redirected to composition child ZC_MATRIX_SIZE
}
      

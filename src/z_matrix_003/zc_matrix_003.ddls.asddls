@EndUserText.label: 'ZC_MATRIX_003'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_MATRIX_003 provider contract transactional_query as projection on ZI_MATRIX_003 as Matrix
{
//    key MatrixUUID,
    @Search.defaultSearchElement: true
    key MatrixID,
    Model,
    Color,
    /* Associations */
    _Size: redirected to composition child ZC_SIZE_003,
    _Item: redirected to composition child ZC_ITEM_003
}

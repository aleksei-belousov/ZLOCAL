@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_MATRIX_003'
define root view entity ZI_MATRIX_003 as select from zmatrix_003 as Matrix
composition [0..*] of ZI_SIZE_003 as _Size
composition [0..*] of ZI_ITEM_003 as _Item
{
    key matrixid as MatrixID,
    model as Model,
    color as Color,
    /* associations */
    _Size,
    _Item
}



@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data model for matrix table'
define view entity ZI_MATRIX_TABLE as select from zmatrix_as as Table
association to parent ZI_MATRIX_ENTRY as _Entry on $projection.OrderUuid = _Entry.Order_Uuid
{
    key matrix_uuid as MatrixUuid,
    matrix_id  as Matrix_Id,
    order_uuid as OrderUuid,
    order_id   as Order_Id,
    modelno    as ModelNo,
    colorno    as ColorNo,
    cupsize    as Cupsize,
    backsize   as Backsize,
    product    as Product,
    quantity   as Quantity,
    /* associations */
    _Entry
}

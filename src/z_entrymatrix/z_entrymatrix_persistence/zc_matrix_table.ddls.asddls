@EndUserText.label: 'Projection view for matrix table'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_MATRIX_TABLE as projection on ZI_MATRIX_TABLE
{
    key MatrixUuid,
    OrderUuid,
    Matrix_Id,
    Order_Id,
    ModelNo,
    ColorNo,
    Cupsize,
    Backsize,
    Product,
    Quantity,
    /* Associations */
    _Entry : redirected to parent ZC_MATRIX_ENTRY
}

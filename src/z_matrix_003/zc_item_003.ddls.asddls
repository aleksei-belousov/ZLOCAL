@EndUserText.label: 'ZC_ITEM_003'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_ITEM_003 as projection on ZI_ITEM_003 as Item
{
    key ItemID,
//    MatrixUUID,
    MatrixID,
    Model,
    Color,
    Cupsize,
    Backsize,
    Product,
    Quantity,
    /* Associations */
    _Matrix : redirected to parent ZC_MATRIX_003
}

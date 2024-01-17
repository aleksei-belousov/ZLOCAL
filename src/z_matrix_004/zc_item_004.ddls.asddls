@EndUserText.label: 'ZC_ITEM_004'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_ITEM_004 as projection on ZI_ITEM_004 as Item
{
    key MatrixUUID,
    key ItemID,
    Model,
    Color,
    Cupsize,
    Backsize,
    Product,
    Quantity,
    /* Associations */
    _Matrix : redirected to parent ZC_MATRIX_004
}

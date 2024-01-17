@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ITEM_004'
define view entity ZI_ITEM_004 as select from zitem_004 as Item
association to parent ZI_MATRIX_004 as _Matrix on $projection.MatrixUUID = _Matrix.MatrixUUID
{
    key matrixuuid  as MatrixUUID,
    key itemid  as ItemID,
    model       as Model,
    color       as Color,
    cupsize     as Cupsize,
    backsize    as Backsize,
    product     as Product,
    quantity    as Quantity,
    /* associations */
    _Matrix // Make association public
}

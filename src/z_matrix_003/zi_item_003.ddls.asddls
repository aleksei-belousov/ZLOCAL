@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ITEM_003'
define view entity ZI_ITEM_003 as select from zitem_003 as Item
association to parent ZI_MATRIX_003 as _Matrix on $projection.MatrixID = _Matrix.MatrixID
{
//    key itemuuid    as ItemUUID,
    key itemid      as ItemID,
//    matrixuuid      as MatrixUUID,
    matrixid        as MatrixID,
    model           as Model,
    color           as Color,
    cupsize         as Cupsize,
    backsize        as Backsize,
    product         as Product,
    quantity        as Quantity,
    /* associations */
    _Matrix // Make association public
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_MATRIX_SIZE'
define view entity ZI_MATRIX_SIZE as select from zmatrix_size as Size
association to parent ZI_MATRIX_ENTRY as _Entry on $projection.OrderUuid = _Entry.Order_Uuid
{
    key sizeuuid as Sizeuuid,
    order_uuid as OrderUuid,
    back as Back,
    a as A,
    b as B,
    c as C,
    d as D,
    e as E,
    f as F,
    g as G,
    h as H,
    i as I,
    /* associations */
    _Entry // Make association public
}

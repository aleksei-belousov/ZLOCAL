@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIZE_003'
define view entity ZI_SIZE_003 as select from zsize_003 as Size
association to parent ZI_MATRIX_003 as _Matrix on $projection.MatrixID = _Matrix.MatrixID
{
    key sizeid      as SizeID,
    matrixid        as MatrixID,
    back            as Back,
    a               as A,
    b               as B,
    c               as C,
    d               as D,
    e               as E,
    f               as F,
    g               as G,
    h               as H,
    i               as I,
    /* associations */
    _Matrix // Make association public
}

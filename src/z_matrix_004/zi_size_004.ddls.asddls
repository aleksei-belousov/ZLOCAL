@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIZE_004'
define view entity ZI_SIZE_004 as select from zsize_004 as Size
association to parent ZI_MATRIX_004 as _Matrix on $projection.MatrixUUID = _Matrix.MatrixUUID
{
    key matrixuuid  as MatrixUUID,
    key sizeid      as SizeID,
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

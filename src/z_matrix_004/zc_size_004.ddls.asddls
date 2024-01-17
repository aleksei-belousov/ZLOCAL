@EndUserText.label: 'ZC_SIZE_004'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_SIZE_004 as projection on ZI_SIZE_004 as Size
{
    key MatrixUUID,
    key SizeID,
    Back,
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    /* Associations */
    _Matrix : redirected to parent ZC_MATRIX_004
}

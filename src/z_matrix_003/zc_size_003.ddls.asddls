@EndUserText.label: 'ZC_SIZE_003'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_SIZE_003 as projection on ZI_SIZE_003 as Size 
{
    key SizeID,
    MatrixID,
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
    _Matrix : redirected to parent ZC_MATRIX_003
}

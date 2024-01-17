@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_MATRIX_SIZE'
@Metadata.allowExtensions: true
define view entity ZC_MATRIX_SIZE as projection on ZI_MATRIX_SIZE as Size
{
    key Sizeuuid,
    OrderUuid,
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
    _Entry : redirected to parent ZC_MATRIX_ENTRY
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMATRIX2_DATA'

@Metadata.allowExtensions: true
define root view entity ZMATRIX2_DATA as select from zmatrix2
{
    key zmatrix2.back as Back,
    zmatrix2.a as A,
    zmatrix2.b as B,
    zmatrix2.c as C,
    zmatrix2.d as D,
    zmatrix2.e as E,
    zmatrix2.f as F,
    zmatrix2.h as H,
    zmatrix2.i as I    
}

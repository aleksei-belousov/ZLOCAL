@AbapCatalog.sqlViewName: 'ZFINALVIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data definiton for ZFINAL'
@Metadata.allowExtensions: true
define root view zdef_final as select from zfinal {
    key currency as Currency,
    key currency2 as Currency2,
    quantity as Quantity,
    rate as Rate,
    value as Value
}

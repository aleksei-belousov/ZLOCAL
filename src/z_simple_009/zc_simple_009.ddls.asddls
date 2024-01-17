@EndUserText.label: 'ZC_SIMPLE_009'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_009 provider contract transactional_query as projection on ZI_SIMPLE_009 as Simple
{
    key HeaderUUID,

    HeaderID,

    Data1,
    
    Data2,
    
    Data3,
    
   @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer', element: 'Customer' } } ]
    Customer,

    /* Associations */
    _Item : redirected to composition child ZC_ITEM_009
}

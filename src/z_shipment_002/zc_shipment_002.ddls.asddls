@EndUserText.label: 'ZC_SHIPMENT_002'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SHIPMENT_002 provider contract transactional_query as projection on ZI_SHIPMENT_002
{
    key ShipmentUUID,

    ShipmentID,

    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer', element: 'Customer' } } ]
    @EndUserText.label: 'Sold To Party'
    @ObjectModel.text.element: ['CustomerName']
    SoldToParty,
    _Customer.CustomerName as CustomerName,
    
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    
    /* Associations */
    _Available: redirected to composition child ZC_AVAILABLE_002,
    _Added: redirected to composition child ZC_ADDED_002,
    _Customer

}

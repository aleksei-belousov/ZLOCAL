@EndUserText.label: 'ZC_AVAILABLE_002'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_AVAILABLE_002 as projection on ZI_AVAILABLE_002 as Available
{
    key AvailableUUID,
    AvailableID,
    ShipmentUUID,
    OutboundDelivery,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Shipment : redirected to parent ZC_SHIPMENT_002
}

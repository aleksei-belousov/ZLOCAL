@EndUserText.label: 'ZC_ADDED_002'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_ADDED_002 as projection on ZI_ADDED_002 as Added
{
    key AddedUUID,
    AddedID,
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

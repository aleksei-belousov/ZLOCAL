@EndUserText.label: 'ZC_SHIPMENT_002X'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_SHIPMENT_002X as projection on ZI_SHIPMENT_002X
{
    key ShipmentID,
    ShipmentUUID,
    SoldToParty,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_AVAILABLE_002'
define view entity ZI_AVAILABLE_002 as select from zavailable002
association to parent ZI_SHIPMENT_002 as _Shipment on $projection.ShipmentUUID = _Shipment.ShipmentUUID
{
    key availableuuid as AvailableUUID,
    availableid as AvailableID,
    shipmentuuid as ShipmentUUID,
    outbounddelivery as OutboundDelivery,
    createdby as CreatedBy,
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt,
    _Shipment // Make association public
}

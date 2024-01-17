@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_ADDED_002'
define view entity ZI_ADDED_002 as select from zadded002
association to parent ZI_SHIPMENT_002 as _Shipment on $projection.ShipmentUUID = _Shipment.ShipmentUUID
{
    key addeduuid as AddedUUID,
    addedid as AddedID,
    shipmentuuid as ShipmentUUID,
    outbounddelivery as OutboundDelivery,
    createdby as CreatedBy,
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt,
    _Shipment // Make association public
}

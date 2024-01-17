@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment'
define root view entity ZI_SHIPMENT_002X as select from zshipment002
//composition [0..*] of ZI_AVAILABLE_002 as _Available
//association [0..1] to I_Customer  as _Customer on $projection.SoldToParty = _Customer.Customer
{
    key shipmentid as ShipmentID,
    shipmentuuid as ShipmentUUID,

    soldtoparty as SoldToParty,

    createdby as CreatedBy,
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt
    
//    _Available, // Make association public
//    _Customer // Make association public
}

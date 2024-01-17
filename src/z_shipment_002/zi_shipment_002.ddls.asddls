@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SHIPMENT_002'
define root view entity ZI_SHIPMENT_002 as select from zshipment002
composition [0..*] of ZI_AVAILABLE_002 as _Available
composition [0..*] of ZI_ADDED_002 as _Added
association [0..1] to I_Customer  as _Customer on $projection.SoldToParty = _Customer.Customer
{
    key shipmentuuid as ShipmentUUID,

    shipmentid as ShipmentID,
    soldtoparty as SoldToParty,

    createdby as CreatedBy,
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt,
    
    _Available, // Make association public
    _Added, // Make association public
    _Customer // Make association public
}

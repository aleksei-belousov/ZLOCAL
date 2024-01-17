@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_ONLINESHOPTP_000'
define root view entity ZC_ONLINESHOPTP_000
  provider contract transactional_query
  as projection on ZR_ONLINESHOPTP_000
{
  key OrderUUID,
  OrderID,
  OrderedItem,
  Price,
  TotalPrice,
  Currency,
  OrderQuantity,
  DeliveryDate,
  OverallStatus,
  Notes,
  LocalLastChangedAt,
  PurchaseRequisition,
  PrCreationDate
  
}

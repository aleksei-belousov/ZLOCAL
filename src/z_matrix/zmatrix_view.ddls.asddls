@EndUserText.label: 'shop projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity ZMATRIX_VIEW
  as projection on ZMATRIX_FINAL
{
  key Order_Uuid,
      Order_Id,
      Ordereditem,
      Modelnr,
      Colornr,
      Deliverydate,
      Creationdate,
      PackageId,
      _Shop.salesord as SalesOrder
}

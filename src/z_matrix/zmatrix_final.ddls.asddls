@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data definiton for Matrix'

define root view entity ZMATRIX_FINAL
  as select from zmatrix
  association [1..1] to zshop as _Shop on 
  $projection.Order_Uuid = _Shop.order_uuid
{

  key order_uuid   as Order_Uuid,
      order_id     as Order_Id,
      ordereditem  as Ordereditem,
      deliverydate as Deliverydate,
      creationdate as Creationdate,
      pkgid        as PackageId,
      modelnr as Modelnr,
      colornr as Colornr,
 //     _Shop.costcenter as CostCenter,

      /*Associations*/
      _Shop
}

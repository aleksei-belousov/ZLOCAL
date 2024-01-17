@Metadata.allowExtensions: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection view for online shop'
define root view entity ZC_ONLINE_SHOP_002 
as projection on ZI_ONLINE_SHOP_002
{
    key Order_Uuid,
    Order_Id,
    Ordereditem,
    Deliverydate,
    Creationdate,
    PackageId,
    CostCenter,
    _Shop.purchasereqn as Purchasereqn
}

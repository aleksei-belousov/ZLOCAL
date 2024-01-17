@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VDM for Items'
define root view entity zi_online_shop_prepitem_003 as select from zshop_item_003
{
  key order_uuid,
  key item_uuid,
  plant,
  purchaserequisitionitemtext,
  accountassignmentcategory,
  requestedquantity,
  baseunit,
  purchaserequisitionprice,
  purreqnitemcurrency,
  materialgroup,
  purchasinggroup,
  purchasingorganization,
  pkgid as PkgId

}

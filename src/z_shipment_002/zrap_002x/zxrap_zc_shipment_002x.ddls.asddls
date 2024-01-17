/********** GENERATED on 11/27/2023 at 09:57:47 by CB9980000021**************/
 @OData.entitySet.name: 'ZC_SHIPMENT_002X' 
 @OData.entityType.name: 'ZC_SHIPMENT_002XType' 
 define root abstract entity ZXRAP_ZC_SHIPMENT_002X { 
 key ShipmentID : abap.numc( 10 ) ; 
 @Odata.property.valueControl: 'ShipmentUUID_vc' 
 ShipmentUUID : sysuuid_x16 ; 
 ShipmentUUID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SoldToParty_vc' 
 SoldToParty : abap.char( 10 ) ; 
 SoldToParty_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CreatedBy_vc' 
 CreatedBy : abap.char( 12 ) ; 
 CreatedBy_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CreatedAt_vc' 
 CreatedAt : tzntstmpl ; 
 CreatedAt_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'LastChangedBy_vc' 
 LastChangedBy : abap.char( 12 ) ; 
 LastChangedBy_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'LastChangedAt_vc' 
 LastChangedAt : tzntstmpl ; 
 LastChangedAt_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'LocalLastChangedAt_vc' 
 LocalLastChangedAt : tzntstmpl ; 
 LocalLastChangedAt_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 

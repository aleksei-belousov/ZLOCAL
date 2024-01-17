/********** GENERATED on 09/10/2023 at 17:42:36 by CB9980000021**************/
 @OData.entitySet.name: 'ZC_ITEM_005' 
 @OData.entityType.name: 'ZC_ITEM_005Type' 

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
 define root abstract entity ZRAP_003ZC_ITEM_005 { 
 key MatrixUUID : sysuuid_x16 ; 
 key ItemID : abap.numc( 10 ) ; 
 key IsActiveEntity : abap_boolean ; 
 @OData.property.valueControl: 'ItemID2_vc' 
 ItemID2 : abap.numc( 10 ) ; 
 ItemID2_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Model_vc' 
 Model : abap.char( 10 ) ; 
 Model_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Color_vc' 
 Color : abap.char( 10 ) ; 
 Color_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Cupsize_vc' 
 Cupsize : abap.char( 10 ) ; 
 Cupsize_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Backsize_vc' 
 Backsize : abap.char( 10 ) ; 
 Backsize_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Product_vc' 
 Product : abap.char( 40 ) ; 
 Product_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Quantity_vc' 
 Quantity : abap.char( 10 ) ; 
 Quantity_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Createdby_vc' 
 Createdby : abap.char( 12 ) ; 
 Createdby_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'Createdat_vc' 
 Createdat : tzntstmpl ; 
 Createdat_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LastChangedBy_vc' 
 LastChangedBy : abap.char( 12 ) ; 
 LastChangedBy_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LastChangedAt_vc' 
 LastChangedAt : tzntstmpl ; 
 LastChangedAt_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LocalLastChangedAt_vc' 
 LocalLastChangedAt : tzntstmpl ; 
 LocalLastChangedAt_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'HasDraftEntity_vc' 
 HasDraftEntity : abap_boolean ; 
 HasDraftEntity_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'DraftEntityCreationDateTime_vc' 
 DraftEntityCreationDateTime : tzntstmpl ; 
 DraftEntityCreationDateTime_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'DraftEntityLastChangeDateTi_vc' 
 DraftEntityLastChangeDateTime : tzntstmpl ; 
 DraftEntityLastChangeDateTi_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'HasActiveEntity_vc' 
 HasActiveEntity : abap_boolean ; 
 HasActiveEntity_vc : rap_cp_odata_value_control ; 
 ETAG__ETAG : abap.string( 0 ) ; 
 
 @OData.property.name: 'DraftAdministrativeData' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _DraftAdministrativeData : association [1] to ZRAP_003I_DRAFTADMINISTRATIVED on 1 = 1; 
 @OData.property.name: 'to_Matrix' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _Matrix : association [1] to ZRAP_003ZC_MATRIX_005 on 1 = 1; 
 } 

/********** GENERATED on 10/03/2023 at 12:46:24 by CB9980000021**************/
 @OData.entitySet.name: 'I_PurchaseOrderItemAPI01' 
 @OData.entityType.name: 'I_PurchaseOrderItemAPI01Type' 
 define root abstract entity ZRAPI_PURCHASEORDERITEMAPI01 { 
 key PurchaseOrder : abap.char( 10 ) ; 
 key PurchaseOrderItem : abap.numc( 5 ) ; 
 @Odata.property.valueControl: 'PurchaseOrderItemUniqueID_vc' 
 PurchaseOrderItemUniqueID : abap.char( 15 ) ; 
 PurchaseOrderItemUniqueID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseOrderCategory_vc' 
 PurchaseOrderCategory : abap.char( 1 ) ; 
 PurchaseOrderCategory_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DocumentCurrency_vc' 
 @Semantics.currencyCode: true 
 DocumentCurrency : abap.cuky ; 
 DocumentCurrency_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingDocumentDeletionC_vc' 
 PurchasingDocumentDeletionCode : abap.char( 1 ) ; 
 PurchasingDocumentDeletionC_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingDocumentItemOrigi_vc' 
 PurchasingDocumentItemOrigin : abap.char( 1 ) ; 
 PurchasingDocumentItemOrigi_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MaterialGroup_vc' 
 MaterialGroup : abap.char( 9 ) ; 
 MaterialGroup_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Material_vc' 
 Material : abap.char( 18 ) ; 
 Material_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MaterialType_vc' 
 MaterialType : abap.char( 4 ) ; 
 MaterialType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierMaterialNumber_vc' 
 SupplierMaterialNumber : abap.char( 35 ) ; 
 SupplierMaterialNumber_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierSubrange_vc' 
 SupplierSubrange : abap.char( 6 ) ; 
 SupplierSubrange_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ManufacturerPartNmbr_vc' 
 ManufacturerPartNmbr : abap.char( 40 ) ; 
 ManufacturerPartNmbr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Manufacturer_vc' 
 Manufacturer : abap.char( 10 ) ; 
 Manufacturer_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ManufacturerMaterial_vc' 
 ManufacturerMaterial : abap.char( 18 ) ; 
 ManufacturerMaterial_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseOrderItemText_vc' 
 PurchaseOrderItemText : abap.char( 40 ) ; 
 PurchaseOrderItemText_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ProductType_vc' 
 ProductType : abap.char( 2 ) ; 
 ProductType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CompanyCode_vc' 
 CompanyCode : abap.char( 4 ) ; 
 CompanyCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Plant_vc' 
 Plant : abap.char( 4 ) ; 
 Plant_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ManualDeliveryAddressID_vc' 
 ManualDeliveryAddressID : abap.char( 10 ) ; 
 ManualDeliveryAddressID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ReferenceDeliveryAddressID_vc' 
 ReferenceDeliveryAddressID : abap.char( 10 ) ; 
 ReferenceDeliveryAddressID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Customer_vc' 
 Customer : abap.char( 10 ) ; 
 Customer_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subcontractor_vc' 
 Subcontractor : abap.char( 10 ) ; 
 Subcontractor_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierIsSubcontractor_vc' 
 SupplierIsSubcontractor : abap_boolean ; 
 SupplierIsSubcontractor_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CrossPlantConfigurableProdu_vc' 
 CrossPlantConfigurableProduct : abap.char( 18 ) ; 
 CrossPlantConfigurableProdu_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ArticleCategory_vc' 
 ArticleCategory : abap.char( 2 ) ; 
 ArticleCategory_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PlndOrderReplnmtElmntType_vc' 
 PlndOrderReplnmtElmntType : abap.char( 1 ) ; 
 PlndOrderReplnmtElmntType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ProductPurchasePointsQtyUni_vc' 
 @Semantics.unitOfMeasure: true 
 ProductPurchasePointsQtyUnit : abap.unit( 3 ) ; 
 ProductPurchasePointsQtyUni_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ProductPurchasePointsQty_vc' 
 @Semantics.quantity.unitOfMeasure: 'ProductPurchasePointsQtyUnit' 
 ProductPurchasePointsQty : abap.dec( 13, 3 ) ; 
 ProductPurchasePointsQty_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'StorageLocation_vc' 
 StorageLocation : abap.char( 4 ) ; 
 StorageLocation_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseOrderQuantityUnit_vc' 
 @Semantics.unitOfMeasure: true 
 PurchaseOrderQuantityUnit : abap.unit( 3 ) ; 
 PurchaseOrderQuantityUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OrderItemQtyToBaseQtyNmrtr_vc' 
 OrderItemQtyToBaseQtyNmrtr : abap.dec( 5, 0 ) ; 
 OrderItemQtyToBaseQtyNmrtr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OrderItemQtyToBaseQtyDnmntr_vc' 
 OrderItemQtyToBaseQtyDnmntr : abap.dec( 5, 0 ) ; 
 OrderItemQtyToBaseQtyDnmntr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'NetPriceQuantity_vc' 
 @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit' 
 NetPriceQuantity : abap.dec( 5, 0 ) ; 
 NetPriceQuantity_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IsCompletelyDelivered_vc' 
 IsCompletelyDelivered : abap_boolean ; 
 IsCompletelyDelivered_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IsFinallyInvoiced_vc' 
 IsFinallyInvoiced : abap_boolean ; 
 IsFinallyInvoiced_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'GoodsReceiptIsExpected_vc' 
 GoodsReceiptIsExpected : abap_boolean ; 
 GoodsReceiptIsExpected_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'InvoiceIsExpected_vc' 
 InvoiceIsExpected : abap_boolean ; 
 InvoiceIsExpected_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'InvoiceIsGoodsReceiptBased_vc' 
 InvoiceIsGoodsReceiptBased : abap_boolean ; 
 InvoiceIsGoodsReceiptBased_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseContractItem_vc' 
 PurchaseContractItem : abap.numc( 5 ) ; 
 PurchaseContractItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseContract_vc' 
 PurchaseContract : abap.char( 10 ) ; 
 PurchaseContract_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseRequisition_vc' 
 PurchaseRequisition : abap.char( 10 ) ; 
 PurchaseRequisition_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'RequirementTracking_vc' 
 RequirementTracking : abap.char( 10 ) ; 
 RequirementTracking_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseRequisitionItem_vc' 
 PurchaseRequisitionItem : abap.numc( 5 ) ; 
 PurchaseRequisitionItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'EvaldRcptSettlmtIsAllowed_vc' 
 EvaldRcptSettlmtIsAllowed : abap_boolean ; 
 EvaldRcptSettlmtIsAllowed_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'UnlimitedOverdeliveryIsAllo_vc' 
 UnlimitedOverdeliveryIsAllowed : abap_boolean ; 
 UnlimitedOverdeliveryIsAllo_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OverdelivTolrtdLmtRatioInPc_vc' 
 OverdelivTolrtdLmtRatioInPct : abap.dec( 3, 1 ) ; 
 OverdelivTolrtdLmtRatioInPc_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'UnderdelivTolrtdLmtRatioInP_vc' 
 UnderdelivTolrtdLmtRatioInPct : abap.dec( 3, 1 ) ; 
 UnderdelivTolrtdLmtRatioInP_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'RequisitionerName_vc' 
 RequisitionerName : abap.char( 12 ) ; 
 RequisitionerName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PlannedDeliveryDurationInDa_vc' 
 PlannedDeliveryDurationInDays : abap.dec( 3, 0 ) ; 
 PlannedDeliveryDurationInDa_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'GoodsReceiptDurationInDays_vc' 
 GoodsReceiptDurationInDays : abap.dec( 3, 0 ) ; 
 GoodsReceiptDurationInDays_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PartialDeliveryIsAllowed_vc' 
 PartialDeliveryIsAllowed : abap.char( 1 ) ; 
 PartialDeliveryIsAllowed_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ConsumptionPosting_vc' 
 ConsumptionPosting : abap.char( 1 ) ; 
 ConsumptionPosting_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ServicePerformer_vc' 
 ServicePerformer : abap.char( 10 ) ; 
 ServicePerformer_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BaseUnit_vc' 
 BaseUnit : abap.char( 3 ) ; 
 BaseUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseOrderItemCategory_vc' 
 PurchaseOrderItemCategory : abap.char( 1 ) ; 
 PurchaseOrderItemCategory_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ProfitCenter_vc' 
 ProfitCenter : abap.char( 10 ) ; 
 ProfitCenter_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OrderPriceUnit_vc' 
 OrderPriceUnit : abap.char( 3 ) ; 
 OrderPriceUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ItemVolumeUnit_vc' 
 @Semantics.unitOfMeasure: true 
 ItemVolumeUnit : abap.unit( 3 ) ; 
 ItemVolumeUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ItemWeightUnit_vc' 
 @Semantics.unitOfMeasure: true 
 ItemWeightUnit : abap.unit( 3 ) ; 
 ItemWeightUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MultipleAcctAssgmtDistribut_vc' 
 MultipleAcctAssgmtDistribution : abap.char( 1 ) ; 
 MultipleAcctAssgmtDistribut_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PartialInvoiceDistribution_vc' 
 PartialInvoiceDistribution : abap.char( 1 ) ; 
 PartialInvoiceDistribution_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PricingDateControl_vc' 
 PricingDateControl : abap.char( 1 ) ; 
 PricingDateControl_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IsStatisticalItem_vc' 
 IsStatisticalItem : abap_boolean ; 
 IsStatisticalItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingParentItem_vc' 
 PurchasingParentItem : abap.numc( 5 ) ; 
 PurchasingParentItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'GoodsReceiptLatestCreationD_vc' 
 GoodsReceiptLatestCreationDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 GoodsReceiptLatestCreationD_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IsReturnsItem_vc' 
 IsReturnsItem : abap_boolean ; 
 IsReturnsItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingOrderReason_vc' 
 PurchasingOrderReason : abap.char( 3 ) ; 
 PurchasingOrderReason_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsClassification_vc' 
 IncotermsClassification : abap.char( 3 ) ; 
 IncotermsClassification_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsTransferLocation_vc' 
 IncotermsTransferLocation : abap.char( 28 ) ; 
 IncotermsTransferLocation_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsLocation1_vc' 
 IncotermsLocation1 : abap.char( 70 ) ; 
 IncotermsLocation1_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsLocation2_vc' 
 IncotermsLocation2 : abap.char( 70 ) ; 
 IncotermsLocation2_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PriorSupplier_vc' 
 PriorSupplier : abap.char( 10 ) ; 
 PriorSupplier_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'InternationalArticleNumber_vc' 
 InternationalArticleNumber : abap.char( 18 ) ; 
 InternationalArticleNumber_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IntrastatServiceCode_vc' 
 IntrastatServiceCode : abap.char( 30 ) ; 
 IntrastatServiceCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CommodityCode_vc' 
 CommodityCode : abap.char( 30 ) ; 
 CommodityCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MaterialFreightGroup_vc' 
 MaterialFreightGroup : abap.char( 8 ) ; 
 MaterialFreightGroup_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DiscountInKindEligibility_vc' 
 DiscountInKindEligibility : abap.char( 1 ) ; 
 DiscountInKindEligibility_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgItemIsBlockedForDeliver_vc' 
 PurgItemIsBlockedForDelivery : abap_boolean ; 
 PurgItemIsBlockedForDeliver_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierConfirmationControl_vc' 
 SupplierConfirmationControlKey : abap.char( 4 ) ; 
 SupplierConfirmationControl_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PriceIsToBePrinted_vc' 
 PriceIsToBePrinted : abap_boolean ; 
 PriceIsToBePrinted_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'AccountAssignmentCategory_vc' 
 AccountAssignmentCategory : abap.char( 1 ) ; 
 AccountAssignmentCategory_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingInfoRecord_vc' 
 PurchasingInfoRecord : abap.char( 10 ) ; 
 PurchasingInfoRecord_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'NetAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 NetAmount : abap.curr( 13, 3 ) ; 
 NetAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'GrossAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 GrossAmount : abap.curr( 13, 3 ) ; 
 GrossAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'EffectiveAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 EffectiveAmount : abap.curr( 13, 3 ) ; 
 EffectiveAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subtotal1Amount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 Subtotal1Amount : abap.curr( 13, 3 ) ; 
 Subtotal1Amount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subtotal2Amount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 Subtotal2Amount : abap.curr( 13, 3 ) ; 
 Subtotal2Amount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subtotal3Amount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 Subtotal3Amount : abap.curr( 13, 3 ) ; 
 Subtotal3Amount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subtotal4Amount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 Subtotal4Amount : abap.curr( 13, 3 ) ; 
 Subtotal4Amount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subtotal5Amount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 Subtotal5Amount : abap.curr( 13, 3 ) ; 
 Subtotal5Amount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Subtotal6Amount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 Subtotal6Amount : abap.curr( 13, 3 ) ; 
 Subtotal6Amount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OrderQuantity_vc' 
 @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit' 
 OrderQuantity : abap.dec( 13, 3 ) ; 
 OrderQuantity_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'NetPriceAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 NetPriceAmount : abap.curr( 11, 3 ) ; 
 NetPriceAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ItemVolume_vc' 
 @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit' 
 ItemVolume : abap.dec( 13, 3 ) ; 
 ItemVolume_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ItemGrossWeight_vc' 
 @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit' 
 ItemGrossWeight : abap.dec( 13, 3 ) ; 
 ItemGrossWeight_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ItemNetWeight_vc' 
 @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit' 
 ItemNetWeight : abap.dec( 13, 3 ) ; 
 ItemNetWeight_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OrderPriceUnitToOrderUnitNm_vc' 
 OrderPriceUnitToOrderUnitNmrtr : abap.dec( 5, 0 ) ; 
 OrderPriceUnitToOrderUnitNm_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OrdPriceUnitToOrderUnitDnmn_vc' 
 OrdPriceUnitToOrderUnitDnmntr : abap.dec( 5, 0 ) ; 
 OrdPriceUnitToOrderUnitDnmn_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'GoodsReceiptIsNonValuated_vc' 
 GoodsReceiptIsNonValuated : abap_boolean ; 
 GoodsReceiptIsNonValuated_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'TaxCode_vc' 
 TaxCode : abap.char( 2 ) ; 
 TaxCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'TaxJurisdiction_vc' 
 TaxJurisdiction : abap.char( 15 ) ; 
 TaxJurisdiction_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ShippingInstruction_vc' 
 ShippingInstruction : abap.char( 2 ) ; 
 ShippingInstruction_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ShippingType_vc' 
 ShippingType : abap.char( 2 ) ; 
 ShippingType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'NonDeductibleInputTaxAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 NonDeductibleInputTaxAmount : abap.curr( 13, 3 ) ; 
 NonDeductibleInputTaxAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'StockType_vc' 
 StockType : abap.char( 1 ) ; 
 StockType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ValuationType_vc' 
 ValuationType : abap.char( 10 ) ; 
 ValuationType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ValuationCategory_vc' 
 ValuationCategory : abap.char( 1 ) ; 
 ValuationCategory_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ItemIsRejectedBySupplier_vc' 
 ItemIsRejectedBySupplier : abap_boolean ; 
 ItemIsRejectedBySupplier_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgDocPriceDate_vc' 
 PurgDocPriceDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 PurgDocPriceDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgDocReleaseOrderQuantity_vc' 
 @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit' 
 PurgDocReleaseOrderQuantity : abap.dec( 13, 3 ) ; 
 PurgDocReleaseOrderQuantity_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'EarmarkedFunds_vc' 
 EarmarkedFunds : abap.char( 10 ) ; 
 EarmarkedFunds_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'EarmarkedFundsDocument_vc' 
 EarmarkedFundsDocument : abap.char( 10 ) ; 
 EarmarkedFundsDocument_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'EarmarkedFundsItem_vc' 
 EarmarkedFundsItem : abap.numc( 3 ) ; 
 EarmarkedFundsItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'EarmarkedFundsDocumentItem_vc' 
 EarmarkedFundsDocumentItem : abap.numc( 3 ) ; 
 EarmarkedFundsDocumentItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PartnerReportedBusinessArea_vc' 
 PartnerReportedBusinessArea : abap.char( 4 ) ; 
 PartnerReportedBusinessArea_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'InventorySpecialStockType_vc' 
 InventorySpecialStockType : abap.char( 1 ) ; 
 InventorySpecialStockType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DeliveryDocumentType_vc' 
 DeliveryDocumentType : abap.char( 4 ) ; 
 DeliveryDocumentType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IssuingStorageLocation_vc' 
 IssuingStorageLocation : abap.char( 4 ) ; 
 IssuingStorageLocation_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'AllocationTable_vc' 
 AllocationTable : abap.char( 10 ) ; 
 AllocationTable_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'AllocationTableItem_vc' 
 AllocationTableItem : abap.numc( 5 ) ; 
 AllocationTableItem_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'RetailPromotion_vc' 
 RetailPromotion : abap.char( 10 ) ; 
 RetailPromotion_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DownPaymentType_vc' 
 DownPaymentType : abap.char( 4 ) ; 
 DownPaymentType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DownPaymentPercentageOfTotA_vc' 
 DownPaymentPercentageOfTotAmt : abap.dec( 5, 2 ) ; 
 DownPaymentPercentageOfTotA_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DownPaymentAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 DownPaymentAmount : abap.curr( 11, 3 ) ; 
 DownPaymentAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DownPaymentDueDate_vc' 
 DownPaymentDueDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 DownPaymentDueDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ExpectedOverallLimitAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 ExpectedOverallLimitAmount : abap.curr( 13, 3 ) ; 
 ExpectedOverallLimitAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OverallLimitAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 OverallLimitAmount : abap.curr( 13, 3 ) ; 
 OverallLimitAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'RequirementSegment_vc' 
 RequirementSegment : abap.char( 40 ) ; 
 RequirementSegment_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgProdCmplncDngrsGoodsSta_vc' 
 PurgProdCmplncDngrsGoodsStatus : abap.char( 1 ) ; 
 PurgProdCmplncDngrsGoodsSta_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgProdCmplncSupplierStatu_vc' 
 PurgProdCmplncSupplierStatus : abap.char( 1 ) ; 
 PurgProdCmplncSupplierStatu_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgProductMarketabilitySta_vc' 
 PurgProductMarketabilityStatus : abap.char( 1 ) ; 
 PurgProductMarketabilitySta_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgSafetyDataSheetStatus_vc' 
 PurgSafetyDataSheetStatus : abap.char( 1 ) ; 
 PurgSafetyDataSheetStatus_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SubcontrgCompIsRealTmeCnsmd_vc' 
 SubcontrgCompIsRealTmeCnsmd : abap_boolean ; 
 SubcontrgCompIsRealTmeCnsmd_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BR_MaterialOrigin_vc' 
 BR_MaterialOrigin : abap.char( 1 ) ; 
 BR_MaterialOrigin_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BR_MaterialUsage_vc' 
 BR_MaterialUsage : abap.char( 1 ) ; 
 BR_MaterialUsage_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BR_CFOPCategory_vc' 
 BR_CFOPCategory : abap.char( 2 ) ; 
 BR_CFOPCategory_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BR_NCM_vc' 
 BR_NCM : abap.char( 16 ) ; 
 BR_NCM_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BR_IsProducedInHouse_vc' 
 BR_IsProducedInHouse : abap_boolean ; 
 BR_IsProducedInHouse_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 ETAG__ETAG : abap.string( 0 ) ; 
 
 } 

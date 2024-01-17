/********** GENERATED on 10/04/2023 at 09:04:44 by CB9980000021**************/
 @OData.entitySet.name: 'I_PurchaseOrderAPI01' 
 @OData.entityType.name: 'I_PurchaseOrderAPI01Type' 
 define root abstract entity ZRAP_I_PURCHASEORDERAPI01 { 
 key PurchaseOrder : abap.char( 10 ) ; 
 @Odata.property.valueControl: 'PurchaseOrderType_vc' 
 PurchaseOrderType : abap.char( 4 ) ; 
 PurchaseOrderType_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseOrderSubtype_vc' 
 PurchaseOrderSubtype : abap.char( 1 ) ; 
 PurchaseOrderSubtype_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingDocumentOrigin_vc' 
 PurchasingDocumentOrigin : abap.char( 1 ) ; 
 PurchasingDocumentOrigin_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CreatedByUser_vc' 
 CreatedByUser : abap.char( 12 ) ; 
 CreatedByUser_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CreationDate_vc' 
 CreationDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 CreationDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchaseOrderDate_vc' 
 PurchaseOrderDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 PurchaseOrderDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Language_vc' 
 Language : abap.char( 2 ) ; 
 Language_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CorrespncExternalReference_vc' 
 CorrespncExternalReference : abap.char( 12 ) ; 
 CorrespncExternalReference_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CorrespncInternalReference_vc' 
 CorrespncInternalReference : abap.char( 12 ) ; 
 CorrespncInternalReference_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingDocumentDeletionC_vc' 
 PurchasingDocumentDeletionCode : abap.char( 1 ) ; 
 PurchasingDocumentDeletionC_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ReleaseIsNotCompleted_vc' 
 ReleaseIsNotCompleted : abap_boolean ; 
 ReleaseIsNotCompleted_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingCompletenessStatu_vc' 
 PurchasingCompletenessStatus : abap_boolean ; 
 PurchasingCompletenessStatu_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingProcessingStatus_vc' 
 PurchasingProcessingStatus : abap.char( 2 ) ; 
 PurchasingProcessingStatus_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgReleaseSequenceStatus_vc' 
 PurgReleaseSequenceStatus : abap.char( 8 ) ; 
 PurgReleaseSequenceStatus_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ReleaseCode_vc' 
 ReleaseCode : abap.char( 1 ) ; 
 ReleaseCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CompanyCode_vc' 
 CompanyCode : abap.char( 4 ) ; 
 CompanyCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingOrganization_vc' 
 PurchasingOrganization : abap.char( 4 ) ; 
 PurchasingOrganization_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurchasingGroup_vc' 
 PurchasingGroup : abap.char( 3 ) ; 
 PurchasingGroup_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Supplier_vc' 
 Supplier : abap.char( 10 ) ; 
 Supplier_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ManualSupplierAddressID_vc' 
 ManualSupplierAddressID : abap.char( 10 ) ; 
 ManualSupplierAddressID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierRespSalesPersonName_vc' 
 SupplierRespSalesPersonName : abap.char( 30 ) ; 
 SupplierRespSalesPersonName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierPhoneNumber_vc' 
 SupplierPhoneNumber : abap.char( 16 ) ; 
 SupplierPhoneNumber_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplyingSupplier_vc' 
 SupplyingSupplier : abap.char( 10 ) ; 
 SupplyingSupplier_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplyingPlant_vc' 
 SupplyingPlant : abap.char( 4 ) ; 
 SupplyingPlant_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'InvoicingParty_vc' 
 InvoicingParty : abap.char( 10 ) ; 
 InvoicingParty_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Customer_vc' 
 Customer : abap.char( 10 ) ; 
 Customer_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SupplierQuotationExternalID_vc' 
 SupplierQuotationExternalID : abap.char( 10 ) ; 
 SupplierQuotationExternalID_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PaymentTerms_vc' 
 PaymentTerms : abap.char( 4 ) ; 
 PaymentTerms_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CashDiscount1Days_vc' 
 CashDiscount1Days : abap.dec( 3, 0 ) ; 
 CashDiscount1Days_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CashDiscount2Days_vc' 
 CashDiscount2Days : abap.dec( 3, 0 ) ; 
 CashDiscount2Days_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'NetPaymentDays_vc' 
 NetPaymentDays : abap.dec( 3, 0 ) ; 
 NetPaymentDays_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CashDiscount1Percent_vc' 
 CashDiscount1Percent : abap.dec( 5, 3 ) ; 
 CashDiscount1Percent_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CashDiscount2Percent_vc' 
 CashDiscount2Percent : abap.dec( 5, 3 ) ; 
 CashDiscount2Percent_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
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
 @Odata.property.valueControl: 'IncotermsClassification_vc' 
 IncotermsClassification : abap.char( 3 ) ; 
 IncotermsClassification_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsTransferLocation_vc' 
 IncotermsTransferLocation : abap.char( 28 ) ; 
 IncotermsTransferLocation_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsVersion_vc' 
 IncotermsVersion : abap.char( 4 ) ; 
 IncotermsVersion_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsLocation1_vc' 
 IncotermsLocation1 : abap.char( 70 ) ; 
 IncotermsLocation1_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IncotermsLocation2_vc' 
 IncotermsLocation2 : abap.char( 70 ) ; 
 IncotermsLocation2_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IsIntrastatReportingRelevan_vc' 
 IsIntrastatReportingRelevant : abap_boolean ; 
 IsIntrastatReportingRelevan_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'IsIntrastatReportingExclude_vc' 
 IsIntrastatReportingExcluded : abap_boolean ; 
 IsIntrastatReportingExclude_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PricingDocument_vc' 
 PricingDocument : abap.char( 10 ) ; 
 PricingDocument_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PricingProcedure_vc' 
 PricingProcedure : abap.char( 6 ) ; 
 PricingProcedure_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DocumentCurrency_vc' 
 @Semantics.currencyCode: true 
 DocumentCurrency : abap.cuky ; 
 DocumentCurrency_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ValidityStartDate_vc' 
 ValidityStartDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 ValidityStartDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ValidityEndDate_vc' 
 ValidityEndDate : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 ValidityEndDate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ExchangeRate_vc' 
 ExchangeRate : abap.dec( 9, 5 ) ; 
 ExchangeRate_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ExchangeRateIsFixed_vc' 
 ExchangeRateIsFixed : abap_boolean ; 
 ExchangeRateIsFixed_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'LastChangeDateTime_vc' 
 LastChangeDateTime : tzntstmpl ; 
 LastChangeDateTime_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'TaxReturnCountry_vc' 
 TaxReturnCountry : abap.char( 3 ) ; 
 TaxReturnCountry_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'VATRegistrationCountry_vc' 
 VATRegistrationCountry : abap.char( 3 ) ; 
 VATRegistrationCountry_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgReasonForDocCancellatio_vc' 
 PurgReasonForDocCancellation : abap.numc( 2 ) ; 
 PurgReasonForDocCancellatio_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgReleaseTimeTotalAmount_vc' 
 @Semantics.amount.currencyCode: 'DocumentCurrency' 
 PurgReleaseTimeTotalAmount : abap.curr( 15, 3 ) ; 
 PurgReleaseTimeTotalAmount_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgAggrgdProdCmplncSuplrSt_vc' 
 PurgAggrgdProdCmplncSuplrSts : abap.char( 1 ) ; 
 PurgAggrgdProdCmplncSuplrSt_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgAggrgdProdMarketability_vc' 
 PurgAggrgdProdMarketabilitySts : abap.char( 1 ) ; 
 PurgAggrgdProdMarketability_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgAggrgdSftyDataSheetStat_vc' 
 PurgAggrgdSftyDataSheetStatus : abap.char( 1 ) ; 
 PurgAggrgdSftyDataSheetStat_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PurgProdCmplncTotDngrsGoods_vc' 
 PurgProdCmplncTotDngrsGoodsSts : abap.char( 1 ) ; 
 PurgProdCmplncTotDngrsGoods_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 ETAG__ETAG : abap.string( 0 ) ; 
 
 @OData.property.name: 'to_PurchaseOrderItem' 
//A dummy on-condition is required for associations in abstract entities 
//On-condition is not relevant for runtime 
 _PurchaseOrderItem : association [0..*] to ZRAP_I_PURCHASEORDERITEMAPI01 on 1 = 1; 
 } 

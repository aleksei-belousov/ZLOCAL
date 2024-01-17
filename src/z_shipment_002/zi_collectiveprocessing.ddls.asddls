@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_CollectiveProcessing'
@ObjectModel.representativeKey: 'CollectiveProcessing'
//@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass:#TRANSACTIONAL
//@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.sizeCategory: #L
@Metadata.ignorePropagatedAnnotations:true
@ObjectModel.supportedCapabilities:  [  #SQL_DATA_SOURCE,
                                        #CDS_MODELING_DATA_SOURCE,
                                        #CDS_MODELING_ASSOCIATION_TARGET  ]

define root view entity ZI_CollectiveProcessing as select from I_CollectiveProcessing as CollectiveProcessing
{
    key CollectiveProcessing,
    CollectiveProcessingType,
    /* Associations */
    _CollectiveProcessingDocument
}

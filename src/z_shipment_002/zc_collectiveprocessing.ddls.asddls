@EndUserText.label: 'ZC_COLLECTIVEPROCESSING'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_CollectiveProcessing provider contract transactional_query as projection on ZI_CollectiveProcessing as CollectiveProcessing 
{
    key CollectiveProcessing,
    CollectiveProcessingType,
    /* Associations */
    _CollectiveProcessingDocument
}

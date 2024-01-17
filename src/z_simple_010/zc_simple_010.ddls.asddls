@EndUserText.label: 'ZC_SIMPLE_010'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SIMPLE_010 provider contract transactional_query
 as projection on ZI_SIMPLE_010 as Simple 
{
    key SimpleUUID,

    SimpleID,

//    @Consumption.dynamicLabel: { label : 'Year &1' , binding : [ {  index : 1 , parameter : 'Data 2' } ] } -- it does not work 
//    @Consumption.hidden: true -- it works
    Data1,

    Data2,

    Data3,

    Customer,
    
    Boolean

}

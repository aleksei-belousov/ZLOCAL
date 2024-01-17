@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_010'
define root view entity ZI_SIMPLE_010
 //with parameters
 //@Consumption.defaultValue: 'EUR'
 //P_MyParameter : abap.char( 5 )
 as select from zsimple_010 as Simple
//composition of target_data_source_name as _association_name
{
    key simpleuuid as SimpleUUID,

    simpleid as SimpleID,

    data1 as Data1,

    @Consumption.dynamicLabel.label: 'Data1'
    //@Consumption.labelElement: 'Data1'
    //@Consumption.quickInfoElement: 'Data1'
    data2 as Data2,

    data3 as Data3,

    customer as Customer,
    
    boolean as Boolean
    //$parameters.P_MyParameter as my_parameter
    //_association_name // Make association public
}

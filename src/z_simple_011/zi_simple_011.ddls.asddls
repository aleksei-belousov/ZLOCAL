@EndUserText.label: 'ZI_SIMPLE_011'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_SIMPLE_011 as select from zsimple_011 as Simple
composition [0..*] of ZI_ITEM_011 as _Item
{
    key simpleuuid as SimpleUUID,
    simpleid as SimpleID,
    data1 as Data1,
    data2 as Data2,
    data3 as Data3,
    createdby as CreatedBy, 
    createdat as CreatedAt,
    lastchangedby as LastChangedBy,
    lastchangedat as LastChangedAt,
    locallastchangedat as LocalLastChangedAt,
    _Item // Make association public
}

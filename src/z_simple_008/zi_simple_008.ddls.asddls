@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_008'
define root view entity ZI_SIMPLE_008 as select from zsimple_008
{
    key uuid as Uuid,
    id as Id,
    data0 as Data0,
    data1 as Data1,
    data2 as Data2,
    data3 as Data3,
    data4 as Data4,
    data5 as Data5,
    data6 as Data6,
    data7 as Data7,
    data8 as Data8,
    data9 as Data9,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_SIMPLE_007M'
define root view entity ZI_SIMPLE_007M as select from zsimple_007
{
    key id as Id,
    data0 as Data0,
    data1 as Data1,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}

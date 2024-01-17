@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_MATRIX_004'
define root view entity ZI_MATRIX_004 as select from zmatrix_004 as Matrix
composition [0..*] of ZI_SIZE_004 as _Size
composition [0..*] of ZI_ITEM_004 as _Item
{
    key matrixuuid          as MatrixUUID,
    matrixid                as MatrixID,
    salesordertype          as SalesOrderType,
    salesorganization       as SalesOrganization,
    distributionchannel     as DistributionChannel,
    organizationdivision    as OrganizationDivision,
    soldtoparty             as SoldToParty,
    model                   as Model,
    color                   as Color,
    salesorderid            as SalesOrderID,
    creationdate            as CreationDate,
    creationtime            as CreationTime,
    /* associations */
    _Size,
    _Item
}

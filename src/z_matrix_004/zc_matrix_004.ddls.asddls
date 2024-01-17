@EndUserText.label: 'ZC_MATRIX_004'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_MATRIX_004 provider contract transactional_query as projection on ZI_MATRIX_004 as Matrix
{
    key MatrixUUID,
    MatrixID,
    SalesOrderType,
    SalesOrganization,
    DistributionChannel,
    OrganizationDivision,
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer', element: 'Customer' } } ]
    SoldToParty,
    Model,
    Color,
    SalesOrderID,
    CreationDate,
    CreationTime,
    /* Associations */
    _Size: redirected to composition child ZC_SIZE_004,
    _Item: redirected to composition child ZC_ITEM_004
}

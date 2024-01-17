CLASS zcl_mm_pur_s4_po_modify_item DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_badi_interface.
    INTERFACES if_mm_pur_s4_po_modify_item.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MM_PUR_S4_PO_MODIFY_ITEM IMPLEMENTATION.


  METHOD if_mm_pur_s4_po_modify_item~modify_item.

* Example:
*    MODIFY ENTITIES OF zi_matrix_005 IN LOCAL MODE
*        ENTITY Matrix
*        UPDATE FIELDS ( MatrixID SalesOrderType SalesOrganization DistributionChannel OrganizationDivision SoldToParty Model Color MatrixTypeID Country )
*        WITH VALUE #( (
*            %tky                    = <entity>-%tky
*            MatrixID                = matrixid
*            SalesOrderType          = 'OR'
*            SalesOrganization       = '1000' " '1010'
*            DistributionChannel     = '10'
*            OrganizationDivision    = '00'
*            SoldToParty             = space " '0010100014'
*            Model                   = space
*            Color                   = space
*            MatrixTypeID            = space
*            Country                 = 'DE'
*        ) )
*        FAILED DATA(ls_matrix_update_failed1)
*        MAPPED DATA(ls_matrix_update_mapped1)
*        REPORTED DATA(ls_matrix_update_reported1).

*   Executing "MODIFY ENTITIES" from "MODIFY_ITEM" violates transactional contract "FUNCTIONAL".
*    MODIFY ENTITIES OF I_PurchaseOrderTP_2 IN LOCAL MODE
*        ENTITY PurchaseOrder
*        UPDATE FIELDS ( IncotermsLocation1 )
*        WITH VALUE #( (
*            %tky-PurchaseOrder = purchaseorder
*            IncotermsLocation1 = 'BBBB'
*        ) )
*        FAILED DATA(ls_failed)
*        MAPPED DATA(ls_mapped)
*        REPORTED DATA(ls_reported).


  ENDMETHOD. " if_mm_pur_s4_po_modify_item~modify_item
ENDCLASS.

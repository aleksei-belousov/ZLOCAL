CLASS zcl_mm_pur_s4_po_modify_header DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_badi_interface .
    INTERFACES if_mm_pur_s4_po_modify_header .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MM_PUR_S4_PO_MODIFY_HEADER IMPLEMENTATION.


  METHOD if_mm_pur_s4_po_modify_header~modify_header.

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

*   Executing "UPDATE <dbtab>" from "MODIFY_HEADER" violates transactional contract "FUNCTIONAL".
*    UPDATE i_PurchaseOrderTP_2 SET IncotermsLocation1 = 'BBBB' WHERE PurchaseOrder = purchaseorder-purchaseorder.

  ENDMETHOD. " if_mm_pur_s4_po_modify_header~modify_header
ENDCLASS.

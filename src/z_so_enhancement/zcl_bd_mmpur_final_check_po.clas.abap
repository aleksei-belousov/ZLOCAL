CLASS zcl_bd_mmpur_final_check_po DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_badi_interface .
    INTERFACES if_ex_mmpur_final_check_po .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BD_MMPUR_FINAL_CHECK_PO IMPLEMENTATION.


  METHOD if_ex_mmpur_final_check_po~check.

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


  ENDMETHOD.
ENDCLASS.

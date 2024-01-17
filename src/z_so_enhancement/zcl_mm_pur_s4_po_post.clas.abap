CLASS zcl_mm_pur_s4_po_post DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_badi_interface .
    INTERFACES if_mm_pur_s4_po_post .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MM_PUR_S4_PO_POST IMPLEMENTATION.


  METHOD if_mm_pur_s4_po_post~post.

**   The old variant of "<dynamic-object>" should not be used in the current ABAP language version.
*    FIELD-SYMBOLS <lt_purchaseorderitems> TYPE if_ex_mmpur_final_check_po=>gty_t_purorderitem.
*    ASSIGN ('(SAPLMEPOBADI)lt_purchaseorderitems[]') TO <lt_purchaseorderitems>. " does not work
*    IF ( sy-subrc = 0 ).
*        LOOP AT <lt_purchaseorderitems> ASSIGNING FIELD-SYMBOL(<ls_purchaseorderitems>).
*            <ls_purchaseorderitems>-purchasecontract = '460000000000'.
*        ENDLOOP.
*    ENDIF.

  ENDMETHOD.
ENDCLASS.

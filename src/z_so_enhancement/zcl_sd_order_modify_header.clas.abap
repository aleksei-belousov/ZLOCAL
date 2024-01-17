CLASS zcl_sd_order_modify_header DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_edi_sd_order_modify_header .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SD_ORDER_MODIFY_HEADER IMPLEMENTATION.


  METHOD if_edi_sd_order_modify_header~modify_header.

* set break-point here
   order_request_header_change-customerpurchaseordertype = 2.
   order_request_header_change-sddocumentreason = 3.
   order_request_header_change-supplierpaymenttermsid = 4.

  ENDMETHOD.
ENDCLASS.

CLASS zcl_edi_sd_order_modify_hdr_pt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_edi_sd_order_modify_hdr_pty .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EDI_SD_ORDER_MODIFY_HDR_PT IMPLEMENTATION.


  METHOD if_edi_sd_order_modify_hdr_pty~modify_header_party.

*    header_party_change-region = 'CA'.

  ENDMETHOD.
ENDCLASS.

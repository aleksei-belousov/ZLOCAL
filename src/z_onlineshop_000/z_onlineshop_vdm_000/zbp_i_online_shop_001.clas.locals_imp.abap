CLASS lhc_Online_Shop DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Online_Shop RESULT result.

    METHODS create_pr FOR MODIFY
      IMPORTING keys FOR ACTION Online_Shop~create_pr.

    METHODS set_inforecord FOR MODIFY
      IMPORTING keys FOR ACTION Online_Shop~set_inforecord.

    METHODS update_inforecord FOR MODIFY
      IMPORTING keys FOR ACTION Online_Shop~update_inforecord.

    METHODS calculate_order_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Online_Shop~calculate_order_id.

ENDCLASS.

CLASS lhc_Online_Shop IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create_pr.
  ENDMETHOD.

  METHOD set_inforecord.
  ENDMETHOD.

  METHOD update_inforecord.
  ENDMETHOD.

  METHOD calculate_order_id.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_ONLINE_SHOP_000 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_ONLINE_SHOP_000 IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

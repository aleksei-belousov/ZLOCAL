CLASS lsc_zmatrix2_data DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.
    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zmatrix2_data IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zmatrix2_data DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Matrix_Shop RESULT result.

    METHODS create_so FOR MODIFY
      IMPORTING keys FOR ACTION matrix_shop~create_so.

    METHODS calculate_order_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR matrix_shop~calculate_order_id.
    METHODS ordereditem FOR DETERMINE ON MODIFY
      IMPORTING keys FOR matrix_shop~ordereditem.

ENDCLASS.

CLASS lhc_zmatrix2_data IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create_so.
  ENDMETHOD.

  METHOD calculate_order_id.
  ENDMETHOD.

  METHOD Ordereditem.
  ENDMETHOD.

ENDCLASS.

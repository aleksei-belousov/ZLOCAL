CLASS lhc_size DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS on_size_modify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Size~on_size_modify.

ENDCLASS.

CLASS lhc_size IMPLEMENTATION.

  METHOD on_size_modify.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

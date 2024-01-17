CLASS lsc_zi_bool_001 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

ENDCLASS.

CLASS lsc_zi_bool_001 IMPLEMENTATION.

ENDCLASS.

CLASS lhc_bool DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR bool RESULT result.

ENDCLASS.

CLASS lhc_bool IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

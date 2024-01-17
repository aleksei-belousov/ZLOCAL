CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

    METHODS test FOR MODIFY IMPORTING keys FOR ACTION simple~test. " Delete All

ENDCLASS.

CLASS lhc_simple IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Test. " Delete All

    LOOP AT keys INTO DATA(key).
    ENDLOOP. " Test

*   Read All Simples
*   SELECT * FROM zi_simple_012 INTO TABLE @DATA(simple).

    DELETE FROM zsimple_012.

  ENDMETHOD. " Test

ENDCLASS.
* a Change

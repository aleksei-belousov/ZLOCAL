CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

    METHODS validatedata0 FOR VALIDATE ON SAVE
      IMPORTING keys FOR simple~validatedata0.
    METHODS activate FOR MODIFY
      IMPORTING keys FOR ACTION simple~activate.

    METHODS edit FOR MODIFY
      IMPORTING keys FOR ACTION simple~edit.

    METHODS resume FOR MODIFY
      IMPORTING keys FOR ACTION simple~resume.
    METHODS calculate_on_modify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR simple~calculate_on_modify.

ENDCLASS.

CLASS lhc_simple IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateData0.
  ENDMETHOD.

  METHOD Activate.
  ENDMETHOD.

  METHOD Edit.
  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD calculate_on_modify.
   "read transfered instances
    READ ENTITIES OF zi_simple_008 IN LOCAL MODE
      ENTITY Simple
        FIELDS ( Data1 Data2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and set Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
        <entity>-Data3 = <entity>-Data1 + <entity>-Data2.
    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF zc_simple_008 " IN LOCAL MODE
      ENTITY Simple
        UPDATE FIELDS ( Data3 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
                           %tky     = entity-%tky
                           Data3    = entity-Data3
                    ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_simple_008 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    "METHODS save_modified REDEFINITION.

    "METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_simple_008 IMPLEMENTATION.

  "METHOD save_modified.
  "ENDMETHOD.

  "METHOD cleanup_finalize.
  "ENDMETHOD.

ENDCLASS.

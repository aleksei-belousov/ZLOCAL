CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    DATA wa_simple_007 TYPE zsimple_007.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE simple.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE simple.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE simple.

    METHODS read FOR READ
      IMPORTING keys FOR READ simple RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK simple.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

ENDCLASS.

CLASS lhc_simple IMPLEMENTATION.

  METHOD create.

*    DATA legacy_entity_in  TYPE zsimple_007.
*    DATA legacy_entity_out TYPE zsimple_007.
*    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
*
*        legacy_entity_in = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
*
*        APPEND VALUE #( %cid = <entity>-%cid uuid = <entity>-Uuid ) TO mapped-simple.
*
*    ENDLOOP.

*    DATA it_simple TYPE TABLE FOR CREATE zi_simple_007.
*    it_simple = VALUE #( (
*            Data0 = '0'
*            Data1 = '1'
*    ) ).
*    MODIFY ENTITIES OF zi_simple_007 IN LOCAL MODE
*        ENTITY Simple CREATE FIELDS ( Data0 Data1 ) WITH it_simple.
*             MAPPED   DATA(mapped)
*             FAILED   DATA(failed)
*             REPORTED DATA(reported).


    DATA entity LIKE LINE OF entities.
    READ TABLE entities INDEX 1 INTO entity.
    IF ( sy-subrc = 0 ).
        DATA maxid TYPE zsimple_007-id VALUE '0'.
        DATA newid TYPE zsimple_007-id VALUE '1'.
        SELECT MAX( id ) FROM zsimple_007 INTO @maxid.
        newid = maxid + 1.
        CONDENSE newid NO-GAPS.
        wa_simple_007-id    = newid.
        wa_simple_007-Data0 = entity-Data0.
        wa_simple_007-Data1 = entity-Data1.
        INSERT zsimple_007 FROM @wa_simple_007.
    ENDIF.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.

    READ TABLE keys INDEX 1 INTO DATA(key).
    IF ( sy-subrc = 0 ).
        DELETE FROM zsimple_007 WHERE ( id = @key-Id ).
    ENDIF.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_simple_007 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

    METHODS new_message REDEFINITION.

ENDCLASS.

CLASS lsc_zi_simple_007 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

  METHOD new_message.
  ENDMETHOD.

ENDCLASS.

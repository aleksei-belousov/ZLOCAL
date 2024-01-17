CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

ENDCLASS.

CLASS lhc_simple IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_simple_007m DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_simple_007m IMPLEMENTATION.

  METHOD save_modified.

    DATA wa_zsimple_007 TYPE zsimple_007.
    DATA wa_change_simple LIKE LINE OF create-simple.
    DATA wa_delete_simple LIKE LINE OF delete-simple.

    LOOP AT create-simple INTO wa_change_simple.
        MOVE-CORRESPONDING wa_change_simple TO wa_zsimple_007.
        MODIFY zsimple_007 FROM @wa_zsimple_007.
    ENDLOOP.

    LOOP AT update-simple INTO wa_change_simple.
        IF ( wa_change_simple-%control-Id = flag_changed ). " change of Id is forbidden
            CONTINUE. " ignore
        ENDIF.
        SELECT SINGLE * FROM zsimple_007 WHERE ( id = @wa_change_simple-Id ) INTO @wa_zsimple_007.
        IF ( sy-subrc = 0 ).
            "MOVE-CORRESPONDING wa_change_simple TO wa_zsimple_007.
            IF ( wa_change_simple-%control-Data0 = flag_changed ).
                wa_zsimple_007-Data0 = wa_change_simple-Data0.
            ENDIF.
            IF ( wa_change_simple-%control-Data1 = flag_changed ).
                wa_zsimple_007-Data1 = wa_change_simple-Data1.
            ENDIF.
            MODIFY zsimple_007 FROM @wa_zsimple_007.
        ENDIF.
    ENDLOOP.

    LOOP AT delete-simple INTO wa_delete_simple.
        MOVE-CORRESPONDING wa_delete_simple TO wa_zsimple_007.
        DELETE zsimple_007 FROM @wa_zsimple_007.
    ENDLOOP.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

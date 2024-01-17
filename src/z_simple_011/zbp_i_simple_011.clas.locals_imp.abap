CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

    METHODS resume FOR MODIFY IMPORTING keys FOR ACTION simple~resume.

    METHODS get_instance_features FOR INSTANCE FEATURES IMPORTING keys REQUEST requested_features FOR simple RESULT result.

    METHODS create_item FOR MODIFY IMPORTING keys FOR ACTION simple~create_item.

    METHODS update_items FOR MODIFY IMPORTING keys FOR ACTION simple~update_items.

    METHODS event_on_modify FOR DETERMINE ON MODIFY IMPORTING keys FOR simple~event_on_modify.

    METHODS event_on_save FOR DETERMINE ON SAVE IMPORTING keys FOR simple~event_on_save.

    "METHODS activate FOR MODIFY IMPORTING keys FOR ACTION simple~activate.

    "METHODS discard FOR MODIFY IMPORTING keys FOR ACTION simple~discard.

    "METHODS edit FOR MODIFY IMPORTING keys FOR ACTION simple~edit.

ENDCLASS. " lhc_simple DEFINITION

CLASS lhc_simple IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  "METHOD Activate.
  "ENDMETHOD.

  "METHOD Discard.
  "ENDMETHOD.

  "METHOD Edit.
  "ENDMETHOD.

  METHOD resume.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD create_item. " Add a New Item

*   Make an Item
    DATA it_item TYPE TABLE FOR CREATE zi_simple_011\_Item. " Item
    DATA wa_item LIKE LINE OF it_item.
    DATA cid TYPE string.

    LOOP AT keys INTO DATA(key).

        IF ( key-%is_draft = '00' ). " Saved (if_abap_behv=>mk-off)

            " find max item id
            SELECT MAX( ItemID ) FROM zc_item_011 WHERE ( SimpleUUID = @key-SimpleUUID ) INTO @DATA(maxid).

            " fill in items
            cid = maxid + 1.
            APPEND VALUE #(
                SimpleUUID  = key-SimpleUUID
                %is_draft   = key-%is_draft
                %target = VALUE #( (
                    %is_draft   = key-%is_draft
                    %cid        = cid
                    ItemID      = cid
                    Data4       = '4'
                    Data5       = '5'
                    Data6       = '6'
                ) )
            ) TO it_item.

            "create a new item for the simple
            MODIFY ENTITIES OF zi_simple_011 IN LOCAL MODE
                ENTITY Simple
                CREATE BY \_Item
                FIELDS ( ItemID Data4 Data5 Data6 )
                WITH it_item
                FAILED DATA(it_failed1)
                MAPPED DATA(it_mapped1)
                REPORTED DATA(it_reported1).

        ENDIF.

        IF ( key-%is_draft = '01' ). " Draft (if_abap_behv=>mk-on)

*            APPEND VALUE #( %key = key-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = 'Data not saved.' ) ) TO reported-simple.

            " find max item id
            SELECT MAX( ItemID ) FROM zitem_011d WHERE ( SimpleUUID = @key-SimpleUUID ) INTO @maxid.

            " fill in items
            cid = maxid + 1.
            APPEND VALUE #(
                SimpleUUID  = key-SimpleUUID
                %is_draft   = key-%is_draft
                %target = VALUE #( (
                    %is_draft   = key-%is_draft
                    %cid                = cid
                    ItemID              = cid
                    Data4               = '4'
                    Data5               = '5'
                    Data6               = '6'
                ) )
            ) TO it_item.

            "create a new item for the simple
            MODIFY ENTITIES OF zi_simple_011 IN LOCAL MODE
                ENTITY Simple
                CREATE BY \_Item
                FIELDS ( ItemID Data4 Data5 Data6 )
                WITH it_item
                FAILED DATA(it_failed2)
                MAPPED DATA(it_mapped2)
                REPORTED DATA(it_reported2).

        ENDIF.

    ENDLOOP.

  ENDMETHOD. " create_item

* Update Items
  METHOD update_items.

   "read transfered instances
    READ ENTITIES OF zc_simple_011
      ENTITY Simple
        FIELDS ( Data1 Data2 Data3 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    " read and set Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

        <entity>-Data3 = <entity>-Data1 + <entity>-Data2.
        CONDENSE <entity>-Data3 NO-GAPS.

*        " update instances
        MODIFY ENTITIES OF zi_simple_011 IN LOCAL MODE
            ENTITY Simple
            UPDATE FIELDS (
                Data3
            )
            WITH VALUE #( (
                %tky     = <entity>-%tky
                Data3    = <entity>-Data3
            ) )
            MAPPED DATA(ls_simple_mapped)
            FAILED DATA(ls_simple_failed)
            REPORTED DATA(ls_simple_reported).

        " read items
        READ ENTITIES OF zi_simple_011 IN LOCAL MODE
            ENTITY Simple BY \_Item
            FROM VALUE #( (
                %tky = <entity>-%tky
            ) )
            RESULT DATA(lt_item)
            FAILED DATA(ls_item_failed)
            REPORTED DATA(ls_item_reported).

        " update items
        LOOP AT lt_item INTO DATA(ls_item).

            MODIFY ENTITIES OF zi_simple_011 IN LOCAL MODE
                ENTITY Item
                UPDATE FIELDS (
                    Data4
                    Data5
                    Data6
                )
                WITH VALUE #( (
                    %tky        = ls_item-%tky
                    Data4       = <entity>-Data3
                    Data5       = <entity>-Data3
                    Data6       = <entity>-Data3
                ) )
                MAPPED DATA(ls_item_mapped2)
                FAILED DATA(ls_item_failed2)
                REPORTED DATA(ls_item_reported2).

        ENDLOOP.

    ENDLOOP.

  ENDMETHOD. " update_items

  METHOD event_on_modify. " Side Effect (Calculate: Data3 = Data1 + Data2)

   "read transfered instances
    READ ENTITIES OF zc_simple_011
      ENTITY Simple
        FIELDS ( Data1 Data2 Data3 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    " read and set Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

        <entity>-Data3 = <entity>-Data1 + <entity>-Data2.
        CONDENSE <entity>-Data3 NO-GAPS.

        " update instances
        MODIFY ENTITIES OF zi_simple_011 IN LOCAL MODE
            ENTITY Simple
            UPDATE FIELDS (
                Data3
            )
            WITH VALUE #( (
                %tky     = <entity>-%tky
                Data3    = <entity>-Data3
            ) )
            MAPPED DATA(ls_simple_mapped)
            FAILED DATA(ls_simple_failed)
            REPORTED DATA(ls_simple_reported).

        " read items
        READ ENTITIES OF zi_simple_011 IN LOCAL MODE
            ENTITY Simple BY \_Item
            FROM VALUE #( (
                %tky = <entity>-%tky
            ) )
            RESULT DATA(lt_item)
            FAILED DATA(ls_item_failed)
            REPORTED DATA(ls_item_reported).

        " update items
        LOOP AT lt_item INTO DATA(ls_item).

            MODIFY ENTITIES OF zi_simple_011 IN LOCAL MODE
                ENTITY Item
                UPDATE FIELDS (
                    Data4
                    Data5
                    Data6
                )
                WITH VALUE #( (
                    %tky        = ls_item-%tky
                    Data4       = <entity>-Data3
                    Data5       = <entity>-Data3
                    Data6       = <entity>-Data3
                ) )
                MAPPED DATA(ls_item_mapped2)
                FAILED DATA(ls_item_failed2)
                REPORTED DATA(ls_item_reported2).

        ENDLOOP.

    ENDLOOP.

  ENDMETHOD. " event_on_modify

  METHOD event_on_save.
  ENDMETHOD. " event_on_save

ENDCLASS. " lhc_simple IMPLEMENTATION.


CLASS lsc_zi_simple_011 DEFINITION INHERITING FROM cl_abap_behavior_saver.
    PROTECTED SECTION.

        "METHODS save_modified REDEFINITION.

        "METHODS save REDEFINITION.

ENDCLASS. " lsc_zi_simple_011

CLASS lsc_zi_simple_011 IMPLEMENTATION.

   "METHOD save_modified.
   "ENDMETHOD.

   "METHOD save.
   "ENDMETHOD.

ENDCLASS. " lsc_zi_simple_011 IMPLEMENTATION

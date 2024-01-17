CLASS lsc_zi_simple_009 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zi_simple_009 IMPLEMENTATION.

  METHOD save_modified.

*    TYPES:
*      BEGIN OF ts_title,
*        type  TYPE string,
*        label TYPE string,
*        value TYPE string,
*      END OF ts_title,
*
*      BEGIN OF ts_header_info,
*        typename       TYPE string,
*        typenameplural TYPE string,
*        title          TYPE ts_title,
*      END OF ts_header_info,
*
*      BEGIN OF ts_ui,
*        headerinfo TYPE ts_header_info,
*      END OF ts_ui.
*
*    DATA ls_ui TYPE ts_ui.
*
*    DATA(lo_view_entity) = xco_cp_cds=>view_entity( 'MY_VIEW_ENTITY' ).
*
*    xco_cp_cds=>annotations->direct->of( lo_view_entity
*      )->pick( 'UI'
*      )->get_value(
*      )->write_to( REF #( ls_ui ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

    METHODS test1 FOR MODIFY
      IMPORTING keys FOR ACTION simple~test1.

    METHODS test2 FOR MODIFY
      IMPORTING keys FOR ACTION simple~test2.

    METHODS create_items FOR MODIFY
      IMPORTING keys FOR ACTION simple~create_items.

    METHODS calc_on_action FOR MODIFY
      IMPORTING keys FOR ACTION simple~calc_on_action.

    METHODS calc_on_modify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR simple~calc_on_modify.


ENDCLASS. " lhc_simple DEFINITION

CLASS lhc_simple IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD. " get_instance_authorizations

  METHOD test1.

    READ ENTITY zc_simple_009\\Simple FROM VALUE #(
      FOR <root_key> IN keys ( %key-HeaderUUID     = <root_key>-HeaderUUID
*                               %control = VALUE #( Data1 = if_abap_behv=>mk-on
*                                                   Data2 = if_abap_behv=>mk-on )
                             )
      )
      RESULT DATA(lt_simple_result).

    LOOP AT lt_simple_result INTO DATA(ls_simple_result).

*        APPEND VALUE #( %key        = ls_simple_result-%key
*                        HeaderUUID  = ls_simple_result-HeaderUUID ) TO failed-simple.

        APPEND VALUE #( %key     = ls_simple_result-%key
                        %msg     = new_message( id       = 'Z_SIMPLE_009'
                                                number   = 001
                                                v1       = 'Hello, Message!'
                                                severity = if_abap_behv_message=>severity-success )
*                        %element-Data1 = if_abap_behv=>mk-on
*                        %element-Data2 = if_abap_behv=>mk-on
               )
               TO reported-simple.

        APPEND VALUE #( %key = ls_simple_result-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Hello, Free Text!' ) ) TO reported-simple.

    ENDLOOP.

  ENDMETHOD. " test1

  METHOD test2.
    LOOP AT keys INTO DATA(key).
        APPEND VALUE #( %key = key-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Hello, Free Text!' ) ) TO reported-simple.
    ENDLOOP.
  ENDMETHOD. " test2

  METHOD create_items.

*   Make Items
    DATA it_item TYPE TABLE FOR CREATE zi_simple_009\_Item. " Item
    DATA wa_item LIKE LINE OF it_item.
    DATA cid TYPE string.

    LOOP AT keys INTO DATA(key).

        " find max item id
        SELECT MAX( ItemID ) FROM zc_item_009 WHERE ( HeaderUUID = @key-HeaderUUID ) INTO @DATA(maxid).

        " fill in items
        "cid = CONV string( sy-tabix ).
        cid = maxid + 1.
        APPEND VALUE #(
            HeaderUUID              = key-HeaderUUID
            %target = VALUE #( (
                %cid                = cid
                ItemID              = cid
                Data4               = '4'
                Data5               = '5'
                Data6               = '6'
            ) )
        ) TO it_item.

        "create a new item for the simple
        MODIFY ENTITY IN LOCAL MODE zi_simple_009
          CREATE BY \_Item AUTO FILL CID
          FIELDS ( ItemID Data4 Data5 Data6 )
          WITH it_item " VALUE #( ( HeaderUUID = key-HeaderUUID %target = VALUE #( ( ItemID = '1'  Data4 = '4' Data5 = '5' Data6 = '6' ) ) ) )
          FAILED DATA(it_failed)
          MAPPED DATA(it_mapped)
          REPORTED DATA(it_reported).

    ENDLOOP.

  ENDMETHOD. " create_items

  METHOD calc_on_action.

   "read items
    READ ENTITIES OF zc_simple_009
      ENTITY Simple BY \_Item ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and clear Data6
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
        <entity>-Data6 = <entity>-Data4 * <entity>-Data5.
    ENDLOOP.

   "update transfered items
    MODIFY ENTITIES OF zc_simple_009
      ENTITY Item
        UPDATE FIELDS ( Data6 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
                           %tky     = entity-%tky
                           Data6    = entity-Data6
                        ) ).

  ENDMETHOD. " calc_on_action

  METHOD calc_on_modify.
   "read transfered instances
    READ ENTITIES OF zc_simple_009 " IN LOCAL MODE
      ENTITY Simple
        FIELDS ( Data1 Data2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and set Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
        <entity>-Data3 = <entity>-Data1 + <entity>-Data2.
    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF zc_simple_009 "IN LOCAL MODE
      ENTITY Simple
        UPDATE FIELDS ( Data3 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
                           %tky     = entity-%tky
                           Data3    = entity-Data3
                    ) ).

  ENDMETHOD. " calc_on_modify
ENDCLASS. " lhc_simple IMPLEMENTATION

CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR item RESULT result.

    METHODS test3 FOR MODIFY
      IMPORTING keys FOR ACTION item~test3.

    METHODS test4 FOR MODIFY
      IMPORTING keys FOR ACTION item~test4.

    METHODS calc_on_modify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR item~calc_on_modify.

ENDCLASS. " lhc_item DEFINITION

CLASS lhc_item IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD. "get_instance_authorizations

  METHOD test3.
    LOOP AT keys INTO DATA(key).
        APPEND VALUE #( %key = key-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Hello, Test3!' ) ) TO reported-item.
    ENDLOOP.
  ENDMETHOD. " test3

  METHOD test4.
    LOOP AT keys INTO DATA(key).
        APPEND VALUE #( %key = key-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Hello, Test4!' ) ) TO reported-item.
    ENDLOOP.
  ENDMETHOD. " test4

  METHOD calc_on_modify.

   "read transfered instances
    READ ENTITIES OF zc_simple_009
      ENTITY Item ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and set Data6
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
        <entity>-Data6 = <entity>-Data4 + <entity>-Data5.
    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF zc_simple_009
      ENTITY Item UPDATE FIELDS ( Data6 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
                           %tky     = entity-%tky
                           Data6    = entity-Data6
                    ) ).

  ENDMETHOD. " calc_on_modify

ENDCLASS. " lhc_item IMPLEMENTATION

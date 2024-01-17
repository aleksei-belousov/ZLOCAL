CLASS lsc_zi_simple_005 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS. " lsc_zi_simple_005 DEFINITION

CLASS lsc_zi_simple_005 IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

ENDCLASS. " lsc_zi_simple_005 IMPLEMENTATION

CLASS lhc_simple_005 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR simple_005 RESULT result.

    METHODS calculate_on_action FOR MODIFY IMPORTING keys FOR ACTION Simple_005~calculate_on_action.

    METHODS calculate_on_modify FOR DETERMINE ON MODIFY IMPORTING keys FOR Simple_005~calculate_on_modify.

    METHODS new_message_with_text_action FOR MODIFY IMPORTING keys FOR ACTION Simple_005~new_message_with_text_action.

    METHODS test_po FOR MODIFY IMPORTING keys FOR ACTION Simple_005~test_po.

ENDCLASS. " lhc_simple_005 DEFINITION

CLASS lhc_simple_005 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calculate_on_action.

   "read transfered instances
    READ ENTITIES OF zi_simple_005 IN LOCAL MODE
      ENTITY Simple_005
        FIELDS ( Data1 Data2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and clear Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
*        <entity>-Data1 = '2'.
*        <entity>-Data2 = '2'.
        <entity>-Data3 = <entity>-Data1 * <entity>-Data2.
        CONDENSE <entity>-Data3 NO-GAPS.
        DATA(text1) = 'Multiplying Into'.
        DATA(text2) = CONV string( <entity>-Data3 ).
        CONCATENATE text1 text2 INTO DATA(text) SEPARATED BY space.
        APPEND VALUE #( %key = <entity>-%key %msg = new_message_with_text( severity = ms-success text = text ) ) TO reported-simple_005.
    ENDLOOP.

   "update transfered instances
    MODIFY ENTITIES OF zi_simple_005 IN LOCAL MODE
      ENTITY Simple_005
        UPDATE FIELDS ( Data3 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
           %tky     = entity-%tky
           Data3    = entity-Data3
        ) ).
  ENDMETHOD. " calculate_on_action

  METHOD calculate_on_modify.

   "read transfered instances
    READ ENTITIES OF zi_simple_005 IN LOCAL MODE
      ENTITY Simple_005
      FIELDS ( Data1 Data2 )
      WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and set Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
        <entity>-Data3 = <entity>-Data1 + <entity>-Data2.
        CONDENSE <entity>-Data3 NO-GAPS.
        DATA(text1) = 'Adding Into'.
        DATA(text2) = CONV string( <entity>-Data3 ).
        CONCATENATE text1 text2 INTO DATA(text) SEPARATED BY space.
        APPEND VALUE #( %key = <entity>-%key %msg = new_message_with_text( severity = ms-success text = text ) ) TO reported-simple_005.
    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF zi_simple_005 IN LOCAL MODE
      ENTITY Simple_005
      UPDATE FIELDS ( Data3 )
      WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky     = entity-%tky
        Data3    = entity-Data3
      ) ).


  ENDMETHOD. " calculate_on_modify

  METHOD new_message_with_text_action.
    LOOP AT keys INTO DATA(key).
        APPEND VALUE #( %key = key-%key %msg = new_message_with_text( severity = ms-success text = 'Hello, World!!!' ) ) TO reported-simple_005.
    ENDLOOP.
  ENDMETHOD. " new_message_with_text_action

* Test Purchase Order
  METHOD test_po.

   "read transfered instances
    READ ENTITIES OF zi_simple_005 IN LOCAL MODE
      ENTITY Simple_005
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

*       Read PO (Item)
        READ ENTITIES OF I_PurchaseOrderTP_2
            ENTITY PurchaseOrder BY \_PurchaseOrderItem
            ALL FIELDS WITH VALUE #( (
                %tky-PurchaseOrder  = '4500000002'
            ) )
            RESULT DATA(lt_purchaseorderitem)
            FAILED DATA(failed1)
            REPORTED DATA(reported1).

*      Update PO (Item)
       MODIFY ENTITIES OF I_PurchaseOrderTP_2
            ENTITY PurchaseOrderItem
            UPDATE FIELDS (
                PurchaseContract
                PurchaseContractItem
            )
            WITH VALUE #( (
                %tky-PurchaseOrder      = '4500000002'
                %tky-PurchaseOrderItem  = '10'
                PurchaseContract        = '4600000000'
                PurchaseContractItem    = '10'
            ) )
            MAPPED DATA(mapped2)
            FAILED DATA(failed2)
            REPORTED DATA(reported2).

    ENDLOOP.

  ENDMETHOD. " test_po

ENDCLASS. " lhc_simple_005 IMPLEMENTATION

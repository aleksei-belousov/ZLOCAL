CLASS lhc_size DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR Size RESULT result.

    METHODS create_sizes FOR MODIFY IMPORTING keys FOR ACTION Size~create_sizes.

ENDCLASS.

CLASS lhc_size IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create_sizes.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR Item RESULT result.

    METHODS create_items FOR MODIFY IMPORTING keys FOR ACTION Item~create_items.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create_items.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_matrix DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR matrix RESULT result.

    METHODS create_items FOR MODIFY IMPORTING keys FOR ACTION matrix~create_items.

    METHODS create_sales_order FOR MODIFY IMPORTING keys FOR ACTION matrix~create_sales_order.

    METHODS get_instance_features FOR INSTANCE FEATURES IMPORTING keys REQUEST requested_features FOR matrix RESULT result.

    METHODS test1 FOR MODIFY IMPORTING keys FOR ACTION matrix~test1 RESULT result.

ENDCLASS.

CLASS lhc_matrix IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

* Create Items
  METHOD create_items.

*   Read Matrix row
    READ ENTITIES OF zi_matrix_003 IN LOCAL MODE
      ENTITY Matrix
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(it_matrix)
      FAILED failed
      REPORTED reported.

    READ TABLE it_matrix INTO DATA(wa_matrix) INDEX 1.

*   Read Size table
    SELECT * FROM zsize_003 WHERE ( MatrixID = @wa_matrix-MatrixID ) INTO TABLE @DATA(it_size).

*   Sort By BackSize
    SORT it_size STABLE BY Back.

*   Convert it_matrix into it_item:
    DATA it_item TYPE TABLE OF zitem_003.
    DATA wa_item TYPE zitem_003.

    LOOP AT it_size INTO DATA(wa_size).
        IF ( wa_size-a IS NOT INITIAL ).
            wa_item-Cupsize     = 'A'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-a.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-b IS NOT INITIAL ).
            wa_item-Cupsize     = 'B'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-b.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-c IS NOT INITIAL ).
            wa_item-Cupsize     = 'C'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-c.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-d IS NOT INITIAL ).
            wa_item-Cupsize     = 'D'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-d.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-e IS NOT INITIAL ).
            wa_item-Cupsize     = 'E'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-e.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-f IS NOT INITIAL ).
            wa_item-Cupsize     = 'F'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-f.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-g IS NOT INITIAL ).
            wa_item-Cupsize     = 'G'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-g.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-h IS NOT INITIAL ).
            wa_item-Cupsize     = 'H'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-h.
            APPEND wa_item TO it_item.
        ENDIF.
        IF ( wa_size-i IS NOT INITIAL ).
            wa_item-Cupsize     = 'I'.
            wa_item-Backsize    = wa_size-Back.
            wa_item-Quantity    = wa_size-i.
            APPEND wa_item TO it_item.
        ENDIF.
    ENDLOOP.

*   Max item id
    DATA itemid TYPE zi_item_003-ItemID VALUE '000000'.
    SELECT MAX( ItemID ) FROM zi_item_003 WHERE ( MatrixID = @wa_matrix-MatrixID ) INTO (@itemid).

*   Populate the remaining values
    LOOP AT it_item INTO wa_item.
        itemid = itemid + 1.
        wa_item-MatrixID    = wa_matrix-MatrixID.
        wa_item-ItemID      = itemid.
        wa_item-Model       = wa_matrix-Model.
        wa_item-Color       = wa_matrix-Color.
        wa_item-Product     = wa_item-Model && '-' && wa_item-Color && '-' && wa_item-Cupsize && '-' &&  wa_item-Backsize.
        MODIFY it_item FROM wa_item INDEX sy-tabix.
    ENDLOOP.

    MODIFY zitem_003 FROM TABLE @it_item.

*   Clear it_size
    LOOP AT it_size INTO wa_size.
        wa_size-a    = ''.
        wa_size-b    = ''.
        wa_size-c    = ''.
        wa_size-d    = ''.
        wa_size-e    = ''.
        wa_size-f    = ''.
        wa_size-g    = ''.
        wa_size-h    = ''.
        wa_size-i    = ''.
        MODIFY it_size FROM wa_size INDEX sy-tabix.
    ENDLOOP.
    MODIFY zsize_003 FROM TABLE @it_size.

  ENDMETHOD. " create_items

  METHOD create_sales_order.

*   Make Sales Order (Header)
    DATA it_salesorder TYPE TABLE FOR CREATE i_salesordertp. " Sales Order

    it_salesorder = VALUE #(
        (
            %cid = 'root'
            %data = VALUE #(
                salesordertype          = 'TA'
                salesorganization       = '1010'
                distributionchannel     = '10'
                organizationdivision    = '00'
                soldtoparty             = '0010100014'
            )
        )
    ).

*   Read Matrix Items
    READ ENTITIES OF zi_matrix_003 IN LOCAL MODE
        ENTITY Matrix BY \_Item
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(it_matrix_item)
        FAILED failed
        REPORTED reported.

*   SORT
    SORT it_matrix_item STABLE BY ItemID.

*   Make Sales Order Items
    DATA it_salesorder_item TYPE TABLE FOR CREATE i_salesordertp\_Item.  " Item
    DATA wa_salesorder_item LIKE LINE OF it_salesorder_item.
    DATA cid TYPE string.
    LOOP AT it_matrix_item INTO DATA(wa_matrix_item).
        cid = CONV string( sy-tabix ).
        APPEND VALUE #(
            %cid_ref = 'root'
            SalesOrder = space
            %target = VALUE #( (
                %cid                = cid
                Product             = wa_matrix_item-Product
                RequestedQuantity   = wa_matrix_item-Quantity
*                SalesOrderItemText  = wa_matrix_item-Product
            ) )
        ) TO it_salesorder_item.
    ENDLOOP.

*   Create Sales Order
    MODIFY ENTITIES OF i_salesordertp
        ENTITY salesorder
        CREATE FIELDS (
            salesordertype
            salesorganization
            distributionchannel
            organizationdivision
            soldtoparty
        )
        WITH it_salesorder
        CREATE BY \_item
        FIELDS (
            Product
            RequestedQuantity
*            SalesOrderItemText
        )
        WITH it_salesorder_item
        MAPPED DATA(ls_mapped)
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

*   Read Sales Order
    READ ENTITIES OF i_salesordertp
        ENTITY salesorder
        FROM VALUE #( ( salesorder = space ) )
        RESULT DATA(lt_so_head)
        REPORTED DATA(ls_reported_read).

  ENDMETHOD. " create_sales_order

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD test1.
  ENDMETHOD.

ENDCLASS. " INHERITING FROM cl_abap_behavior_handler

CLASS lsc_zi_matrix_003 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_matrix_003 IMPLEMENTATION.

  METHOD save_modified. " on Save

    DATA wa_zmatrix_003 TYPE zmatrix_003.
    DATA wa_change_matrix LIKE LINE OF create-matrix.
    DATA wa_delete_matrix LIKE LINE OF delete-matrix.

    DATA wa_change_size LIKE LINE OF create-size.

*   Create
    LOOP AT create-matrix INTO wa_change_matrix.

*       Max matrix id value
*        DATA matrixid TYPE zi_matrix_003-MatrixID VALUE '0000000000'.
*        SELECT MAX( matrixid ) FROM zi_matrix_003 INTO (@matrixid).
*        wa_change_matrix-MatrixID = ( matrixid + 1 ).
        FINAL(text) = |{ '1234' ALPHA = IN WIDTH = 10 }|.
*       Enter matrixid manually

        MOVE-CORRESPONDING wa_change_matrix TO wa_zmatrix_003.
        wa_zmatrix_003-matrixid = wa_change_matrix-MatrixID.
        MODIFY zmatrix_003 FROM @wa_zmatrix_003.

*       Adjust Size:

*       Delete the size table
        DELETE FROM zsize_003 WHERE ( matrixid = @wa_zmatrix_003-matrixid ).

*       Populate the size table (field Back only)
        DATA it_size TYPE TABLE OF zsize_003.
        DATA wa_size TYPE zsize_003.

        CLEAR it_size.

        CLEAR wa_size.
        wa_size-Back = '060'.
        APPEND wa_size TO it_size.

        CLEAR wa_size.
        wa_size-Back = '065'.
        APPEND wa_size TO it_size.

        CLEAR wa_size.
        wa_size-Back = '070'.
        APPEND wa_size TO it_size.

        CLEAR wa_size.
        wa_size-Back = '075'.
        APPEND wa_size TO it_size.

        CLEAR wa_size.
        wa_size-Back = '080'.
        APPEND wa_size TO it_size.

        CLEAR wa_size.
        wa_size-Back = '085'.
        APPEND wa_size TO it_size.

        CLEAR wa_size.
        wa_size-Back = '090'.
        APPEND wa_size TO it_size.

        LOOP AT it_size INTO wa_size.
            wa_size-sizeid    = sy-tabix. " primary key
            wa_size-matrixid  = wa_change_matrix-MatrixID.
            MODIFY zsize_003 FROM @wa_size.
        ENDLOOP.

    ENDLOOP.

*   Update
    LOOP AT update-matrix INTO wa_change_matrix.
        IF ( wa_change_matrix-%control-MatrixID = flag_changed ). " change of MatrixId is forbidden
            CONTINUE. " ignore
        ENDIF.
        SELECT SINGLE * FROM zmatrix_003 WHERE ( matrixid = @wa_change_matrix-MatrixID ) INTO @wa_zmatrix_003.
        IF ( sy-subrc = 0 ).
            "MOVE-CORRESPONDING wa_change_matrix TO wa_zmatrix_003.
*            IF ( wa_change_matrix-%control-MatrixID = flag_changed ).
*                wa_zmatrix_003-matrixid = wa_change_matrix-MatrixID.
*            ENDIF.
            IF ( wa_change_matrix-%control-Model = flag_changed ).
                wa_zmatrix_003-model = wa_change_matrix-Model.
            ENDIF.
            IF ( wa_change_matrix-%control-Color = flag_changed ).
                wa_zmatrix_003-color = wa_change_matrix-Color.
            ENDIF.
            MODIFY zmatrix_003 FROM @wa_zmatrix_003.

        ENDIF.
    ENDLOOP.

*   Delete
    LOOP AT delete-matrix INTO wa_delete_matrix.
        MOVE-CORRESPONDING wa_delete_matrix TO wa_zmatrix_003.
        DELETE zmatrix_003 FROM @wa_zmatrix_003.
    ENDLOOP.

*   Update Sizes
    LOOP AT update-size INTO wa_change_size.

*       Read Matrix table
        SELECT SINGLE * FROM zmatrix_003 WHERE ( MatrixID = @wa_change_size-MatrixID ) INTO @wa_zmatrix_003.

*       Read Size table
        SELECT * FROM zsize_003 WHERE ( MatrixID = @wa_change_size-MatrixID ) INTO TABLE @it_size.

*       Sort By BackSize
        SORT it_size STABLE BY Back.

*       Convert it_matrix into it_item:
        DATA it_item TYPE TABLE OF zitem_003.
        DATA wa_item TYPE zitem_003.

        LOOP AT it_size INTO wa_size.
            IF ( wa_size-a IS NOT INITIAL ).
                wa_item-Cupsize     = 'A'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-a.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-b IS NOT INITIAL ).
                wa_item-Cupsize     = 'B'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-b.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-c IS NOT INITIAL ).
                wa_item-Cupsize     = 'C'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-c.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-d IS NOT INITIAL ).
                wa_item-Cupsize     = 'D'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-d.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-e IS NOT INITIAL ).
                wa_item-Cupsize     = 'E'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-e.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-f IS NOT INITIAL ).
                wa_item-Cupsize     = 'F'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-f.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-g IS NOT INITIAL ).
                wa_item-Cupsize     = 'G'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-g.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-h IS NOT INITIAL ).
                wa_item-Cupsize     = 'H'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-h.
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-i IS NOT INITIAL ).
                wa_item-Cupsize     = 'I'.
                wa_item-Backsize    = wa_size-Back.
                wa_item-Quantity    = wa_size-i.
                APPEND wa_item TO it_item.
            ENDIF.
        ENDLOOP.

*       Max item id
        DATA itemid TYPE zi_item_003-ItemID VALUE '000000'.
        SELECT MAX( ItemID ) FROM zi_item_003 WHERE ( MatrixID = @wa_change_size-MatrixID ) INTO (@itemid).

*       Populate the remaining values
        LOOP AT it_item INTO wa_item.
            itemid = itemid + 1.
            wa_item-MatrixID    = wa_change_size-MatrixID.
            wa_item-ItemID      = itemid.
            wa_item-Model       = wa_zmatrix_003-Model.
            wa_item-Color       = wa_zmatrix_003-Color.
            wa_item-Product     = wa_item-Model && '-' && wa_item-Color && '-' && wa_item-Cupsize && '-' &&  wa_item-Backsize.
            MODIFY it_item FROM wa_item INDEX sy-tabix.
        ENDLOOP.

        MODIFY zitem_003 FROM TABLE @it_item.

*       Clear it_size
        DELETE FROM zsize_003.

*       Fix
*        DELETE FROM zitem_003 WHERE ( itemid IS INITIAL ).

        EXIT.
    ENDLOOP.

  ENDMETHOD. " save_modified

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS. " INHERITING FROM cl_abap_behavior_saver

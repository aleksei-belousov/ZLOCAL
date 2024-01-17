CLASS lhc_zbp_i_matrix_entry DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR matrix RESULT result.

    METHODS create_items FOR MODIFY
      IMPORTING keys FOR ACTION matrix~create_items.

    METHODS create_sales_order FOR MODIFY
      IMPORTING keys FOR ACTION matrix~create_sales_order.

    METHODS adjust_size FOR MODIFY
      IMPORTING keys FOR ACTION matrix~adjust_size.




ENDCLASS.

CLASS lhc_zbp_i_matrix_entry  IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD adjust_size.

    READ ENTITIES OF zi_matrix_entry IN LOCAL MODE
      ENTITY Matrix
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(it_matrix)
      FAILED failed
      REPORTED reported.

    READ TABLE it_matrix INTO DATA(wah_matrix) INDEX 1.

    DELETE FROM zmatrix_size WHERE ( order_uuid = @wah_matrix-Order_Uuid ).


    DATA it_size TYPE TABLE OF zi_matrix_size.
    DATA wah_size TYPE zi_matrix_size.

    CLEAR it_size.

    CLEAR wah_size.
    wah_size-Back = '060'.
    APPEND wah_size TO it_size.

    CLEAR wah_size.
    wah_size-Back = '065'.
    APPEND wah_size TO it_size.

    CLEAR wah_size.
    wah_size-Back = '070'.
    APPEND wah_size TO it_size.

    CLEAR wah_size.
    wah_size-Back = '075'.
    APPEND wah_size TO it_size.

    CLEAR wah_size.
    wah_size-Back = '080'.
    APPEND wah_size TO it_size.

    CLEAR wah_size.
    wah_size-Back = '085'.
    APPEND wah_size TO it_size.

    CLEAR wah_size.
    wah_size-Back = '090'.
    APPEND wah_size TO it_size.


    LOOP AT it_size INTO wah_size.
        wah_size-OrderUuid  = wah_matrix-Order_Uuid.
        MODIFY it_size FROM wah_size INDEX sy-tabix.
    ENDLOOP.

    LOOP AT it_size INTO wah_size.
        MODIFY ENTITY IN LOCAL MODE zi_matrix_entry
            CREATE BY \_Size AUTO FILL CID
            FIELDS  ( Back )
            WITH VALUE #(
                ( Order_Uuid = wah_matrix-Order_Uuid %target = VALUE #( (
                    Back = wah_size-Back
                ) ) )
            )
            MAPPED FINAL(mapped_auto_cid_child).
    ENDLOOP.

  ENDMETHOD.


  METHOD create_items.

    READ ENTITIES OF zi_matrix_entry IN LOCAL MODE
      ENTITY Matrix
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(it_matrix)
      FAILED failed
      REPORTED reported.

    READ TABLE it_matrix INTO DATA(wah_matrix) INDEX 1.

    SELECT * FROM zi_matrix_size WHERE ( OrderUuid = @wah_matrix-Order_Uuid ) INTO TABLE @DATA(it_size).

    SORT it_size STABLE BY Back.

    DATA it_item TYPE TABLE OF zi_matrix_table.
    DATA wah_item TYPE zi_matrix_table.

  LOOP AT it_size INTO DATA(wah_size).
    IF ( wah_size-a IS NOT INITIAL ).
        wah_item-Cupsize     = 'A'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-a.
        APPEND wah_item TO it_item.
    ENDIF.
    IF ( wah_size-b IS NOT INITIAL ).
        wah_item-Cupsize     = 'B'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-b.
        APPEND wah_item TO it_item.
    ENDIF.
    IF ( wah_size-c IS NOT INITIAL ).
        wah_item-Cupsize     = 'C'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-c.
        APPEND wah_item TO it_item.
    ENDIF.
    IF ( wah_size-d IS NOT INITIAL ).
        wah_item-Cupsize     = 'D'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-d.
        APPEND wah_item TO it_item.
    ENDIF.

    IF ( wah_size-e IS NOT INITIAL ).
        wah_item-Cupsize     = 'E'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-e.
        APPEND wah_item TO it_item.
    ENDIF.
    IF ( wah_size-f IS NOT INITIAL ).
        wah_item-Cupsize     = 'F'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-f.
        APPEND wah_item TO it_item.
    ENDIF.
    IF ( wah_size-g IS NOT INITIAL ).
        wah_item-Cupsize     = 'G'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-g.
        APPEND wah_item TO it_item.
    ENDIF.
    IF ( wah_size-h IS NOT INITIAL ).
        wah_item-Cupsize     = 'H'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-h.
        APPEND wah_item TO it_item.
    ENDIF.

    IF ( wah_size-i IS NOT INITIAL ).
        wah_item-Cupsize     = 'I'.
        wah_item-Backsize    = wah_size-Back.
        wah_item-Quantity    = wah_size-i.
        APPEND wah_item TO it_item.
    ENDIF.
  ENDLOOP.


    DATA itemid TYPE zi_matrix_table-Matrix_Id VALUE '000000'.
    SELECT MAX( Matrix_Id ) FROM zi_matrix_table WHERE ( OrderUuid = @wah_matrix-Order_Uuid ) INTO (@itemid).

    LOOP AT it_item INTO wah_item.
        itemid = itemid + 1.
        wah_item-OrderUuid  = wah_matrix-Order_Uuid.
        wah_item-Order_Id   = wah_matrix-Order_Id.
        wah_item-Matrix_Id  = itemid.
        wah_item-ModelNo    = wah_matrix-ModelNo.
        wah_item-ColorNo    = wah_matrix-ColorNo.
        wah_item-Product    = wah_item-ModelNo && '-' && wah_item-ColorNo && '-' && wah_item-Cupsize && '-' && wah_item-Backsize.
        MODIFY it_item FROM wah_item INDEX sy-tabix.
    ENDLOOP.

    LOOP AT it_item INTO wah_item.
        MODIFY ENTITY IN LOCAL MODE zi_matrix_entry
            CREATE BY \_Table AUTO FILL CID
            FIELDS  ( Order_Id Matrix_Id ModelNo ColorNo Cupsize Backsize Product Quantity )
            WITH VALUE #(
                ( Order_UUID = wah_matrix-Order_Uuid %target = VALUE #( (
                    Order_Id   = wah_item-Order_Id
                    Matrix_Id   = wah_item-Matrix_Id
                    ModelNo     = wah_item-ModelNo
                    ColorNo     = wah_item-ColorNo
                    Cupsize     = wah_item-Cupsize
                    Backsize    = wah_item-Backsize
                    Product     = wah_item-Product
                    Quantity    = wah_item-Quantity ) ) )
            )
            MAPPED FINAL(mapped_auto_cid_child).
    ENDLOOP.

  ENDMETHOD.


 METHOD create_sales_order.

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


    READ ENTITIES OF zi_matrix_entry IN LOCAL MODE
        ENTITY Matrix BY \_Table
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(it_table)
        FAILED failed
        REPORTED reported.


    SORT it_table STABLE BY Matrix_Id.

    DATA it_salesorder_item TYPE TABLE FOR CREATE i_salesordertp\_Item.
    DATA wa_salesorder_item LIKE LINE OF it_salesorder_item.
    DATA cid TYPE string.
    LOOP AT it_table INTO DATA(wah_matrix_table).
        cid = CONV string( sy-tabix ).
        APPEND VALUE #(
            %cid_ref = 'root'
            SalesOrder = space
            %target = VALUE #( (
                %cid                = cid
                Product             = wah_matrix_table-Product
                RequestedQuantity   = wah_matrix_table-Quantity
*                SalesOrderItemText  = wah_matrix_table-Product
             ) )
          ) TO it_salesorder_item.
    ENDLOOP.


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
*   SalesOrderItemText
  )
  WITH it_salesorder_item
  MAPPED DATA(ls_mapped)
  FAILED DATA(ls_failed)
  REPORTED DATA(ls_reported).

    READ ENTITIES OF i_salesordertp
        ENTITY salesorder
        FROM VALUE #( ( salesorder = space ) )
        RESULT DATA(lt_so_head)
        REPORTED DATA(ls_reported_read).

  ENDMETHOD.

ENDCLASS.


CLASS lsc_zbp_i_matrix_entry DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zbp_i_matrix_entry IMPLEMENTATION.

  METHOD save_modified. " on Save

*   Create work area data table and makes temporary tables for each CRUD operation
    DATA wah_zmatrix_entry TYPE zmatrixentry.
    DATA wah_zmatrix_size  TYPE zmatrix_size.
    DATA wah_change_matrix LIKE LINE OF create-matrix.
    DATA wah_update_matrix LIKE LINE OF update-matrix.
    DATA wah_delete_matrix LIKE LINE OF delete-matrix.


*   Creates matrix
    LOOP AT create-matrix INTO wah_change_matrix.
        MOVE-CORRESPONDING wah_change_matrix TO wah_zmatrix_entry.
        MODIFY zmatrixentry FROM @wah_zmatrix_entry.

*       Deletes table sizes
        DELETE FROM zmatrix_size WHERE ( order_uuid = @wah_change_matrix-Order_Uuid ).


*       Pre-populates size table with size values (Back only)
        DATA it_size  TYPE TABLE OF zmatrix_size.
        DATA wah_size TYPE zmatrix_size.

        CLEAR it_size.


        CLEAR wah_size.
        wah_size-Back = '060'.
        APPEND wah_size TO it_size.

        CLEAR wah_size.
        wah_size-Back = '065'.
        APPEND wah_size TO it_size.

        CLEAR wah_size.
        wah_size-Back = '070'.
        APPEND wah_size TO it_size.

        CLEAR wah_size.
        wah_size-Back = '075'.
        APPEND wah_size TO it_size.

        CLEAR wah_size.
        wah_size-Back = '080'.
        APPEND wah_size TO it_size.

        CLEAR wah_size.
        wah_size-Back = '085'.
        APPEND wah_size TO it_size.

        CLEAR wah_size.
        wah_size-Back = '090'.
        APPEND wah_size TO it_size.


        LOOP AT it_size INTO wah_size.
            wah_size-sizeuuid = sy-tabix.
            wah_size-order_uuid = wah_change_matrix-Order_Uuid.
            MODIFY zmatrix_size FROM @wah_size.
        ENDLOOP.

     ENDLOOP.


*    Updates matrix
     LOOP AT update-matrix INTO wah_change_matrix.
        IF ( wah_change_matrix-%control-Order_Uuid = flag_changed ).
            CONTINUE.
        ENDIF.
        SELECT SINGLE * FROM zmatrixentry WHERE ( order_uuid = @wah_change_matrix-Order_Uuid ) INTO @wah_zmatrix_entry.
        IF ( sy-subrc = 0 ).
            IF ( wah_change_matrix-%control-Modelno = flag_changed ).
                wah_zmatrix_entry-modelno = wah_change_matrix-Modelno.
            ENDIF.
            IF ( wah_change_matrix-%control-Colorno = flag_changed ).
                wah_zmatrix_entry-colorno = wah_change_matrix-Colorno.
            ENDIF.
            MODIFY zmatrixentry FROM @wah_zmatrix_entry.
        ENDIF.

        SELECT SINGLE * FROM zmatrix_size WHERE ( order_uuid = @wah_change_matrix-Order_Uuid ) INTO @wah_zmatrix_size.
        IF ( sy-subrc = 0 ).
            MODIFY zmatrix_size FROM @wah_zmatrix_size.
        ENDIF.
     ENDLOOP.


*    Deletes matrix
     LOOP AT delete-matrix INTO wah_delete_matrix.
        MOVE-CORRESPONDING wah_delete_matrix TO wah_zmatrix_entry.
        DELETE zmatrixentry FROM @wah_zmatrix_entry.
     ENDLOOP.

  ENDMETHOD.





  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS. " INHERITING FROM cl_abap_behavior_saver

CLASS lhc_matrix DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR matrix RESULT result.

    METHODS create_items FOR MODIFY IMPORTING keys FOR ACTION matrix~create_items.

    METHODS create_sales_order FOR MODIFY IMPORTING keys FOR ACTION matrix~create_sales_order.

    METHODS get_sales_order FOR MODIFY IMPORTING keys FOR ACTION matrix~get_sales_order.

    METHODS after_modify FOR DETERMINE ON MODIFY IMPORTING keys FOR matrix~after_modify.

ENDCLASS. " lhc_matrix DEFINITION

CLASS lhc_matrix IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create_sales_order.

    DATA it_salesorder TYPE TABLE FOR CREATE i_salesordertp. " Sales Order
    DATA it_salesorder_item TYPE TABLE FOR CREATE i_salesordertp\_Item.  " Item
    DATA wa_salesorder_item LIKE LINE OF it_salesorder_item.
    DATA it_matrix TYPE TABLE FOR UPDATE zi_matrix_004. " Matrix
    DATA cid TYPE string.

    READ TABLE keys INTO DATA(key) INDEX 1.
    IF ( sy-subrc <> 0 ).
        RETURN.
    ENDIF.
    SELECT SINGLE * FROM zc_matrix_004 WHERE ( MatrixUUID = @key-MatrixUUID ) INTO @DATA(wa_matrix_004).

    IF ( wa_matrix_004-SalesOrderID IS NOT INITIAL ).
        APPEND VALUE #( %key = key-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = 'Sales Order already exists.' ) ) TO reported-matrix.
        RETURN.
    ENDIF.

*   Make Sales Order (Header)
    it_salesorder = VALUE #(
        (
            %cid = 'root'
            %data = VALUE #(
                salesordertype          = wa_matrix_004-SalesOrderType          " 'TA'
                salesorganization       = wa_matrix_004-SalesOrganization       " '1010'
                distributionchannel     = wa_matrix_004-DistributionChannel     " '10'
                organizationdivision    = wa_matrix_004-OrganizationDivision    " '00'
                soldtoparty             = wa_matrix_004-SoldToParty             " '0010100014'
            )
        )
    ).

*   Read Matrix Items
    READ ENTITIES OF zi_matrix_004 IN LOCAL MODE
        ENTITY Matrix BY \_Item
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(it_matrix_item)
        FAILED failed
        REPORTED reported.

*   SORT
    SORT it_matrix_item STABLE BY ItemID.

*   Make Sales Order Items
    LOOP AT it_matrix_item INTO DATA(wa_matrix_item).
        cid = CONV string( sy-tabix ).
        APPEND VALUE #(
            %cid_ref = 'root'
            SalesOrder = space
            %target = VALUE #( (
                %cid                = cid
                Product             = wa_matrix_item-Product
                RequestedQuantity   = wa_matrix_item-Quantity
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

*   Update Matrix (root)
    READ TABLE lt_so_head INTO DATA(ls_so_head) INDEX 1.
    IF ( sy-subrc = 0 ).
        it_matrix = VALUE #( (
            %tky                    = key-%tky
            CreationDate            = ls_so_head-CreationDate
            CreationTime            = ls_so_head-CreationTime
         ) ).
        MODIFY ENTITIES OF zi_matrix_004 IN LOCAL MODE
            ENTITY Matrix
            UPDATE FIELDS ( CreationDate CreationTime )
            WITH it_matrix
            FAILED failed
            MAPPED mapped
            REPORTED reported.

       DATA(a) = 0.

    ENDIF.

  ENDMETHOD. " create_sales_order

  METHOD get_sales_order.

    READ TABLE keys INTO DATA(key) INDEX 1.
    IF ( sy-subrc <> 0 ).
        RETURN.
    ENDIF.
    SELECT SINGLE * FROM zc_matrix_004 WHERE ( MatrixUUID = @key-MatrixUUID ) INTO @DATA(wa_matrix_004).
    IF ( sy-subrc <> 0 ).
        RETURN.
    ENDIF.
    SELECT SINGLE
            *
        FROM
            i_salesordertp
        WHERE
            ( CreationDate = @wa_matrix_004-CreationDate ) AND
            ( CreationTime = @wa_matrix_004-CreationTime )
        INTO
            @DATA(wa_i_salesordertp).
    IF ( sy-subrc = 0 ).
        DATA wa_zmatrix_004 TYPE zmatrix_004.
        SELECT SINGLE * FROM zmatrix_004 WHERE ( matrixuuid = @wa_matrix_004-MatrixUUID ) INTO @wa_zmatrix_004.
        IF ( sy-subrc = 0 ).
            wa_zmatrix_004-salesorderid = wa_i_salesordertp-SalesOrder.
            MODIFY zmatrix_004 FROM @wa_zmatrix_004.
        ENDIF.

    ENDIF.

  ENDMETHOD. " get_sales_order

  METHOD create_items.

    DATA it_item TYPE TABLE FOR CREATE zi_matrix_004\_Item. " Item
    DATA wa_item LIKE LINE OF it_item.
    DATA cid TYPE string.
    DATA model      TYPE string.
    DATA color      TYPE string.
    DATA cupsize    TYPE string.
    DATA backsize   TYPE string.
    DATA product    TYPE string.
    DATA quantity   TYPE string.

    LOOP AT keys INTO DATA(key).

*       Read the whole Matrix (root)
        SELECT SINGLE * FROM zc_matrix_004 WHERE ( MatrixUUID = @key-MatrixUUID ) INTO @DATA(wa_matrix).

*       Read the whole Size table
        SELECT * FROM zc_size_004 WHERE ( MatrixUUID = @key-MatrixUUID ) ORDER By back INTO TABLE @DATA(it_size).

*       Find max item id
        SELECT MAX( ItemID ) FROM zc_item_004 WHERE ( MatrixUUID = @key-MatrixUUID ) INTO @DATA(maxid).

        model       = wa_matrix-Model.
        color       = wa_matrix-Color.

*       Add New Items based on actual Size table
        LOOP AT it_size INTO DATA(wa_size).
            IF ( wa_size-a IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'A'.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                quantity    = wa_size-a.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-b IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'B'.
                quantity    = wa_size-b.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-c IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'C'.
                quantity    = wa_size-c.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-d IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'D'.
                quantity    = wa_size-d.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-e IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'E'.
                quantity    = wa_size-e.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-f IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'F'.
                quantity    = wa_size-f.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-g IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'G'.
                quantity    = wa_size-g.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-h IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'H'.
                quantity    = wa_size-h.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.
            IF ( wa_size-i IS NOT INITIAL ).
                maxid = maxid + 1.
                cid = maxid.
                backsize    = wa_size-Back.
                cupsize     = 'I'.
                quantity    = wa_size-i.
                product     = model && '-' && color && '-' && cupsize && '-' && backsize.
                wa_item = VALUE #(
                    MatrixUUID = key-MatrixUUID
                    %target = VALUE #( (
                        %cid            = cid
                        ItemID          = cid
                        MatrixUUID      = wa_matrix-MatrixUUID
                        Cupsize         = cupsize
                        Backsize        = backsize
                        Quantity        = quantity
                        Model           = model
                        Color           = color
                        Product         = product
                    ) )
                ).
                APPEND wa_item TO it_item.
            ENDIF.

            "create a new item for the simple
            MODIFY ENTITY IN LOCAL MODE zi_matrix_004
              CREATE BY \_Item AUTO FILL CID
              FIELDS ( ItemID MatrixUUID Model Color Backsize Cupsize Product Quantity )
              WITH it_item
              FAILED DATA(it_failed)
              MAPPED DATA(it_mapped)
              REPORTED DATA(it_reported).

        ENDLOOP.

    ENDLOOP.

*   Clear it_size
*    LOOP AT it_size INTO wa_size.
*        wa_size-a = ''.
*        wa_size-b = ''.
*        wa_size-c = ''.
*        wa_size-d = ''.
*        wa_size-e = ''.
*        wa_size-f = ''.
*        wa_size-h = ''.
*        wa_size-i = ''.
*        MODIFY it_size FROM wa_size INDEX sy-tabix.
*    ENDLOOP.

    " Finally, do refresh (Side Effect on _Item)

  ENDMETHOD. " create_items

  METHOD after_modify.
    " get_sales_order( ).
  ENDMETHOD. " after_modify

ENDCLASS. " lhc_matrix IMPLEMENTATION

CLASS lsc_zi_matrix_004 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_matrix_004 IMPLEMENTATION.

  METHOD save_modified. " on Save

    DATA wa_change_matrix LIKE LINE OF create-matrix.
    DATA wa_delete_matrix LIKE LINE OF delete-matrix.
    DATA wa_change_size LIKE LINE OF create-size.

    DATA wa_zmatrix_004 TYPE zmatrix_004.
    DATA wa_zsize_004 TYPE zsize_004.
    DATA wa_zitem_004 TYPE zitem_004.

*   Example ALPHA CONVERSION
    FINAL(text) = |{ '1234' ALPHA = IN WIDTH = 10 }|.

*   Create
    LOOP AT create-matrix INTO wa_change_matrix.

        MOVE-CORRESPONDING wa_change_matrix TO wa_zmatrix_004.

*       Default Values :
        IF ( wa_zmatrix_004-matrixid IS INITIAL ).
*           Calculate Max Matrix ID value
            DATA matrixid TYPE zi_matrix_004-MatrixID VALUE '0000000000'.
            SELECT MAX( matrixid ) FROM zi_matrix_004 INTO (@matrixid).
            wa_zmatrix_004-MatrixID = ( matrixid + 1 ).
        ENDIF.
        IF ( wa_zmatrix_004-salesordertype IS INITIAL ).
            wa_zmatrix_004-salesordertype = 'TA'.
        ENDIF.
        IF ( wa_zmatrix_004-salesorganization IS INITIAL ).
            wa_zmatrix_004-salesorganization = '1010'.
        ENDIF.
        IF ( wa_zmatrix_004-distributionchannel IS INITIAL ).
            wa_zmatrix_004-distributionchannel = '10'.
        ENDIF.
        IF ( wa_zmatrix_004-organizationdivision IS INITIAL ).
            wa_zmatrix_004-organizationdivision = '00'.
        ENDIF.
        IF ( wa_zmatrix_004-soldtoparty IS INITIAL ).
            wa_zmatrix_004-soldtoparty = '0010100014'.
        ENDIF.

        MODIFY zmatrix_004 FROM @wa_zmatrix_004.

*       Adjust Size:

*       Delete the size table
        DELETE FROM zsize_004 WHERE ( matrixuuid = @wa_change_matrix-MatrixUUID ).

*       Populate the size table (field Back only)
        DATA it_size TYPE TABLE OF zsize_004.
        DATA wa_size TYPE zsize_004.

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
            wa_size-matrixuuid  = wa_change_matrix-MatrixUUID.  " primary key
            wa_size-sizeid      = sy-tabix.                     " primary key
            MODIFY zsize_004 FROM @wa_size.
        ENDLOOP.

    ENDLOOP.

*   Update
    LOOP AT update-matrix INTO wa_change_matrix.
*       Read Matrix table
        SELECT SINGLE * FROM zmatrix_004 WHERE ( MatrixUUID = @wa_change_matrix-MatrixUUID ) INTO @wa_zmatrix_004.
        IF ( sy-subrc = 0 ).

            "MOVE-CORRESPONDING wa_change_matrix TO wa_zmatrix_004.
*            IF ( wa_change_matrix-%control-MatrixID = flag_changed ).
*                wa_zmatrix_003-matrixid = wa_change_matrix-MatrixID.
*            ENDIF.
            IF ( wa_change_matrix-%control-SalesOrderType = flag_changed ).
                wa_zmatrix_004-salesordertype       = wa_change_matrix-SalesOrderType.
            ENDIF.
            IF ( wa_change_matrix-%control-SalesOrganization = flag_changed ).
                wa_zmatrix_004-salesorganization    = wa_change_matrix-SalesOrganization.
            ENDIF.
            IF ( wa_change_matrix-%control-DistributionChannel = flag_changed ).
                wa_zmatrix_004-distributionchannel  = wa_change_matrix-DistributionChannel.
            ENDIF.
            IF ( wa_change_matrix-%control-OrganizationDivision = flag_changed ).
                wa_zmatrix_004-organizationdivision = wa_change_matrix-OrganizationDivision.
            ENDIF.
            IF ( wa_change_matrix-%control-SoldToParty = flag_changed ).
                wa_zmatrix_004-soldtoparty          = wa_change_matrix-SoldToParty.
            ENDIF.
            IF ( wa_change_matrix-%control-SalesOrderID = flag_changed ).
                wa_zmatrix_004-salesorderid         = wa_change_matrix-SalesOrderID.
            ENDIF.

            IF ( wa_change_matrix-%control-Model = flag_changed ).
                wa_zmatrix_004-model                = wa_change_matrix-Model.
            ENDIF.
            IF ( wa_change_matrix-%control-Color = flag_changed ).
                wa_zmatrix_004-color                = wa_change_matrix-Color.
            ENDIF.

            READ ENTITIES OF zi_matrix_004 IN LOCAL MODE
                ENTITY Matrix
                ALL FIELDS WITH VALUE #( ( MatrixUUID = wa_change_matrix-MatrixUUID ) )
                RESULT DATA(lt_matrix)
                FAILED DATA(ls_failed)
                REPORTED DATA(ls_reported).

            LOOP AT lt_matrix INTO DATA(ls_matrix).
                wa_zmatrix_004-creationdate = ls_matrix-CreationDate.
                wa_zmatrix_004-creationtime = ls_matrix-CreationTime.
            ENDLOOP.

*           Set Sales Order ID
*            IF ( ( wa_zmatrix_004-salesorderid IS INITIAL ) AND
*                 ( wa_zmatrix_004-creationdate IS NOT INITIAL ) AND
*                 ( wa_zmatrix_004-creationtime IS NOT INITIAL ) ).
*                SELECT SINGLE
*                        *
*                    FROM
*                        i_salesordertp
*                    WHERE
*                        ( CreationDate = @wa_zmatrix_004-CreationDate ) AND
*                        ( CreationTime = @wa_zmatrix_004-CreationTime )
*                    INTO
*                        @DATA(wa_i_salesordertp).
*                IF ( sy-subrc = 0 ).
*                    wa_zmatrix_004-salesorderid = wa_i_salesordertp-SalesOrder.
*                ENDIF.
*            ENDIF.

            MODIFY zmatrix_004 FROM @wa_zmatrix_004.

        ENDIF.
    ENDLOOP.

*   Delete
    LOOP AT delete-matrix INTO wa_delete_matrix.
        DELETE FROM zmatrix_004 WHERE ( matrixuuid = @wa_delete_matrix-MatrixUUID ).
        DELETE FROM zsize_004   WHERE ( matrixuuid = @wa_delete_matrix-MatrixUUID ).
*        DELETE FROM zitem_004   WHERE ( matrixuuid = @wa_delete_matrix-MatrixUUID ). " managed (removed automatically)
    ENDLOOP.

*   Update Sizes
    IF ( LINES( update-size ) > 0 ).
        DATA it_item TYPE TABLE OF zitem_004.
        DATA wa_item LIKE LINE OF it_item.
        DATA itemid TYPE zi_item_004-ItemID VALUE '000000'.
        READ TABLE update-size INTO wa_change_size INDEX 1.

*       Read Matrix table (if not read before)
        IF ( wa_zmatrix_004 IS INITIAL ).
            SELECT SINGLE * FROM zmatrix_004 WHERE ( MatrixUUID = @wa_change_size-MatrixUUID ) INTO @wa_zmatrix_004.
        ENDIF.

*       Read Item table
        SELECT * FROM zitem_004 WHERE ( MatrixUUID = @wa_change_size-MatrixUUID ) INTO TABLE @it_item.

*       Sort Size table
        DATA it_change_size LIKE TABLE OF wa_change_size.
        LOOP AT update-size INTO wa_change_size.
            APPEND wa_change_size TO it_change_size.
        ENDLOOP.
        SORT it_change_size STABLE BY %key-SizeID.

        LOOP AT it_change_size INTO wa_change_size.
*           Read a Row from Size table
            SELECT SINGLE
                    *
                FROM
                    zsize_004
                WHERE
                    ( MatrixUUID    = @wa_change_size-MatrixUUID ) AND
                    ( SizeID        = @wa_change_size-SizeID     )
                INTO
                    @wa_size.

*           Update Size Table
            IF ( wa_change_size-%control-a = flag_changed ).
                wa_size-a = wa_change_size-a.
            ENDIF.
            IF ( wa_change_size-%control-b = flag_changed ).
                wa_size-b = wa_change_size-b.
            ENDIF.
            IF ( wa_change_size-%control-c = flag_changed ).
                wa_size-c = wa_change_size-c.
            ENDIF.
            IF ( wa_change_size-%control-d = flag_changed ).
                wa_size-d = wa_change_size-d.
            ENDIF.
            IF ( wa_change_size-%control-e = flag_changed ).
                wa_size-e = wa_change_size-e.
            ENDIF.
            IF ( wa_change_size-%control-f = flag_changed ).
                wa_size-f = wa_change_size-f.
            ENDIF.
            IF ( wa_change_size-%control-g = flag_changed ).
                wa_size-g = wa_change_size-g.
            ENDIF.
            IF ( wa_change_size-%control-h = flag_changed ).
                wa_size-h = wa_change_size-h.
            ENDIF.
            IF ( wa_change_size-%control-i = flag_changed ).
                wa_size-i = wa_change_size-i.
            ENDIF.
            MODIFY zsize_004 FROM @wa_size.
        ENDLOOP.

**       Read the whole Size table
*        SELECT * FROM zsize_004 WHERE ( MatrixUUID = @wa_change_size-MatrixUUID ) ORDER By back INTO TABLE @it_size.
*
**       Add New Items based on actual Size table
*        LOOP AT it_size INTO wa_size.
*            IF ( wa_size-a IS NOT INITIAL ).
*                wa_item-Cupsize     = 'A'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-a.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-b IS NOT INITIAL ).
*                wa_item-Cupsize     = 'B'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-b.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-c IS NOT INITIAL ).
*                wa_item-Cupsize     = 'C'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-c.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-d IS NOT INITIAL ).
*                wa_item-Cupsize     = 'D'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-d.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-e IS NOT INITIAL ).
*                wa_item-Cupsize     = 'E'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-e.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-f IS NOT INITIAL ).
*                wa_item-Cupsize     = 'F'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-f.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-g IS NOT INITIAL ).
*                wa_item-Cupsize     = 'G'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-g.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-h IS NOT INITIAL ).
*                wa_item-Cupsize     = 'H'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-h.
*                APPEND wa_item TO it_item.
*            ENDIF.
*            IF ( wa_size-i IS NOT INITIAL ).
*                wa_item-Cupsize     = 'I'.
*                wa_item-Backsize    = wa_size-Back.
*                wa_item-Quantity    = wa_size-i.
*                APPEND wa_item TO it_item.
*            ENDIF.
*        ENDLOOP.
*
**       Calculate Max item id
*        itemid = 0.
*        LOOP AT it_item INTO wa_item WHERE ( itemid IS NOT INITIAL ).
*            IF ( itemid < wa_item-itemid ).
*              itemid = wa_item-itemid.
*            ENDIF.
*        ENDLOOP.
*
**       Populate the new-added items with remaining values
*        LOOP AT it_item INTO wa_item WHERE ( itemid IS INITIAL ).
*            itemid = itemid + 1.
*            wa_item-ItemID      = itemid.
*            wa_item-MatrixUUID  = wa_change_size-MatrixUUID.
*            wa_item-Model       = wa_zmatrix_004-Model.
*            wa_item-Color       = wa_zmatrix_004-Color.
*            wa_item-Product     = wa_item-Model && '-' && wa_item-Color && '-' && wa_item-Cupsize && '-' &&  wa_item-Backsize.
*            MODIFY it_item FROM wa_item INDEX sy-tabix.
*        ENDLOOP.
*
*        MODIFY zitem_004 FROM TABLE @it_item.

    ENDIF.

*   Clear it_size
*    LOOP AT it_size INTO wa_size.
*        wa_size-a = ''.
*        wa_size-b = ''.
*        wa_size-c = ''.
*        wa_size-d = ''.
*        wa_size-e = ''.
*        wa_size-f = ''.
*        wa_size-h = ''.
*        wa_size-i = ''.
*        MODIFY it_size FROM wa_size INDEX sy-tabix.
*    ENDLOOP.

*   Fixes
*    DELETE FROM zsize_004.
*    DELETE FROM zitem_004.

  ENDMETHOD. " save_modified

  METHOD cleanup_finalize.
  ENDMETHOD. " cleanup_finalize

ENDCLASS. " lsc_zi_matrix_004 IMPLEMENTATION

CLASS lhc_OnlineShop DEFINITION INHERITING FROM cl_abap_behavior_handler.
PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF is_draft,
        false TYPE abp_behv_flag VALUE '00', " active (not draft)
        true  TYPE abp_behv_flag VALUE '01', " draft
      END OF is_draft.
    CONSTANTS:
      BEGIN OF c_overall_status,
        new       TYPE string VALUE 'New / Composing',
*        composing  TYPE string VALUE 'Composing...',
        submitted TYPE string VALUE 'Submitted / Approved',
        cancelled TYPE string VALUE 'Cancelled',
      END OF c_overall_status.
    METHODS: get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR OnlineShop RESULT result,
    createPruchaseRequisitionItem FOR MODIFY
      IMPORTING keys FOR ACTION OnlineShop~createPurchaseRequisitionItem RESULT result,
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features FOR onlineshop RESULT result,
            setInitialOrderValues FOR DETERMINE ON MODIFY
                  IMPORTING keys FOR OnlineShop~setInitialOrderValues,
            calculateTotalPrice FOR DETERMINE ON MODIFY
                  IMPORTING keys FOR OnlineShop~calculateTotalPrice.

                METHODS checkDeliveryDate FOR VALIDATE ON SAVE
                  IMPORTING keys FOR OnlineShop~checkDeliveryDate.

                METHODS checkOrderedQuantity FOR VALIDATE ON SAVE
                  IMPORTING keys FOR OnlineShop~checkOrderedQuantity.

ENDCLASS.

CLASS lhc_OnlineShop IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD createPruchaseRequisitionItem.
    DATA: purchase_requisitions      TYPE TABLE FOR CREATE I_PurchaserequisitionTP,
          purchase_requisition       TYPE STRUCTURE FOR CREATE I_PurchaserequisitionTP,
          purchase_requisition_items TYPE TABLE FOR CREATE i_purchaserequisitionTP\_PurchaseRequisitionItem,
          purchase_requisition_item  TYPE STRUCTURE FOR CREATE i_purchaserequisitiontp\\purchaserequisition\_purchaserequisitionitem,
          purchase_reqn_acct_assgmts TYPE TABLE FOR CREATE I_PurchaseReqnItemTP\_PurchaseReqnAcctAssgmt,
          purchase_reqn_acct_assgmt  TYPE STRUCTURE FOR CREATE I_PurchaseReqnItemTP\_PurchaseReqnAcctAssgmt,
          purchase_reqn_item_texts   TYPE TABLE FOR CREATE I_PurchaseReqnItemTP\_PurchaseReqnItemText,
          purchase_reqn_item_text    TYPE STRUCTURE FOR CREATE I_PurchaseReqnItemTP\_PurchaseReqnItemText,
          update_lines               TYPE TABLE FOR UPDATE zr_onlineshoptp_000\\OnlineShop,
          update_line                TYPE STRUCTURE FOR UPDATE zr_onlineshoptp_000\\OnlineShop,
          delivery_date              TYPE I_PurchaseReqnItemTP-DeliveryDate,
          requested_quantity         TYPE I_PurchaseReqnItemTP-RequestedQuantity.

*    delivery_date = cl_abap_context_info=>get_system_date(  ) + 14.

    "read transfered order instances
    READ ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
      ENTITY OnlineShop
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(OnlineOrders).

    DATA n TYPE i.

    LOOP AT OnlineOrders INTO DATA(OnlineOrder).
      n += 1.
      "purchase requisition
      purchase_requisition = VALUE #(  %cid                   = |My%CID_{ n }|
                                        purchaserequisitiontype  = 'NB'  ) .
      APPEND purchase_requisition TO purchase_requisitions.

      "purchase requisition item
      purchase_requisition_item = VALUE #(
                                        %cid_ref = |My%CID_{ n }|
                                        %target  = VALUE #(  (
                                                      %cid                         = |My%ItemCID_{ n }|
                                                      plant                        = '1010'  "Plant 01 (DE)
                                                      accountassignmentcategory    = 'U'  "unknown
*                                                       PurchaseRequisitionItemText  =  . "retrieved automatically from maintained MaterialInfo
                                                      requestedquantity            = OnlineOrder-OrderQuantity
                                                      purchaserequisitionprice     = OnlineOrder-Price
                                                      purreqnitemcurrency          = OnlineOrder-Currency
                                                      Material                     = 'TG10' " 'D001'
                                                      materialgroup                = 'L001' "'A001'
                                                      purchasinggroup              = '001'
                                                      purchasingorganization       = '0010100088' " '1010'
                                                      DeliveryDate                 = OnlineOrder-DeliveryDate   "delivery_date  "yyyy-mm-dd (at least 10 days)
                                                      CreatedByUser                = OnlineOrder-CreatedBy
                                                      ) ) ).
      APPEND purchase_requisition_item TO purchase_requisition_items.

      "purchase requisition account assignment
      purchase_reqn_acct_assgmt = VALUE #(
                                          %cid_ref = |My%ItemCID_{ n }|
                                          %target  = VALUE #( (
                                                        %cid       = |My%AccntCID_{ n }|
                                                        CostCenter = 'JMW-COST'
                                                        GLAccount  = '0000400000' ) ) ) .
      APPEND purchase_reqn_acct_assgmt TO purchase_reqn_acct_assgmts .

      "purchase requisition item text
      purchase_reqn_item_text    =  VALUE #(
                                          %cid_ref = |My%ItemCID_{ n }|
                                          %target  = VALUE #( (
                                                        %cid           = |My%TextCID_{ n }|
                                                        textobjecttype = 'B01'
                                                        language       = 'E'
                                                        plainlongtext  = OnlineOrder-Notes
                                                    )  )  ) .
      APPEND purchase_reqn_item_text TO purchase_reqn_item_texts.
    ENDLOOP.

    "EML deep create statement
    IF keys IS NOT INITIAL.
      "purchase reqn
      MODIFY ENTITIES OF
            i_purchaserequisitiontp
        ENTITY
            purchaserequisition
        CREATE FIELDS
            ( purchaserequisitiontype )
        WITH
            purchase_requisitions
        "purchase reqn item
        CREATE BY
            \_purchaserequisitionitem
        FIELDS
            (   plant
*               purchaserequisitionitemtext
                accountassignmentcategory
                requestedquantity
                baseunit
                purchaserequisitionprice
                purreqnitemcurrency
                Material
                materialgroup
                purchasinggroup
                purchasingorganization
                DeliveryDate )
        WITH
            purchase_requisition_items
      "purchase reqn account assignment
      ENTITY purchaserequisitionitem
        CREATE BY
            \_purchasereqnacctassgmt
        FIELDS
            ( CostCenter
              GLAccount
              Quantity
              BaseUnit )
        WITH
            purchase_reqn_acct_assgmts
        "purchase reqn item text
        CREATE BY \_purchasereqnitemtext
            FIELDS ( plainlongtext )
            WITH purchase_reqn_item_texts
      REPORTED DATA(reported_create_pr)
      MAPPED DATA(mapped_create_pr)
      FAILED DATA(failed_create_pr).

    ENDIF.
    "retrieve the generated
    zbp_onlineshoptp_000=>mapped_purchase_requisition-purchaserequisition = mapped_create_pr-purchaserequisition.

    "set a flag to check in the save sequence that purchase requisition has been created
    "the correct value for PurchaseRequisition has to be calculated in the save sequence using convert key
    LOOP AT keys INTO DATA(key).
      update_line-%tky           = key-%tky.
      update_line-OverallStatus  = c_overall_status-submitted. "'Submitted / Approved'.
      APPEND update_line TO update_lines.
    ENDLOOP.

    MODIFY ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
      ENTITY OnlineShop
        UPDATE
        FIELDS (  OverallStatus  )
        WITH update_lines
      REPORTED reported
      FAILED failed
      MAPPED mapped.

    IF failed IS INITIAL.
      "Read the changed data for action result
      READ ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
        ENTITY OnlineShop
          ALL FIELDS WITH
          CORRESPONDING #( keys )
        RESULT DATA(result_read).
      "return result entities
      result = VALUE #( FOR order_2 IN result_read ( %tky   = order_2-%tky
                                                    %param = order_2 ) ).
    ENDIF.
endmethod.

METHOD get_instance_features.
    " read relevant olineShop instance data
    READ ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
      ENTITY OnlineShop
        FIELDS ( OverallStatus )
        WITH CORRESPONDING #( keys )
      RESULT DATA(OnlineOrders)
      FAILED failed.

    "ToDo: dynamic feature control is currently not working for the action cancel order

    " evaluate condition, set operation state, and set result parameter
    " update and checkout shall not be allowed as soon as purchase requisition has been created
    result = VALUE #( FOR OnlineOrder IN OnlineOrders
                      ( %tky                   = OnlineOrder-%tky
                        %features-%action-createPurchaseRequisitionItem
                          = COND #( WHEN OnlineOrder-OverallStatus = c_overall_status-submitted THEN if_abap_behv=>fc-o-disabled
                                    WHEN OnlineOrder-%is_draft = is_draft-true THEN if_abap_behv=>fc-o-disabled
                                    WHEN OnlineOrder-OverallStatus = c_overall_status-cancelled THEN if_abap_behv=>fc-o-disabled
                                    ELSE if_abap_behv=>fc-o-enabled   )
                        %features-%update
                          = COND #( WHEN OnlineOrder-OverallStatus = c_overall_status-submitted  THEN if_abap_behv=>fc-o-disabled
                                    WHEN OnlineOrder-OverallStatus = c_overall_status-cancelled THEN if_abap_behv=>fc-o-disabled
                                    ELSE if_abap_behv=>fc-o-enabled   )
*                         %features-%delete
*                           = COND #( WHEN OnlineOrder-PurchaseRequisition IS NOT INITIAL THEN if_abap_behv=>fc-o-disabled
*                                     WHEN OnlineOrder-OverallStatus = c_overall_status-cancelled THEN if_abap_behv=>fc-o-disabled
*                                     ELSE if_abap_behv=>fc-o-enabled   )
                        %action-Edit
                          = COND #( WHEN OnlineOrder-OverallStatus = c_overall_status-submitted THEN if_abap_behv=>fc-o-disabled
                                    WHEN OnlineOrder-OverallStatus = c_overall_status-cancelled THEN if_abap_behv=>fc-o-disabled
                                    ELSE if_abap_behv=>fc-o-enabled   )

                        ) ).

  ENDMETHOD.
  METHOD setInitialOrderValues.
  DATA delivery_date TYPE I_PurchaseReqnItemTP-DeliveryDate.
    data(creation_date) = cl_abap_context_info=>get_system_date(  ).
    "set delivery date proposal
    delivery_date = cl_abap_context_info=>get_system_date(  ) + 14.
    "read transfered instances
    READ ENTITIES OF ZR_ONLINESHOPTP_000 IN LOCAL MODE
      ENTITY OnlineShop
        FIELDS ( OrderID OverallStatus  DeliveryDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(OnlineOrders).

    "delete entries with assigned order ID
    DELETE OnlineOrders WHERE OrderID IS NOT INITIAL.
    CHECK OnlineOrders IS NOT INITIAL.

    " **Dummy logic to determine order IDs**
    " get max order ID from the relevant active and draft table entries
    SELECT MAX( order_id ) FROM zaonlineshop_000 INTO @DATA(max_order_id). "active table
    SELECT SINGLE FROM zdonlineshop_000 FIELDS MAX( orderid ) INTO @DATA(max_orderid_draft). "draft table
    IF max_orderid_draft > max_order_id.
      max_order_id = max_orderid_draft.
    ENDIF.

    "set initial values of new instances
    MODIFY ENTITIES OF ZR_ONLINESHOPTP_000 IN LOCAL MODE
      ENTITY OnlineShop
        UPDATE FIELDS ( OrderID OverallStatus  DeliveryDate Price  )
        WITH VALUE #( FOR order IN OnlineOrders INDEX INTO i (
                          %tky          = order-%tky
                          OrderID       = max_order_id + i
                          OverallStatus = c_overall_status-new  "'New / Composing'
                          DeliveryDate  = delivery_date
                          CreatedAt     = creation_date
                        ) ).
  ENDMETHOD.

METHOD checkOrderedQuantity.
    "read relevant order instance data
    READ ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
    ENTITY OnlineShop
    FIELDS ( OrderID OrderedItem OrderQuantity )
    WITH CORRESPONDING #( keys )
    RESULT DATA(OnlineOrders).

    "raise msg if 0 > qty <= 10
    LOOP AT OnlineOrders INTO DATA(OnlineOrder).
      APPEND VALUE #(  %tky           = OnlineOrder-%tky
                      %state_area    = 'VALIDATE_QUANTITY'
                    ) TO reported-onlineshop.

  IF OnlineOrder-OrderQuantity IS INITIAL OR OnlineOrder-OrderQuantity = ' '.
        APPEND VALUE #( %tky = OnlineOrder-%tky ) TO failed-onlineshop.
        APPEND VALUE #( %tky          = OnlineOrder-%tky
                        %state_area   = 'VALIDATE_QUANTITY'
                        %msg          = new_message_with_text(
                                severity = if_abap_behv_message=>severity-error
                                text     = 'Quantity cannot be empty' )
                        %element-orderquantity = if_abap_behv=>mk-on
                      ) TO reported-onlineshop.

      ELSEIF OnlineOrder-OrderQuantity > 10.
        APPEND VALUE #(  %tky = OnlineOrder-%tky ) TO failed-onlineshop.
        APPEND VALUE #(  %tky          = OnlineOrder-%tky
                        %state_area   = 'VALIDATE_QUANTITY'
                        %msg          = new_message_with_text(
                                severity = if_abap_behv_message=>severity-error
                                text     = 'Quantity should be below 10' )

                        %element-orderquantity  = if_abap_behv=>mk-on
                      ) TO reported-onlineshop.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateTotalPrice.
    DATA total_price TYPE zr_onlineshoptp_000-TotalPrice.

    " read transfered instances
    READ ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
      ENTITY OnlineShop
        FIELDS ( OrderID TotalPrice )
        WITH CORRESPONDING #( keys )
      RESULT DATA(OnlineOrders).

    LOOP AT OnlineOrders ASSIGNING FIELD-SYMBOL(<OnlineOrder>).
      " calculate total value
      <OnlineOrder>-TotalPrice = <OnlineOrder>-Price * <OnlineOrder>-OrderQuantity.
    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
      ENTITY OnlineShop
        UPDATE FIELDS ( TotalPrice )
        WITH VALUE #( FOR OnlineOrder IN OnlineOrders (
                          %tky       = OnlineOrder-%tky
                          TotalPrice = <OnlineOrder>-TotalPrice
                        ) ).
  ENDMETHOD.

  METHOD checkdeliverydate.
*   " read transfered instances
    READ ENTITIES OF zr_onlineshoptp_000 IN LOCAL MODE
      ENTITY OnlineShop
        FIELDS ( DeliveryDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(OnlineOrders).

    DATA(creation_date) = cl_abap_context_info=>get_system_date(  ).
    "raise msg if 0 > qty <= 10
    LOOP AT OnlineOrders INTO DATA(online_order).


      IF online_order-DeliveryDate IS INITIAL OR online_order-DeliveryDate = ' '.
        APPEND VALUE #( %tky = online_order-%tky ) TO failed-onlineshop.
        APPEND VALUE #( %tky         = online_order-%tky
                        %state_area   = 'VALIDATE_DELIVERYDATE'
                        %msg          = new_message_with_text(
                                severity = if_abap_behv_message=>severity-error
                                text     = 'Delivery Date cannot be initial' )
                      ) TO reported-onlineshop.

      ELSEIF  ( ( online_order-DeliveryDate ) - creation_date ) < 14.
        APPEND VALUE #(  %tky = online_order-%tky ) TO failed-onlineshop.
        APPEND VALUE #(  %tky          = online_order-%tky
                        %state_area   = 'VALIDATE_DELIVERYDATE'
                        %msg          = new_message_with_text(
                                severity = if_abap_behv_message=>severity-error
                                text     = 'Delivery Date should be atleast 14 days after the creation date'  )

                        %element-orderquantity  = if_abap_behv=>mk-on
                      ) TO reported-onlineshop.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZR_ONLINESHOPTP_000 DEFINITION INHERITING FROM cl_abap_behavior_saver.
PROTECTED SECTION.

  METHODS save_modified REDEFINITION.

  METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_ONLINESHOPTP_000 IMPLEMENTATION.

METHOD save_modified.
  DATA : lt_online_shop_as        TYPE STANDARD TABLE OF zaonlineshop_000,
        ls_online_shop_as        TYPE                   zaonlineshop_000,
        lt_online_shop_x_control TYPE STANDARD TABLE OF zaonlineshop_0.
  IF create-onlineshop IS NOT INITIAL.
    lt_online_shop_as = CORRESPONDING #( create-onlineshop MAPPING FROM ENTITY ).
    INSERT zaonlineshop_000 FROM TABLE @lt_online_shop_as.
  ENDIF.
  IF update IS NOT INITIAL.
    CLEAR lt_online_shop_as.
    lt_online_shop_as = CORRESPONDING #( update-onlineshop MAPPING FROM ENTITY ).
    lt_online_shop_x_control = CORRESPONDING #( update-onlineshop MAPPING FROM ENTITY ).
    LOOP AT update-onlineshop  INTO DATA(onlineshop) WHERE OrderUUID IS NOT INITIAL.
*           select * from zaonlineshop_000 where order_uuid = @onlineshop-OrderUUID into @data(ls_onlineshop) .
*                      lt_online_shop_as = CORRESPONDING #( create-onlineshop MAPPING FROM ENTITY ).

      MODIFY zaonlineshop_000 FROM TABLE @lt_online_shop_as.
*           ENDSELECT.
    ENDLOOP.
  ENDIF.
  IF zbp_onlineshoptp_000=>mapped_purchase_requisition IS NOT INITIAL AND update IS NOT INITIAL.
    LOOP AT zbp_onlineshoptp_000=>mapped_purchase_requisition-purchaserequisition ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
      CONVERT KEY OF i_purchaserequisitiontp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
      <fs_pr_mapped>-purchaserequisition = ls_pr_key-purchaserequisition.
*        ZBP_ONLINESHOPTP_000=>cv_pr_pid = <fs_pr_mapped>-%pid.
    ENDLOOP.
    LOOP AT update-onlineshop INTO  DATA(ls_online_shop) WHERE %control-OverallStatus = if_abap_behv=>mk-on.
      " Creates internal table with instance data
      DATA(creation_date) = cl_abap_context_info=>get_system_date(  ).
*      update zaonlineshop_000 FROM  @( VALUE #(  purchase_requisition = ls_pr_key-purchaserequisition  pr_creation_date =  creation_date order_id = ls_online_shop-OrderID  ) ).
      update zaonlineshop_000 SET purchase_requisition = @ls_pr_key-purchaserequisition, pr_creation_date = @creation_date WHERE order_uuid = @ls_online_shop-OrderUUID.
    ENDLOOP.
    if ls_pr_key-purchaserequisition is not initial.


      raise entity event zr_onlineshoptp_000~sendPurchaseRequisitionDetails
        from value #(
          for prdet in update-onlineshop (
*              purchase_requisition = ls_pr_key-purchaserequisition
*              created_by       = prdet-CreatedBy
*              created_at          = prdet-CreatedAt
*              email  = prdet-Email
            )
          ).
    endif.
  ENDIF.
loop at delete-onlineshop into data(onlineshop_delete) WHERE OrderUUID is not INITIAL.
delete from zaonlineshop_000 where order_uuid = @onlineshop_delete-OrderUUID.
delete from zdonlineshop_000 where orderuuid = @onlineshop_delete-OrderUUID.
endloop.
ENDMETHOD.

METHOD cleanup_finalize.
ENDMETHOD.

ENDCLASS.

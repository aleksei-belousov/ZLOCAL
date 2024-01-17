
CLASS lhc_zbp_i_matrix_shop_xxx  DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR matrix_shop RESULT result.


    METHODS create_so FOR MODIFY
      IMPORTING keys FOR ACTION matrix_shop~create_so.

    METHODS calculate_order_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR matrix_shop~calculate_order_id.


ENDCLASS.

CLASS lhc_zbp_i_matrix_shop_xxx  IMPLEMENTATION.

  METHOD get_instance_authorizations.

  ENDMETHOD.

  METHOD create_so.

    "LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
    "SELECT SINGLE * FROM zi_online_shop_prepitem_xxx WHERE Pkgid = @<key>-%param-PackageId INTO @DATA(ls_prepitem).

    MODIFY ENTITIES OF i_salesordertp
     ENTITY salesorder
    CREATE
      FIELDS ( salesordertype
       salesorganization
       distributionchannel
       organizationdivision
       soldtoparty )
    WITH VALUE #( ( %cid = '5'
                    %data = VALUE #( salesordertype = 'TA'
                    salesorganization = '1010'
                    distributionchannel = '10'
                    organizationdivision = '00'
                    soldtoparty = '0010100014' ) ) )  "10100014
    CREATE BY \_item
    FIELDS ( product
            requestedquantity )
    WITH VALUE #( ( %cid_ref = '5'
                    salesorder = space
                    %target = VALUE #( ( %cid = '8'
                    product = 'TG0012'
                    requestedquantity = '1' )
                    ( %cid = '9'
                    product = 'TG0012'
                   requestedquantity = '7' ) ) ) )
    MAPPED DATA(ls_mapped)
    FAILED DATA(ls_failed)
    REPORTED DATA(ls_reported).


    READ ENTITIES OF i_salesordertp
    ENTITY salesorder
    FROM VALUE #( ( salesorder = space ) )
    RESULT DATA(lt_so_head)
    REPORTED DATA(ls_reported_read).

    zbp_matrix_final=>cv_so_mapped = ls_mapped.

    " ENDLOOP.
  ENDMETHOD.



  METHOD calculate_order_id.
    DATA: online_shops TYPE TABLE FOR UPDATE zmatrix_view,
          online_shop  TYPE STRUCTURE FOR UPDATE zmatrix_view.
    READ ENTITIES OF zmatrix_final IN LOCAL MODE
    ENTITY Matrix_Shop
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_online_shop_result)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).
    DATA(today) = cl_abap_context_info=>get_system_date( ).
    SELECT MAX( order_id ) FROM zmatrix INTO @DATA(max_order_id).
    LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
      max_order_id += 1.
      online_shop = CORRESPONDING #( online_shop_read ).
      online_shop-order_id = max_order_id.
      online_shop-Creationdate = today.
      online_shop-Deliverydate = today + 10.
      online_shop-Ordereditem = online_shop-Modelnr  && '-'  && online_shop-Colornr  && '-XXX'.
      APPEND online_shop TO online_shops.
    ENDLOOP.
    MODIFY ENTITIES OF zmatrix_final IN LOCAL MODE
    "ENTITY Matrix_Shop UPDATE SET FIELDS WITH online_shops
    ENTITY Matrix_Shop UPDATE
     FIELDS ( ordereditem )
    WITH VALUE #( ( ordereditem = '120') )

    MAPPED DATA(ls_mapped_modify)
    FAILED DATA(lt_failed_modify)
    REPORTED DATA(lt_reported_modify).
    DATA: lt_create_so_imp TYPE TABLE FOR ACTION IMPORT zmatrix_final~create_so,
          ls_create_so_imp LIKE LINE OF lt_create_so_imp.
    LOOP AT lt_online_shop_result INTO DATA(ls_online_shop_result).
      ls_create_so_imp-Order_Uuid = ls_online_shop_result-Order_Uuid.
      ls_create_so_imp-%param = CORRESPONDING #( ls_online_shop_result ).
      APPEND ls_create_so_imp TO lt_create_so_imp.
    ENDLOOP.
* if a new package is ordered, trigger a new purchase requisition
    " IF ls_failed IS INITIAL.
    MODIFY ENTITIES OF zmatrix_final IN LOCAL MODE
    ENTITY Matrix_Shop EXECUTE create_so FROM CORRESPONDING #( lt_create_so_imp ) "CORRESPONDING #( keys )
    FAILED DATA(lt_pr_failed)
    REPORTED DATA(lt_pr_reported).
    " ENDIF.


  ENDMETHOD.
ENDCLASS.

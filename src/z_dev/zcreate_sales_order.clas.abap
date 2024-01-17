*   Create Sales Order
CLASS zcreate_sales_order DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCREATE_SALES_ORDER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Create Sales Order.' ).

    MODIFY ENTITIES OF
        i_salesordertp
    ENTITY
        salesorder
    CREATE FIELDS (
        salesordertype
        salesorganization
        distributionchannel
        organizationdivision
        soldtoparty )
    WITH VALUE #( ( %cid = '3'  %data = VALUE #(    salesordertype = 'TA'
                                                    salesorganization = '1010'
                                                    distributionchannel = '10'
                                                    organizationdivision = '00'
                                                    soldtoparty = '0010100014' ) ) )
    CREATE BY
        \_item
    FIELDS
        ( product requestedquantity )
    WITH VALUE #( ( %cid_ref = '3' salesorder = space  %target = VALUE #(
            ( %cid = '13' product = 'TG20'      requestedquantity = '1' )
            ( %cid = '14' product = 'TG0012'    requestedquantity = '2' )
            ( %cid = '15' product = 'TG10'      requestedquantity = '3' ) ) ) )
    MAPPED DATA(ls_mapped)
    FAILED DATA(ls_failed)
    REPORTED DATA(ls_reported).

    COMMIT ENTITIES
      RESPONSE OF i_salesordertp
          FAILED DATA(failed_commit)
          REPORTED DATA(reported_commit).

    DATA wa_salesorder  LIKE LINE OF reported_commit-salesorder.
    DATA salesOrder     LIKE wa_salesorder-SalesOrder.

    LOOP AT reported_commit-salesorder INTO wa_salesorder.
        IF ( wa_salesorder-SalesOrder IS NOT INITIAL ).
            salesOrder = wa_salesorder-SalesOrder.
            EXIT.
        ENDIF.
    ENDLOOP.

    IF ( salesOrder IS INITIAL ).
        out->write( 'Failed.' ). " output to console
    ELSE.
        DATA text TYPE string.
        text = CONV #( salesOrder ).
        CONCATENATE 'A New Sales Order' text 'Has Been Created.' INTO text SEPARATED BY space.
        out->write( text ). " output to console
     ENDIF.

  ENDMETHOD.
ENDCLASS.

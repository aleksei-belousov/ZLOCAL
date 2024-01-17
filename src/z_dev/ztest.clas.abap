CLASS ztest DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZTEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA line     TYPE c LENGTH 80.
    DATA text_tab LIKE STANDARD TABLE OF line.
    DATA filename TYPE string.
    DATA filetype TYPE c LENGTH 10.
    DATA fleng    TYPE i.

    DATA a TYPE P.
    DATA b(20) TYPE C.
    DATA c LIKE b.

    a = 1.
    b = 'Hello!'.

    DATA it_tab TYPE TABLE OF I_SALESORDERTP.
    DATA wa_tab TYPE I_SALESORDERTP.

    DATA it_item TYPE TABLE OF I_SalesOrderItemTP.
    DATA wa_item TYPE I_SalesOrderItemTP.

**** List Sales Orders
*
*    SELECT
*       I_SALESORDERTP~SALESORDER,
*       I_SALESORDERTP~SALESORDERTYPE,
*       I_SALESORDERTP~SOLDTOPARTY,
*       I_SALESORDERTP~SALESORGANIZATION,
*       I_SALESORDERTP~DISTRIBUTIONCHANNEL,
*       I_SALESORDERTP~ORGANIZATIONDIVISION,
*       I_SALESORDERTP~SALESOFFICE,
*       I_SALESORDERTP~SALESGROUP,
*       I_SALESORDERTP~SALESDISTRICT,
*       I_SALESORDERTP~PURCHASEORDERBYCUSTOMER,
*       I_SALESORDERTP~CUSTOMERPURCHASEORDERTYPE,
*       I_SALESORDERTP~CUSTOMERPURCHASEORDERDATE,
*       I_SALESORDERTP~CUSTOMERGROUP,
*       I_SALESORDERTP~SDDOCUMENTREASON,
*       I_SALESORDERTP~PRICINGDATE,
*       I_SALESORDERTP~BILLINGDOCUMENTDATE,
*       I_SALESORDERTP~SDPRICINGPROCEDURE,
*       I_SALESORDERTP~CUSTOMERPRICEGROUP,
*       I_SALESORDERTP~REQUESTEDDELIVERYDATE,
*       I_SALESORDERTP~DELIVERYDATETYPERULE,
*       I_SALESORDERTP~SHIPPINGCONDITION,
*       I_SALESORDERTP~COMPLETEDELIVERYISDEFINED,
*       I_SALESORDERTP~SHIPPINGTYPE,
*       I_SALESORDERTP~INCOTERMSCLASSIFICATION,
*       I_SALESORDERTP~INCOTERMSVERSION,
*       I_SALESORDERTP~INCOTERMSLOCATION1,
*       I_SALESORDERTP~INCOTERMSLOCATION2,
*       I_SALESORDERTP~FIXEDVALUEDATE,
*       I_SALESORDERTP~HEADERBILLINGBLOCKREASON,
*       I_SALESORDERTP~DELIVERYBLOCKREASON,
*       I_SALESORDERTP~SALESORDERAPPROVALREASON,
*       I_SALESORDERTP~CUSTOMERPAYMENTTERMS,
*       I_SALESORDERTP~BILLINGCOMPANYCODE,
*       I_SALESORDERTP~PAYMENTMETHOD,
*       I_SALESORDERTP~TRANSACTIONCURRENCY,
*       I_SALESORDERTP~ASSIGNMENTREFERENCE,
*       I_SALESORDERTP~ACCOUNTINGDOCEXTERNALREFERENCE,
*       I_SALESORDERTP~TOTALNETAMOUNT,
*       I_SALESORDERTP~REFERENCESDDOCUMENT,
*       I_SALESORDERTP~CUSTOMERCREDITACCOUNT,
*       I_SALESORDERTP~OVERALLSDPROCESSSTATUS,
*       I_SALESORDERTP~OVERALLDELIVERYBLOCKSTATUS,
*       I_SALESORDERTP~OVERALLBILLINGBLOCKSTATUS,
*       I_SALESORDERTP~OVERALLDELIVERYSTATUS,
*       I_SALESORDERTP~TOTALCREDITCHECKSTATUS,
*       I_SALESORDERTP~OVERALLSDDOCUMENTREJECTIONSTS,
*       I_SALESORDERTP~TOTALBLOCKSTATUS,
*       I_SALESORDERTP~HDRGENERALINCOMPLETIONSTATUS,
*       I_SALESORDERTP~OVRLITMGENERALINCOMPLETIONSTS,
*       I_SALESORDERTP~OVERALLSDDOCREFERENCESTATUS,
*       I_SALESORDERTP~SALESDOCAPPROVALSTATUS,
*       I_SALESORDERTP~OVERALLCHMLCMPLNCSTATUS,
*       I_SALESORDERTP~OVERALLDANGEROUSGOODSSTATUS,
*       I_SALESORDERTP~OVERALLSAFETYDATASHEETSTATUS,
*       I_SALESORDERTP~LASTCHANGEDATETIME,
*       I_SALESORDERTP~SALESORDERDATE,
*       I_SALESORDERTP~CONTROLLINGAREA,
*       I_SALESORDERTP~CREATEDBYUSER,
*       I_SALESORDERTP~CREATIONDATE,
*       I_SALESORDERTP~CREATIONTIME,
*       I_SALESORDERTP~SALESDOCUMENTCREATIONDATETIME,
*       I_SALESORDERTP~LASTCHANGEDBYUSER
*     FROM
*       I_SALESORDERTP
*     INTO TABLE
*       @it_tab.
*
*    DATA tabix TYPE I.
*    LOOP AT it_tab INTO wa_tab.
*        tabix = sy-tabix.
*        out->write( tabix ).    " output to console
*        out->write( wa_tab ).   " output to console
*        out->write( sy-uline ). " output to console
*    ENDLOOP.

*   Create Sales Order
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
            ( %cid = '13' product = 'TG20'  requestedquantity = '1' )
            ( %cid = '14' product = 'TG0012' requestedquantity = '2' )
            ( %cid = '15' product = 'TG10' requestedquantity = '3' ) ) ) )
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

    DATA text TYPE string.
    "text = CONV string( salesOrder ).
    text = CONV #( salesOrder ).
    CONCATENATE 'Create a new Sales Order' text INTO text SEPARATED BY space.
    out->write( text ). " output to console

*    READ ENTITIES OF i_salesordertp
*    ENTITY salesorder
*    FROM VALUE #( ( salesorder = space ) )
*    RESULT DATA(lt_so_head)
*    REPORTED DATA(ls_reported_read).
*
*    zbp_i_matrix_entry=>cv_so_mapped = ls_mapped.

*    SELECT * FROM /dmo/flight INTO TABLE @DATA(lt_flights)." does not work here

*    MODIFY ENTITIES OF I_ProductTP_2
*        ENTITY ProductDescription
*        UPDATE FIELDS ( ProductDescription )
*        WITH VALUE #( ( %key-Product = 'TG0012'
*                        %key-Language = 'E'
*                        ProductDescription = 'Dummy Product XXX- Updated') )
*
*        REPORTED DATA(reported)
*        FAILED DATA(failed).
*
*    COMMIT ENTITIES
*      RESPONSE OF I_ProductTP_2
*          FAILED DATA(failed_commit)
*          REPORTED DATA(reported_commit).

  ENDMETHOD.
ENDCLASS.

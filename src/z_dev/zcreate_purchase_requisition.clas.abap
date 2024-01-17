CLASS zcreate_purchase_requisition DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCREATE_PURCHASE_REQUISITION IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    out->write( 'Create Purchase Requisition...' ).

    MODIFY ENTITIES OF i_purchaserequisitiontp ENTITY purchaserequisition
    CREATE BY \_purchaserequisitionitem
     FIELDS (
         plant
         purchaserequisitionitemtext
         accountassignmentcategory
         requestedquantity
         baseunit
         purchaserequisitionprice
         purreqnitemcurrency
         material
         materialgroup
         purchasinggroup
         purchasingorganization )
     WITH VALUE #(
         (
             %key-purchaserequisition = '0010000010'
             %target = VALUE #(
             (
                %cid = 'My%ItemCID_1'
                purchaserequisition = '0010000010'
                plant = '1010'
                purchaserequisitionitemtext = 'Sample Text 2'
                accountassignmentcategory = 'U'
                requestedquantity = '1.000'
                baseunit = 'PC'
                purchaserequisitionprice = '10.00'
                purreqnitemcurrency = 'EUR'
                material = 'TG10'
                materialgroup = '01'
                purchasinggroup = 'L001'
                purchasingorganization = ''
            )
        )
     )
     )
     REPORTED DATA(ls_reported)
     FAILED DATA(ls_failed).

    COMMIT ENTITIES
      RESPONSE OF i_purchaserequisitiontp
          FAILED DATA(failed_commit)
          REPORTED DATA(reported_commit).



*    out->write( 'Create Purchase Requisition...' ).
*
*    MODIFY ENTITIES OF
*            i_purchaserequisitiontp
*        ENTITY
*            purchaserequisition
*        CREATE FIELDS
*            ( purchaserequisitiontype )
*        WITH VALUE
*            #( ( %cid = '1' purchaserequisitiontype = 'NB' ) )
*        CREATE BY
*            \_purchaserequisitionitem
*        FIELDS
*            (
*                plant
**                purchaserequisitionitemtext
**                accountassignmentcategory
*                requestedquantity
**                baseunit
**                purchaserequisitionprice
**                purreqnitemcurrency
*                material
**                materialgroup
**                purchasinggroup
**                purchasingorganization
**                multipleacctassgmtdistribution
*            )
*        WITH VALUE
*            #( ( %cid_ref = '1' %target = VALUE #( ( %cid = '11'
**                                                     plant = '1010'
**                                                     purchaserequisitionitemtext = 'Sample Text'
**                                                     accountassignmentcategory = 'U'
*                                                     requestedquantity = '1'
**                                                     baseunit = 'EA'
**                                                     purchaserequisitionprice = '10.00'
**                                                     purreqnitemcurrency = 'EUR'
*                                                     material = 'TG10'
**                                                     materialgroup = 'L001'
**                                                     purchasinggroup = '001'
**                                                     purchasingorganization = '0010100088'
**                                                     multipleacctassgmtdistribution = ''
*                                                    ) ) ) )
**         ENTITY
**            purchaserequisitionitem
**         CREATE BY
**
**            \_purchasereqnacctassgmt
**         FIELDS
**            (   costcenter
**                glaccount
**                quantity
**                baseunit
**            )
**         WITH VALUE #(
**            (   %cid_ref = '11'  %target = VALUE #( ( %cid = '111'
**                                                                costcenter = ''
**                                                                glaccount = '0051600000'
**                                                                quantity = '3.00'
**                                                                baseunit = 'EA'
**                                                              )
**            ) ) )
**         CREATE BY
**            \_purchasereqndelivaddress
**         FIELDS
**            (   businesspartnername1
**                businesspartnername2
**                country
**                Region
**                PostalCode )
**         WITH VALUE #(
**            ( %cid_ref = '111' %target = VALUE #( ( %cid = '1111'
**                                                             businesspartnername1 = 'Name1'
**                                                             businesspartnername2 = 'Name2'
**                                                             country = 'DE'
**                                                             Region = 'BW'
**                                                             PostalCode = '69190' ) ) ) )
**         CREATE BY
**            \_purchasereqnitemtext
**         FIELDS
**            ( plainlongtext )
**         WITH VALUE
**            #(  ( %cid_ref = '1111'  %target = VALUE #(
**                    ( %cid = '11111'
**                      textobjecttype = 'B01'
**                      language = 'E'
**                      plainlongtext = 'item text 1'
**                    )
**                 )
**             )
**         )
*         REPORTED DATA(ls_reported)
*         MAPPED DATA(ls_mapped)
*         FAILED DATA(ls_failed).
*
*    COMMIT ENTITIES
*      RESPONSE OF i_purchaserequisitiontp
*          FAILED DATA(failed_commit)
*          REPORTED DATA(reported_commit).
*
*    DATA wa_purchaserequisition  LIKE LINE OF reported_commit-purchaserequisition.
*    DATA purchaseRequisition     LIKE wa_purchaserequisition-PurchaseRequisition.
*
*    LOOP AT reported_commit-purchaserequisition INTO wa_purchaserequisition.
*        IF ( wa_purchaserequisition-PurchaseRequisition IS NOT INITIAL ).
*            purchaseRequisition = wa_purchaserequisition-PurchaseRequisition.
*            EXIT.
*        ENDIF.
*    ENDLOOP.
*
*    IF ( purchaseRequisition IS INITIAL ).
*        out->write( 'Failed.' ). " output to console
*    ELSE.
*        DATA text TYPE string.
*        text = CONV string( purchaseRequisition ).
*        CONCATENATE 'A New Purchase Requisition' text 'has been created.' INTO text SEPARATED BY space.
*        out->write( text ). " output to console
*    ENDIF.

  ENDMETHOD.
ENDCLASS.

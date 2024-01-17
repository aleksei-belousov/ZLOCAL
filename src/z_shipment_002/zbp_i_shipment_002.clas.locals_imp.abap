CLASS lhc_shipment DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Shipment RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Shipment RESULT result.

    METHODS Activate FOR MODIFY
      IMPORTING keys FOR ACTION Shipment~Activate.

    METHODS Edit FOR MODIFY
      IMPORTING keys FOR ACTION Shipment~Edit.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION Shipment~Resume.

    METHODS retrieve FOR MODIFY
      IMPORTING keys FOR ACTION Shipment~retrieve.

    METHODS release FOR MODIFY
      IMPORTING keys FOR ACTION Shipment~release.

ENDCLASS. " lhc_shipment DEFINITION

CLASS lhc_shipment IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Activate.
  ENDMETHOD.

  METHOD Edit.
  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

* Retrieve Outbound Delivery
  METHOD retrieve.

    DATA it_available_create TYPE TABLE FOR CREATE zi_shipment_002\_Available.

*   read transfered instances
    READ ENTITIES OF zi_shipment_002 IN LOCAL MODE
      ENTITY Shipment
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

        IF ( <entity>-%is_draft = '00' ). " Saved
        ENDIF.

        IF ( <entity>-%is_draft = '01' ). " Draft
        ENDIF.

*       Read Available Table
        READ ENTITIES OF zi_shipment_002 IN LOCAL MODE
            ENTITY Shipment
            BY \_Available
            ALL FIELDS WITH VALUE #( (
                %tky = <entity>-%tky
            ) )
            RESULT DATA(lt_available)
            FAILED DATA(failed1)
            REPORTED DATA(reported1).

        SORT lt_available STABLE BY AvailableID.

*       Delete Actual Size Table
        LOOP AT lt_available INTO DATA(ls_available).
            MODIFY ENTITIES OF zi_shipment_002 IN LOCAL MODE
                ENTITY Available
                DELETE FROM VALUE #( ( %tky = ls_available-%tky ) )
                MAPPED DATA(mapped2)
                FAILED DATA(failed2)
                REPORTED DATA(reported2).
        ENDLOOP.

*       The use of CDS Entity I_COLLECTIVEPROCESSINGDOCUMENT is not permitted.
*        SELECT * FROM I_CollectiveProcessing\_CollectiveProcessingDocument AS Document INTO TABLE @DATA(lt_document).

*       Read Collective Processing
        READ ENTITIES OF ZI_CollectiveProcessing
            ENTITY CollectiveProcessing
            ALL FIELDS WITH VALUE #( ( CollectiveProcessing = '1' ) )
            RESULT DATA(lt_collective_processing)
            FAILED DATA(failed4)
            REPORTED DATA(reported4).

        DATA(sold_to_party)  = |{ <entity>-SoldToParty ALPHA = IN }|. " '0010100014'

*       Read Outbound Delivery
*        READ ENTITIES OF I_OutboundDeliveryTP
*            ENTITY OutboundDelivery
*            BY \_Partner
*            ALL FIELDS WITH VALUE #( ( OutboundDelivery = i_outboundDelivery ) )
*            RESULT DATA(lt_outbound_delivery)
*            FAILED DATA(failed)
*            REPORTED DATA(reported).

*       Read Outbound Delivery
        SELECT OutboundDelivery FROM I_OutboundDeliveryTP WHERE ( SoldToParty = @sold_to_party ) INTO TABLE @DATA(lt_outbound_delivery).

        SORT lt_outbound_delivery STABLE BY OutboundDelivery.

        LOOP AT lt_outbound_delivery INTO DATA(ls_outbound_delivery).
            APPEND VALUE #(
                %is_draft           = <entity>-%is_draft
                ShipmentUUID        = <entity>-ShipmentUUID
                %target = VALUE #( (
                    %is_draft           = <entity>-%is_draft
                    ShipmentUUID        = <entity>-ShipmentUUID
                    AvailableID         = sy-tabix
                    OutboundDelivery    = ls_outbound_delivery-OutboundDelivery
                ) )
            ) TO it_available_create.
        ENDLOOP.

*       Create Available Rows
        MODIFY ENTITIES OF zi_shipment_002 IN LOCAL MODE
            ENTITY Shipment CREATE BY \_Available
            AUTO FILL CID FIELDS (
*                AvailableUUID
                AvailableID
                ShipmentUUID
                OutboundDelivery
            )
            WITH it_available_create
            MAPPED DATA(mapped3)
            FAILED DATA(failed3)
            REPORTED DATA(reporeted3).

    ENDLOOP.

  ENDMETHOD. " retrieve

  METHOD release.
  ENDMETHOD.

ENDCLASS. " lhc_shipment IMPLEMENTATION


CLASS lsc_zi_shipment_002 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS. " lsc_zi_shipment_002 DEFINITION

CLASS lsc_zi_shipment_002 IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS. " lsc_zi_shipment_002 IMPLEMENTATION

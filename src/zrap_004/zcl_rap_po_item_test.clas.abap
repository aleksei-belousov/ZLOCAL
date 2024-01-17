CLASS zcl_rap_po_item_test DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  METHODS read_list.
  METHODS update_item.
ENDCLASS.



CLASS ZCL_RAP_PO_ITEM_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    read_list( ).
    update_item( ).
  ENDMETHOD. " if_oo_adt_classrun~main


  METHOD read_list. " Read List of PO Item

    DATA lt_business_data TYPE TABLE OF zrapi_purchaseorderitemapi01.
    DATA lo_http_client   TYPE REF TO if_web_http_client.
    DATA lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_request       TYPE REF TO /iwbep/if_cp_request_read_list.
    DATA lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

    TRY.

        DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://my403408.s4hana.cloud.sap' ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

        lo_http_client->accept_cookies( i_allow = abap_true ).

        lo_http_client->get_http_request( )->set_authorization_basic( i_username = 'INBOUND_USER' i_password = 'rtrVDDgelabtTjUiybRX}tVD3JksqqfvPpBdJRaL' ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
             EXPORTING
*                iv_do_fetch_csrf_token      = abap_true
                iv_service_definition_name  = 'ZSC_PURCHASEORDERITEM'
                io_http_client              = lo_http_client
                iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_PURCHASEORDERITEM_ODAT/' ).

        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERITEMAPI01' )->create_request_for_read( ).

        lo_request->set_top( 50 )->set_skip( 0 ).

        " Create the filter tree
        DATA filter_conditions  TYPE if_rap_query_filter=>tt_name_range_pairs .
*        DATA ranges_table1 TYPE if_rap_query_filter=>tt_range_option .
*        DATA ranges_table2 TYPE if_rap_query_filter=>tt_range_option .
        DATA ranges_table3 TYPE if_rap_query_filter=>tt_range_option .
*        ranges_table1 = VALUE #( (  sign = 'I' option = 'EQ' low = '4500000002' ) ).
*        ranges_table2 = VALUE #( (  sign = 'I' option = 'EQ' low = '20' ) ).
        ranges_table3 = VALUE #( (  sign = 'I' option = 'NE' low = 'L' ) ).
        filter_conditions = VALUE #(
*           ( name = 'PURCHASEORDER'                    range = ranges_table1 )
*           ( name = 'PURCHASEORDERITEM'                range = ranges_table2 )
            ( name = 'PURCHASINGDOCUMENTDELETIONCODE'   range = ranges_table3 )
        ).
        DATA filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory.
        DATA filter_node      TYPE REF TO /iwbep/if_cp_filter_node.
        DATA root_filter_node TYPE REF TO /iwbep/if_cp_filter_node.

        filter_factory = lo_request->create_filter_factory( ).
        LOOP AT filter_conditions INTO DATA(filter_condition).
          filter_node = filter_factory->create_by_range( iv_property_path     = filter_condition-name
                                                                 it_range     = filter_condition-range ).
          IF root_filter_node IS INITIAL.
            root_filter_node = filter_node.
          ELSE.
            root_filter_node = root_filter_node->and( filter_node ).
          ENDIF.
        ENDLOOP.

        IF root_filter_node IS NOT INITIAL.
          lo_request->set_filter( root_filter_node ).
        ENDIF.

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).

        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

    CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
      " Handle remote Exception
*      RAISE SHORTDUMP lx_remote.

    CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
      " Handle Exception
*      RAISE SHORTDUMP lx_gateway.

    CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
      " Handle Exception
*      RAISE SHORTDUMP lx_web_http_client_error.

    CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        "handle exception
*      RAISE SHORTDUMP lx_http_dest_provider_error.

    ENDTRY.

  ENDMETHOD. " read_list


  METHOD update_item.

    DATA ls_key_data        TYPE zrapi_purchaseorderitemapi01.
    DATA ls_business_data   TYPE zrapi_purchaseorderitemapi01.
    DATA lo_client_proxy    TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_request1        TYPE REF TO /iwbep/if_cp_request_read.
    DATA lo_response1       TYPE REF TO /iwbep/if_cp_response_read.
    DATA lo_request2        TYPE REF TO /iwbep/if_cp_request_update.
    DATA lo_response2       TYPE REF TO /iwbep/if_cp_response_update.
    DATA lo_http_client     TYPE REF TO if_web_http_client.

    TRY.

        DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://my403408.s4hana.cloud.sap' ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

        lo_http_client->accept_cookies( i_allow = abap_true ).

        lo_http_client->get_http_request( )->set_authorization_basic( i_username = 'INBOUND_USER' i_password = 'rtrVDDgelabtTjUiybRX}tVD3JksqqfvPpBdJRaL' ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
*                iv_do_fetch_csrf_token      = abap_true
                iv_service_definition_name  = 'ZSC_PURCHASEORDERITEM'
                io_http_client              = lo_http_client
                iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_PURCHASEORDERITEM_ODAT/'
        ).

*       Prepare key data (matrix)
        ls_key_data = VALUE #(
            PurchaseOrder                      = '4500000002'
            PurchaseOrderItem                  = '30'
*            IsActiveEntity                  = abap_true
        ).

        " Navigate to the resource
        lo_request1 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERITEMAPI01' )->navigate_with_key( ls_key_data )->create_request_for_read( ).

        " Execute the request (READ) and retrieve the business data
        lo_response1 = lo_request1->execute( ).

        " Get business data
        lo_response1->get_business_data( IMPORTING es_business_data = ls_business_data ).

        ls_business_data-PurchaseContract          = '4600000000'. " '4600000000'.
        ls_business_data-PurchaseContractITem      = '10'. " '10'.

        " Navigate to the resource
        lo_request2 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERITEMAPI01' )->navigate_with_key( ls_key_data )->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-put ).

        " Set the business data for the created entity
        lo_request2->set_business_data( ls_business_data ).

        " Execute the request (UPDATE)
        lo_response2 = lo_request2->execute( ).

        " Get the after image
*        lo_response2->get_business_data( IMPORTING es_business_data = ls_business_data ).

    CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
      " Handle remote Exception
*      RAISE SHORTDUMP lx_remote.

    CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
      " Handle Exception
*      RAISE SHORTDUMP lx_gateway.

    CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
      " Handle Exception
*      RAISE SHORTDUMP lx_web_http_client_error.

    CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        "handle exception
*      RAISE SHORTDUMP lx_http_dest_provider_error.

    ENDTRY.

  ENDMETHOD. " update_item
ENDCLASS.

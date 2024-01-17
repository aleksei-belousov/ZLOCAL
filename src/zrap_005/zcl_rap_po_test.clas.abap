CLASS zcl_rap_po_test DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  METHODS read_list.
  METHODS update_po.
  METHODS update_po_by_patch.
  METHODS update_item.
ENDCLASS.



CLASS ZCL_RAP_PO_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    read_list( ).
    update_po( ).
*    update_item( ).
  ENDMETHOD.


  METHOD read_list. " Read List of PO

    DATA lt_business_data TYPE TABLE OF zrap_i_purchaseorderapi01.
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
                iv_service_definition_name  = 'ZSC_PURCHASEORDER'
                io_http_client              = lo_http_client
                iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_PURCHASEORDER_ODATA/' ).

        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERAPI01' )->create_request_for_read( ).

        lo_request->set_top( 50 )->set_skip( 0 ).

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


  METHOD update_item. " Update PO Item

    DATA ls_key_data        TYPE zrap_i_purchaseorderapi01.
    DATA ls_business_data   TYPE zrap_i_purchaseorderapi01.
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
                iv_service_definition_name  = 'ZSC_PURCHASEORDER'
                io_http_client              = lo_http_client
                iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_PURCHASEORDER_ODATA/'
        ).

*       Prepare key data (matrix)
        ls_key_data = VALUE #(
            PurchaseOrder                      = '4500000002'
*            IsActiveEntity                  = abap_true
        ).

        " Navigate to the resource
        lo_request1 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERAPI01' )->navigate_with_key( ls_key_data )->create_request_for_read( ).

        " Execute the request (READ) and retrieve the business data
        lo_response1 = lo_request1->execute( ).

        " Get business data
        lo_response1->get_business_data( IMPORTING es_business_data = ls_business_data ).

*        ls_business_data-PurchaseContract          = '4600000000'. " '4600000000'.
*        ls_business_data-PurchaseContractITem      = '10'. " '10'.
        ls_business_data-IncotermsLocation1         = 'AAAA'. " 'AAAA'.
        ls_business_data-IncotermsLocation1_vc      = abap_true.

        " Navigate to the resource
        lo_request2 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERAPI01' )->navigate_with_key( ls_key_data )->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-put ).

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


  METHOD update_po. " Update PO Header

    DATA ls_key_data        TYPE zrap_i_purchaseorderapi01.
    DATA ls_business_data   TYPE zrap_i_purchaseorderapi01.
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
                iv_service_definition_name  = 'ZSC_PURCHASEORDER'
                io_http_client              = lo_http_client
                iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_PURCHASEORDER_ODATA/'
        ).

*       Prepare key data (matrix)
        ls_key_data = VALUE #(
            PurchaseOrder                      = '4500000002'
*            IsActiveEntity                  = abap_true
        ).

        " Navigate to the resource
        lo_request1 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERAPI01' )->navigate_with_key( ls_key_data )->create_request_for_read( ).

        " Execute the request (READ) and retrieve the business data
        lo_response1 = lo_request1->execute( ).

        " Get business data
        lo_response1->get_business_data( IMPORTING es_business_data = ls_business_data ).

*        ls_business_data-PurchaseContract          = '4600000000'. " '4600000000'.
*        ls_business_data-PurchaseContractITem      = '10'. " '10'.
        ls_business_data-IncotermsLocation1         = 'AAAA'. " 'AAAA'.
        ls_business_data-IncotermsLocation1_vc      = abap_true.

        " Navigate to the resource
        lo_request2 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERAPI01' )->navigate_with_key( ls_key_data )->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-put ).
*        lo_request2 = lo_client_proxy->create_resource_for_entity_set( 'I_PURCHASEORDERAPI01' )->navigate_with_key( ls_key_data )->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).

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

  ENDMETHOD. " update_po


  METHOD update_po_by_patch.

*    TYPES:  BEGIN OF tys_patch_data,
*                age        TYPE i,
*                is_manager TYPE abap_bool,
*                status     TYPE string,
*            END OF tys_patch_data.
*
*    DATA:    lo_client_proxy    TYPE REF TO /iwbep/if_cp_client_proxy,
*              lo_update_request  TYPE REF TO /iwbep/if_cp_request_update,
*              lo_update_response TYPE REF TO /iwbep/if_cp_response_update,
*              lo_entity_resource TYPE REF TO /iwbep/if_cp_resource_entity,
*              ls_patch_data      TYPE tys_patch_data,
*              ls_employee        TYPE /iwbep/s_v4_tea_employee.
*
*              lo_entity_resource = lo_client_proxy->create_resource_for_entity_set( 'EMPLOYEES')->navigate_with_key( value /iwbep/if_v4_tea_busi_types=>ty_s_employee_key( id = '007') ).
*              lo_update_request = lo_entity_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).
*
*              ls_patch_data = VALUE #( age = 38
*                is_manager = abap_true
*                status = 'Available' ).
*
*              lo_update_request->set_business_data(
*                is_business_data = ls_patch_data
*                it_provided_property = VALUE #(
*                    ( |AGE| )
*                    ( |IS_MANAGER| )
*                    ( |STATUS| )
*                )
*              ).
*
*              lo_update_request->set_if_match( '1234' ).
*              lo_update_response = lo_update_request->execute( ).
*              lo_update_response->get_business_data( IMPORTING es_business_data = ls_employee ).

  ENDMETHOD. " update_po_by_patch
ENDCLASS.

CLASS zcl_ce_rap_simple_005 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

*   Internal Methods:

    TYPES t_business_data1 TYPE TABLE OF zrap_001z_travel_agency_es5.

    METHODS get_agencies
      IMPORTING
        filter_cond        TYPE if_rap_query_filter=>tt_name_range_pairs   OPTIONAL
        top                TYPE i OPTIONAL
        skip               TYPE i OPTIONAL
        is_data_requested  TYPE abap_bool
        is_count_requested TYPE abap_bool
      EXPORTING
        business_data      TYPE t_business_data1
        count              TYPE int8
      RAISING
        /iwbep/cx_cp_remote
        /iwbep/cx_gateway
        cx_web_http_client_error
        cx_http_dest_provider_error.

    TYPES t_business_data2 TYPE TABLE OF zrap_002zc_simple_005.

    METHODS get_simples
      IMPORTING
        filter_cond        TYPE if_rap_query_filter=>tt_name_range_pairs OPTIONAL
        top                TYPE i OPTIONAL
        skip               TYPE i OPTIONAL
        is_data_requested  TYPE abap_bool
        is_count_requested TYPE abap_bool
      EXPORTING
        business_data      TYPE t_business_data2
        count              TYPE int8
      RAISING
        /iwbep/cx_cp_remote
        /iwbep/cx_gateway
        cx_web_http_client_error
        cx_http_dest_provider_error.

    METHODS get_all.

*   Local Serivce
    METHODS read_list.

    METHODS create_simple.

    METHODS read_simple.

    METHODS update_simple.

    METHODS delete_simple.

*   Remote (External) Service
    METHODS create_simple_remote.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_CE_RAP_SIMPLE_005 IMPLEMENTATION.


  METHOD create_simple. " Create Simple

    DATA  ls_business_data TYPE zrap_002zc_simple_005.
    DATA  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA  lo_request       TYPE REF TO /iwbep/if_cp_request_create.
    DATA  lo_response      TYPE REF TO /iwbep/if_cp_response_create.

    TRY.

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
            is_service_key = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )

        ).

*       Prepare business data
        ls_business_data = VALUE #(
*            uuid      = '11112222333344445555666677778888'
*            v_uuid   = 'VUuid'
            id        = 'Id'
            Id_vc     = 'VId'
            data1     = 'Data1'
            data1_vc  = 'VData1'
            data2     = 'Data2'
            data2_vc  = 'VData2'
            data3     = 'Data3'
            data3_vc  = 'VData3'
        ).

        " Navigate to the resource and create a request for the create operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->create_request_for_create( ).

        " Set the business data for the created entity
        lo_request->set_business_data( ls_business_data ).

        " Execute the request
        lo_response = lo_request->execute( ).

    CATCH /iwbep/cx_gateway.
        "handle exception

    ENDTRY.

  ENDMETHOD. " create_simple


  METHOD create_simple_remote.

    DATA  ls_business_data TYPE zrap_002zc_simple_005.
    DATA  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA  lo_request       TYPE REF TO /iwbep/if_cp_request_create.
    DATA  lo_response      TYPE REF TO /iwbep/if_cp_response_create.

    TRY.

        DATA service_consumption_name TYPE cl_web_odata_client_factory=>ty_service_definition_name.

        DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://my403408.s4hana.cloud.sap' ).

        DATA(http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

        service_consumption_name = to_upper( 'ZSC_SIMPLE_005' ).

        http_client->accept_cookies( i_allow = abap_true ).

        http_client->get_http_request( )->set_authorization_basic( i_username = 'INBOUND_USER' i_password = 'rtrVDDgelabtTjUiybRX}tVD3JksqqfvPpBdJRaL' ).

*       Yet it works (probably)
        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
             EXPORTING
*                iv_do_fetch_csrf_token      = abap_true
                iv_service_definition_name  = service_consumption_name
                io_http_client              = http_client
                iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_SIMPLE_005_ODATA/' ).

*        lo_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
*            is_service_key = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )
*
*        ).

*       Prepare business data
        ls_business_data = VALUE #(
*            uuid      = '11112222333344445555666677778888'
*            v_uuid   = 'VUuid'
            id        = 'Id'
            Id_vc     = 'VId'
            data1     = 'RRR1'
            data1_vc  = 'VData1'
            data2     = 'RRR2'
            data2_vc  = 'VData2'
            data3     = 'RRR3'
            data3_vc  = 'VData3'
        ).

        " Navigate to the resource and create a request for the create operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->create_request_for_create( ).

        " Set the business data for the created entity
        lo_request->set_business_data( ls_business_data ).

        " Execute the request
        lo_response = lo_request->execute( ).

    CATCH /iwbep/cx_gateway.
        "handle exception

    CATCH cx_http_dest_provider_error.
        "handle exception

    CATCH cx_web_http_client_error.
        "handle exception

    ENDTRY.

  ENDMETHOD. " create_simple_remote


  METHOD delete_simple. " Delete Simple

    DATA  ls_entity_key    TYPE ZRAP_002ZC_SIMPLE_005.
    DATA  ls_business_data TYPE ZRAP_002ZC_SIMPLE_005.
    DATA  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity.
    DATA  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA  lo_request       TYPE REF TO /iwbep/if_cp_request_delete.

    TRY.

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
            is_service_key = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )
        ).

        "Set entity key
*        ls_entity_key = VALUE #(  uuid  = '11112222333344445555666677778888' ).
        ls_entity_key = VALUE #( uuid  = '1FE2EDE938161EEE92E3CA98E4C96412' ).

        "Navigate to the resource and create a request for the delete operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_delete( ).

        " Execute the request
        lo_request->execute( ).

    CATCH /iwbep/cx_gateway.
        "handle exception

    ENDTRY.

  ENDMETHOD. " delete_simple


  METHOD get_agencies.

    DATA: filter_factory        TYPE REF TO /iwbep/if_cp_filter_factory,
          filter_node           TYPE REF TO /iwbep/if_cp_filter_node,
          root_filter_node      TYPE REF TO /iwbep/if_cp_filter_node.

    DATA: http_client           TYPE REF TO if_web_http_client,
          odata_client_proxy    TYPE REF TO /iwbep/if_cp_client_proxy,
          read_list_request     TYPE REF TO /iwbep/if_cp_request_read_list,
          read_list_response    TYPE REF TO /iwbep/if_cp_response_read_lst.

    DATA service_consumption_name TYPE cl_web_odata_client_factory=>ty_service_definition_name.

    DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sapes5.sapdevcenter.com' ).
    http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

    service_consumption_name = to_upper( 'ZSC_RAP_AGENCY_001' ).

    odata_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
      EXPORTING
        iv_service_definition_name = service_consumption_name
        io_http_client             = http_client
        iv_relative_service_root   = '/sap/opu/odata/sap/ZAGENCYCDS_SRV/' ).

    " Navigate to the resource and create a request for the read operation
    read_list_request = odata_client_proxy->create_resource_for_entity_set( 'Z_TRAVEL_AGENCY_ES5' )->create_request_for_read( ).

    " Create the filter tree
    filter_factory = read_list_request->create_filter_factory( ).
    LOOP AT  filter_cond  INTO DATA(filter_condition).
      filter_node  = filter_factory->create_by_range( iv_property_path     = filter_condition-name
                                                              it_range     = filter_condition-range ).
      IF root_filter_node IS INITIAL.
        root_filter_node = filter_node.
      ELSE.
        root_filter_node = root_filter_node->and( filter_node ).
      ENDIF.
    ENDLOOP.

    IF root_filter_node IS NOT INITIAL.
      read_list_request->set_filter( root_filter_node ).
    ENDIF.

    IF is_data_requested = abap_true.
      read_list_request->set_skip( skip ).
      IF top > 0 .
        read_list_request->set_top( top ).
      ENDIF.
    ENDIF.

    IF is_count_requested = abap_true.
      read_list_request->request_count(  ).
    ENDIF.

    IF is_data_requested = abap_false.
      read_list_request->request_no_business_data(  ).
    ENDIF.

    " Execute the request and retrieve the business data and count if requested
    read_list_response = read_list_request->execute( ).
    IF is_data_requested = abap_true.
      read_list_response->get_business_data( IMPORTING et_business_data = business_data ).
    ENDIF.
    IF is_count_requested = abap_true.
      count = read_list_response->get_count(  ).
    ENDIF.

  ENDMETHOD. " get_agencies


  METHOD get_all.

*    Remote services:
*    TRY.
*        DATA business_data1 TYPE t_business_data1.
*        DATA count1 TYPE int8.
*        get_agencies(
*          EXPORTING
*            is_count_requested = abap_true
*            is_data_requested  = abap_true
*          IMPORTING
*            business_data  = business_data1
*            count          = count1
*          ) .
*        out->write( |Total number of records = { count1 }| ) .
*        out->write( business_data1 ).
*      CATCH cx_root INTO DATA(exception1).
*        out->write( cl_message_helper=>get_latest_t100_exception( exception1 )->if_message~get_longtext( ) ).
**         APPEND VALUE #( %key = <entity>-%key %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = cl_message_helper=>get_latest_t100_exception( exception1 )->if_message~get_longtext( ) ) ) TO reported-matrix.
*    ENDTRY.

*    TRY.
*        DATA business_data2 TYPE t_business_data2.
*        DATA count2 TYPE int8.
*        get_simples(
*          EXPORTING
*            is_count_requested = abap_true
*            is_data_requested  = abap_true
*          IMPORTING
*            business_data  = business_data2
*            count          = count2
*          ) .
*        out->write( |Total number of records = { count2 }| ) .
*        out->write( business_data2 ).
*      CATCH cx_root INTO DATA(exception2).
*        out->write( cl_message_helper=>get_latest_t100_exception( exception2 )->if_message~get_longtext( ) ).
*    ENDTRY.

  ENDMETHOD. " get_all


  METHOD get_simples.

    DATA: filter_factory        TYPE REF TO /iwbep/if_cp_filter_factory,
          filter_node           TYPE REF TO /iwbep/if_cp_filter_node,
          root_filter_node      TYPE REF TO /iwbep/if_cp_filter_node.

    DATA: http_client           TYPE REF TO if_web_http_client,
          odata_client_proxy    TYPE REF TO /iwbep/if_cp_client_proxy,
          read_list_request     TYPE REF TO /iwbep/if_cp_request_read_list,
          read_list_response    TYPE REF TO /iwbep/if_cp_response_read_lst.

    DATA service_consumption_name TYPE cl_web_odata_client_factory=>ty_service_definition_name.

    DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://my403408.s4hana.cloud.sap' ).

*     DATA(http_destination) = cl_http_destination_provider=>create_by_cloud_destination(
*                                   i_name                  = ''
**                               i_service_instance_name =
*                                   i_authn_mode            = if_a4c_cp_service=>service_specific
*                                 ).

    http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

    service_consumption_name = to_upper( 'ZSC_SIMPLE_005' ).

**   Set Session Cookies
*    http_client->get_http_request( )->set_header_field( i_name = 'x-csrf-token' i_value = 'fetch' ).
*    DATA(http_response) = http_client->execute( i_method = if_web_http_client=>get ).
*    DATA(cookies)  = http_response->get_cookies(  ).
*    DATA(header)   = http_response->get_header_fields(  ).
*    DATA(body)     = http_response->get_text(  ).
*
*   LOOP AT cookies ASSIGNING FIELD-SYMBOL(<cookie>).
*        i_name      = <cookie>-        "'SAP_SESSIONID_X1K_080'
*        i_value     = <cookie>-        "'4taPzgfI6ubu8Y2wLn_yaBK3fRhK9hHushYf4u3pOBY%3d'
*        i_domain    = <cookie>-domain  " 'my403408.s4hana.cloud.sap'
*        i_path      = <cookie>-        "'/'
*        i_secure    = <cookie>-secure  " 1
*        i_expires   = <cookie>-        "'Tue, 03 Sep 2024 07:48:34 GMT'
*    ).
*   ENDLOOP.

    http_client->accept_cookies( i_allow = abap_true ).
*    http_client->get_http_request( )->set_cookie(
*        i_name      = 'SAP_SESSIONID_X1K_080'
*        i_value     = 'R4FayQ9MBiQPvn_OMOx7leHAcpVLyxHupiAf4u3pOBY%3d'
**        i_domain    = 'my403408.s4hana.cloud.sap'
**        i_path      = '/'
**        i_secure    = <cookie>-secure " 1
**        i_expires   = 'Tue, 03 Sep 2024 07:48:34 GMT'
*    ).

*    http_client->get_http_request( )->set_header_field( i_name = 'Cookie' i_value = 'SAP_SESSIONID_X1K_080=R4FayQ9MBiQPvn_OMOx7leHAcpVLyxHupiAf4u3pOBY%3d' ).
**    http_client->get_http_request( )->set_header_field( i_name = if_web_http_header=>accept i_value = if_web_http_header=>accept_application_json ).
**    http_client->get_http_request( )->set_header_field( i_name = if_web_http_header=>content_type i_value = if_web_http_header=>accept_application_json ).
**    http_client->get_http_request( )->set_header_field( i_name = if_web_http_header=>content_type i_value = if_web_http_header=>accept_application_json ).

*    http_client->get_http_request( )->set_header_field( i_name = 'Authorization' i_value = 'Basic SU5CT1VORF9VU0VSOnJ0clZERGdlbGFidFRqVWl5YlJYfXRWRDNKa3NxcWZ2UHBCZEpSYUw=' ).
    http_client->get_http_request( )->set_authorization_basic( i_username = 'INBOUND_USER' i_password = 'rtrVDDgelabtTjUiybRX}tVD3JksqqfvPpBdJRaL' ).

*   It does not work
    odata_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
         EXPORTING
*            iv_do_fetch_csrf_token      = abap_true
            iv_service_definition_name  = service_consumption_name
            io_http_client              = http_client
            iv_relative_service_root    = '/sap/opu/odata/sap/ZSB_SIMPLE_005_ODATA/' ).


*   It works for local odata services (if @AccessControl.authorizationCheck: #CHECK)
*    odata_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
*         EXPORTING
*            is_service_key  = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )
*    ).

    " Navigate to the resource and create a request for the read operation
    read_list_request = odata_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->create_request_for_read( ).

    " Create the filter tree
    filter_factory = read_list_request->create_filter_factory( ).
    LOOP AT  filter_cond  INTO DATA(filter_condition).
      filter_node  = filter_factory->create_by_range( iv_property_path     = filter_condition-name
                                                              it_range     = filter_condition-range ).
      IF root_filter_node IS INITIAL.
        root_filter_node = filter_node.
      ELSE.
        root_filter_node = root_filter_node->and( filter_node ).
      ENDIF.
    ENDLOOP.

    IF root_filter_node IS NOT INITIAL.
      read_list_request->set_filter( root_filter_node ).
    ENDIF.

    IF is_data_requested = abap_true.
      read_list_request->set_skip( skip ).
      IF top > 0 .
        read_list_request->set_top( top ).
      ENDIF.
    ENDIF.

    IF is_count_requested = abap_true.
      read_list_request->request_count(  ).
    ENDIF.

    IF is_data_requested = abap_false.
      read_list_request->request_no_business_data(  ).
    ENDIF.

*   Test

    " Execute the request and retrieve the business data and count if requested
    read_list_response = read_list_request->execute( ).

    IF is_data_requested = abap_true.
      read_list_response->get_business_data( IMPORTING et_business_data = business_data ).
    ENDIF.
    IF is_count_requested = abap_true.
      count = read_list_response->get_count(  ).
    ENDIF.

  ENDMETHOD. " get_simples


  METHOD if_oo_adt_classrun~main.

*    Local services:
*    me->read_list(  ).
*    me->create_simple(  ).
*    me->read_simple(  ).
*    me->update_simple(  ).
*    me->delete_simple(  ).

*   Remote (external) services:
    me->create_simple_remote(  ).

  ENDMETHOD. " if_oo_adt_classrun~main


  METHOD read_list. " Read List of Simples

    DATA lt_business_data TYPE TABLE OF ZRAP_002ZC_SIMPLE_005.
    DATA lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_request       TYPE REF TO /iwbep/if_cp_request_read_list.
    DATA lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

    TRY.

*       It works only if @AccessControl.authorizationCheck = #CHECK
        lo_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
            is_service_key = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )
        ).

        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->create_request_for_read( ).

        lo_request->set_top( 50 )->set_skip( 0 ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

    CATCH /iwbep/cx_gateway.
        "handle exception

    ENDTRY.

  ENDMETHOD. " read_list


  METHOD read_simple. " Read Simple

    DATA ls_entity_key      TYPE zrap_002zc_simple_005.
    DATA ls_business_data   TYPE zrap_002zc_simple_005.
    DATA lo_resource        TYPE REF TO /iwbep/if_cp_resource_entity.
    DATA lo_client_proxy    TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_request         TYPE REF TO /iwbep/if_cp_request_read.
    DATA lo_response        TYPE REF TO /iwbep/if_cp_response_read.

    TRY.

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
            is_service_key = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )
        ).

        " Set entity key
*        ls_entity_key = VALUE #( uuid  = '11112222333344445555666677778888' ).
        ls_entity_key = VALUE #( uuid  = '1FE2EDE938161EEE92E3CA98E4C96412' ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).

        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

    CATCH /iwbep/cx_gateway.
        "handle exception

    ENDTRY.

  ENDMETHOD. " read_simple


  METHOD update_simple.

    DATA ls_entity_key      TYPE zrap_002zc_simple_005.
    DATA ls_business_data   TYPE zrap_002zc_simple_005.
    DATA lo_resource        TYPE REF TO /iwbep/if_cp_resource_entity.
    DATA lo_client_proxy    TYPE REF TO /iwbep/if_cp_client_proxy.
    DATA lo_request         TYPE REF TO /iwbep/if_cp_request_update.
    DATA lo_response        TYPE REF TO /iwbep/if_cp_response_update.

    TRY.

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_local_proxy(
            is_service_key = VALUE #( service_id = 'ZSB_SIMPLE_005_ODATA' service_version = '0001' )
        ).

        " Set entity key
*        ls_entity_key = VALUE #( uuid  = '11112222333344445555666677778888' ).
        ls_entity_key = VALUE #( uuid  = '1FE2EDE938161EEE92E3CA98E4C96412' ).

*       Prepare business data
        ls_business_data = VALUE #(
*            uuid      = '11112222333344445555666677778888'
*            v_uuid   = 'VUuid'
            id        = 'Id1111'
            Id_vc     = 'VId'
            data1     = 'Data1'
            data1_vc  = 'VData1'
            data2     = 'Data2'
            data2_vc  = 'VData2'
            data3     = 'Data3'
            data3_vc  = 'VData3'
        ).

        " Navigate to the resource and create a request for the update operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-put ).


        lo_request->set_business_data( ls_business_data ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).

    CATCH /iwbep/cx_gateway.
        "handle exception

    ENDTRY.

  ENDMETHOD. " update_simple
ENDCLASS.

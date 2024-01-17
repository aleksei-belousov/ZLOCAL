"!@testing SRVB:ZSB_SIMPLE_005_ODATA
CLASS ltc_CREATE DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

PRIVATE SECTION.


METHODS: SETUP RAISING cx_static_check,
 CREATE FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_CREATE IMPLEMENTATION.


METHOD CREATE.
DATA:
  ls_business_data TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_create,
  lo_response      TYPE REF TO /iwbep/if_cp_response_create.


lo_client_proxy = /iwbep/cl_cp_factory_unit_tst=>create_v2_local_proxy(
                EXPORTING
                  is_service_key     = VALUE #( service_id      = 'ZSB_SIMPLE_005_ODATA'
                                                service_version = '0001' )
                   iv_do_write_traces = abap_true ).


* Prepare business data
ls_business_data = VALUE #(
          uuid     = '11112222333344445555666677778888'
*          v_uuid   = 'VUuid'
          id       = 'Id'
*          v_id     = 'VId'
          data1    = 'Data1'
*          v_data1  = 'VData1'
          data2    = 'Data2'
*          v_data2  = 'VData2'
          data3    = 'Data3'
*          v_data3  = 'VData3'
).

" Navigate to the resource and create a request for the create operation
lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->create_request_for_create( ).

" Set the business data for the created entity
lo_request->set_business_data( ls_business_data ).

" Execute the request
lo_response = lo_request->execute( ).

" Get the after image
*lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

cl_abap_unit_assert=>fail( 'Implement your assertions' ).
ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

ENDCLASS.

"!@testing SRVB:ZSB_SIMPLE_005_ODATA
CLASS ltc_READ_ENTITY DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

PRIVATE SECTION.


METHODS: SETUP RAISING cx_static_check,
 READ_ENTITY FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_READ_ENTITY IMPLEMENTATION.


METHOD READ_ENTITY.
DATA:
  ls_entity_key    TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  ls_business_data TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read.



     lo_client_proxy = /iwbep/cl_cp_factory_unit_tst=>create_v2_local_proxy(
                     EXPORTING
                       is_service_key     = VALUE #( service_id      = 'ZSB_SIMPLE_005_ODATA'

                                                     service_version = '0001' )
                        iv_do_write_traces = abap_true ).


" Set entity key
ls_entity_key = VALUE #(
          uuid  = '11112222333344445555666677778888' ).

" Navigate to the resource
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->navigate_with_key( ls_entity_key ).

" Execute the request and retrieve the business data
lo_response = lo_resource->create_request_for_read( )->execute( ).
lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

cl_abap_unit_assert=>fail( 'Implement your assertions' ).
ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

ENDCLASS.

"!@testing SRVB:ZSB_SIMPLE_005_ODATA
CLASS ltc_READ_LIST DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

PRIVATE SECTION.


METHODS: SETUP RAISING cx_static_check,
 READ_LIST FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_READ_LIST IMPLEMENTATION.


METHOD READ_LIST.
DATA:
  lt_business_data TYPE TABLE OF ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
  lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

*DATA:
* lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
* lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
* lt_range_UUID TYPE RANGE OF sysuuid_x16,
* lt_range_V_UUID TYPE RANGE OF sadl_gw_value_crtl_property.



     lo_client_proxy = /iwbep/cl_cp_factory_unit_tst=>create_v2_local_proxy(
                     EXPORTING
                        is_service_key     = VALUE #( service_id      = 'ZSB_SIMPLE_005_ODATA'
                                                     service_version = '0001' )
                        iv_do_write_traces = abap_true ).


" Navigate to the resource and create a request for the read operation
lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->create_request_for_read( ).

" Create the filter tree
*lo_filter_factory = lo_request->create_filter_factory( ).
*
*lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'UUID'
*                                                        it_range             = lt_range_UUID ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'V_UUID'
*                                                        it_range             = lt_range_V_UUID ).

*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
*lo_request->set_filter( lo_filter_node_root ).

lo_request->set_top( 50 )->set_skip( 0 ).

" Execute the request and retrieve the business data
lo_response = lo_request->execute( ).
lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

*cl_abap_unit_assert=>fail( 'Implement your assertions' ).

ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

ENDCLASS.

"!@testing SRVB:ZSB_SIMPLE_005_ODATA
CLASS ltc_UPDATE DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

PRIVATE SECTION.


METHODS: SETUP RAISING cx_static_check,
 UPDATE FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_UPDATE IMPLEMENTATION.


METHOD UPDATE.
DATA:
  ls_business_data TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  ls_entity_key    TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_request       TYPE REF TO /iwbep/if_cp_request_update,
  lo_response      TYPE REF TO /iwbep/if_cp_response_update.



lo_client_proxy = /iwbep/cl_cp_factory_unit_tst=>create_v2_local_proxy(
                EXPORTING
                  is_service_key     = VALUE #( service_id      = 'ZSB_SIMPLE_005_ODATA'

                                                service_version = '0001' )
                   iv_do_write_traces = abap_true ).


" Set entity key
ls_entity_key = VALUE #(
          uuid  = '11112222333344445555666677778888' ).

" Prepare the business data
ls_business_data = VALUE #(
          uuid     = '11112222333344445555666677778888'
*          v_uuid   = 'VUuid'
          id       = 'Id'
*          v_id     = 'VId'
          data1    = 'Data1'
*          v_data1  = 'VData1'
          data2    = 'Data2'
*          v_data2  = 'VData2'
          data3    = 'Data3'
*          v_data3  = 'VData3'
).

" Navigate to the resource and create a request for the update operation
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->navigate_with_key( ls_entity_key ).
lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-put ).


lo_request->set_business_data( ls_business_data ).

" Execute the request and retrieve the business data
lo_response = lo_request->execute( ).

" Get updated entity
*CLEAR ls_business_data.
*lo_response->get_business_data( importing es_business_data = ls_business_data ).
cl_abap_unit_assert=>fail( 'Implement your assertions' ).
ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

ENDCLASS.

"!@testing SRVB:ZSB_SIMPLE_005_ODATA
CLASS ltc_DELETE_ENTITY DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

PRIVATE SECTION.


METHODS: SETUP RAISING cx_static_check,
 DELETE_ENTITY FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_DELETE_ENTITY IMPLEMENTATION.


METHOD DELETE_ENTITY.
DATA:
  ls_entity_key    TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  ls_business_data TYPE ZRAP_002ZC_SIMPLE_005, "<structure_name>,
  lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
  lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
  lo_request       TYPE REF TO /iwbep/if_cp_request_delete.


     lo_client_proxy = /iwbep/cl_cp_factory_unit_tst=>create_v2_local_proxy(
                     EXPORTING
                       is_service_key     = VALUE #( service_id      = 'ZSB_SIMPLE_005_ODATA'

                                                     service_version = '0001' )
                        iv_do_write_traces = abap_true ).


"Set entity key
ls_entity_key = VALUE #(
          uuid  = '11112222333344445555666677778888' ).

"Navigate to the resource and create a request for the delete operation
lo_resource = lo_client_proxy->create_resource_for_entity_set( 'ZC_SIMPLE_005' )->navigate_with_key( ls_entity_key ).
lo_request = lo_resource->create_request_for_delete( ).


" Execute the request
lo_request->execute( ).

cl_abap_unit_assert=>fail( 'Implement your assertions' ).
ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

ENDCLASS.

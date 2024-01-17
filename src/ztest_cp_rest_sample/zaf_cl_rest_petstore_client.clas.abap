CLASS zaf_cl_rest_petstore_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    METHODS CONSTRUCTOR raising /iwbep/cx_gateway.

    METHODS pet_create
      IMPORTING
        is_pet        TYPE zaf_if_petstore_types=>tys_pet
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.


    METHODS pet_delete
      IMPORTING
        iv_id                      TYPE  i
      RETURNING
        VALUE(rv_http_status_code) TYPE i
      RAISING
        /iwbep/cx_gateway.


    METHODS pet_read_by_id
      IMPORTING
        iv_id         TYPE  i
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.


    METHODS pet_update
      IMPORTING
        is_pet        TYPE zaf_if_petstore_types=>tys_pet
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.


    "! <p class="shorttext synchronized" lang="en">Update the name and status of the pet having the supplied ID</p>
    "! The variables to be updated are sent as query parameters. The request type is POST
    "! @parameter iv_id | <p class="shorttext synchronized" lang="en">ID of the pet that is to be updated.</p>
    "! @parameter iv_name | <p class="shorttext synchronized" lang="en">new name for the pet</p>
    "! @parameter iv_status | <p class="shorttext synchronized" lang="en">new status for the pet</p>
    "! @parameter rs_pet | <p class="shorttext synchronized" lang="en">Updated pet </p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en"></p>
    METHODS pet_update_name_and_status
      IMPORTING
        iv_id         TYPE  i
        iv_name       TYPE  zaf_if_petstore_types=>tys_pet-name
        iv_status     TYPE  zaf_if_petstore_types=>tys_pet-status
      RETURNING
        VALUE(rs_pet) TYPE zaf_if_petstore_types=>tys_pet
      RAISING
        /iwbep/cx_gateway.

PRIVATE SECTION.

  DATA: mo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy.
*       mo_http_client   TYPE REF TO if_http_client.

  METHODS create_client_proxy
    RETURNING
      VALUE(ro_client_proxy) TYPE REF TO /iwbep/if_cp_client_proxy
    RAISING
      /iwbep/cx_gateway.

ENDCLASS.



CLASS ZAF_CL_REST_PETSTORE_CLIENT IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD create_client_proxy.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

  ENDMETHOD.


  METHOD pet_create.

  ENDMETHOD.


  METHOD pet_delete.

  ENDMETHOD.


  METHOD pet_read_by_id.

  ENDMETHOD.


  METHOD pet_update.

  ENDMETHOD.


  METHOD pet_update_name_and_status.

  ENDMETHOD.
ENDCLASS.

CLASS zcl_abap_c_reader DEFINITION PUBLIC INHERITING FROM cl_abap_c_reader FINAL CREATE PUBLIC.
  PUBLIC SECTION.

    TYPES: tab TYPE STANDARD TABLE OF REF TO zcl_abap_c_reader WITH DEFAULT KEY.

    CLASS-METHODS create RETURNING value(r_result) TYPE REF TO zcl_abap_c_reader.

    METHODS constructor.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS read_internal IMPORTING length TYPE abap_msize
                          RETURNING VALUE(result) TYPE STRING.

    METHODS data_available_internal RETURNING VALUE(available) TYPE abap_bool.

ENDCLASS.



CLASS ZCL_ABAP_C_READER IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).
  ENDMETHOD.


  METHOD create.
    r_result = NEW #( ).
  ENDMETHOD.


  METHOD data_available_internal .
  ENDMETHOD.


  METHOD read_internal.
  ENDMETHOD.
ENDCLASS.

CLASS zjw_delta_demo DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZJW_DELTA_DEMO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello S/$HANA Delta Trening' ).
    SELECT FROM I_Product FIELDS Product INTO TABLE @DATA(mydata).
    out->write( mydata ).
  ENDMETHOD.
ENDCLASS.

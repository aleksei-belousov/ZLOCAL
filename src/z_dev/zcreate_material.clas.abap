CLASS zcreate_material DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCREATE_MATERIAL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Create Material.' ).

*    CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'.

    DATA(product)               = '000231-048-A-070'.
    DATA(productType)           = 'MAT'.
    DATA(baseUnit)              = 'EA'. " ST/PC
    DATA(language)              = 'E'.
    CONCATENATE 'Descr for' product INTO DATA(productDescription) SEPARATED BY space.
    DATA(industrySector)        = 'M'. " - Obligated!

    MODIFY ENTITIES OF
            i_producttp_2
        ENTITY
            Product
        CREATE FIELDS (
            Product
            ProductType
            BaseUnit
            IndustrySector
        )
        WITH VALUE #( (
            %cid = '1'
            %data = VALUE #(
                Product         = product
                ProductType     = productType
                BaseUnit        = baseUnit
                IndustrySector  = industrySector
            )
        ) )
        CREATE BY
            \_ProductDescription
        FIELDS
            (
                Language
                ProductDescription
            )
        WITH VALUE #( (
            %cid_ref = '1'
            Product = product
            %target = VALUE #( (
                %cid                = '11'
                Product             = product
                Language            = language
                ProductDescription  = productDescription
            ) )
        ) )
        MAPPED DATA(ls_mapped)
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).

    COMMIT ENTITIES
        RESPONSE OF i_producttp_2
        FAILED DATA(failed_commit)
        REPORTED DATA(reported_commit).

    IF ( failed_commit-product[] IS INITIAL ).
        CONCATENATE 'A New Product' product 'created.' INTO DATA(text) SEPARATED BY space.
        out->write( text ).
    ELSE.
        out->write( 'Failed.' ). " output to console
    ENDIF.

  ENDMETHOD.
ENDCLASS.

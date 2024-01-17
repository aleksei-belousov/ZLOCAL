CLASS zcl_xco_doc_cp_cs_abs_ent DEFINITION PUBLIC INHERITING FROM cl_xco_cp_adt_simple_classrun FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor.

  PROTECTED SECTION.
    METHODS main REDEFINITION.

  PRIVATE SECTION.
    CONSTANTS co_package    TYPE sxco_package VALUE 'Z_SIMPLE_010'.
    CONSTANTS co_transport  TYPE sxco_transport VALUE 'X1KK900057'.
    CONSTANTS co_abstract_entity_name TYPE sxco_ao_object_name VALUE 'ZXCO_DEMO_PRODUCTX'.

    DATA mo_environment TYPE REF TO if_xco_cp_gen_env_dev_system.

  METHODS put_ddls.


ENDCLASS.



CLASS ZCL_XCO_DOC_CP_CS_ABS_ENT IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    mo_environment = xco_cp_generation=>environment->dev_system( co_transport ).

  ENDMETHOD. " constructor


  METHOD main.

    put_ddls( ).

    out->write( |PUT operation executed successfully.| ).

    DATA(lo_abstract_entity) = xco_cp_cds=>abstract_entity( co_abstract_entity_name ).

    DATA(ls_abstract_entity) = lo_abstract_entity->content( )->get( ).
    out->write( ls_abstract_entity ).

    LOOP AT lo_abstract_entity->fields->all->get( ) INTO DATA(lo_field).
      out->write( |Field { lo_field->name }:| ).

      DATA(ls_field) = lo_field->content( )->get( ).
      out->write( ls_field ).

    ENDLOOP.
  ENDMETHOD. " main


  METHOD put_ddls.

    DATA(lo_put_operation) = mo_environment->create_put_operation( ).

    DATA(lo_form_specification) = lo_put_operation->for-ddls->add_object( co_abstract_entity_name )->set_package( co_package
      )->create_form_specification( ).

    DATA(lo_abstract_entity) = lo_form_specification->set_short_description( 'Product' )->add_abstract_entity( ).

    DATA(lo_parameter) = lo_abstract_entity->add_parameter( 'p_language' )->set_data_type( xco_cp_abap_dictionary=>built_in_type->lang ).

    DATA(lo_id_field) = lo_abstract_entity->add_field( xco_cp_ddl=>field( 'ID' ) ).
    lo_id_field->set_key( ).
    lo_id_field->set_type( xco_cp_abap_dictionary=>built_in_type->char( 30 ) ).

    lo_id_field->add_annotation( 'UI.lineItem' )->value->build(
        )->begin_array(
            )->begin_record(
                )->add_member( 'position' )->add_number( 1
                )->add_member( 'label' )->add_string( 'ProductX'
            )->end_record(
        )->end_array( ).

    DATA(lo_description_field) = lo_abstract_entity->add_field( xco_cp_ddl=>field( 'description' ) ).
    lo_description_field->set_type( xco_cp_abap_dictionary=>built_in_type->char( 60 ) ).
    lo_description_field->add_annotation( 'UI.lineItem' )->value->build(
        )->begin_array(
            )->begin_record(
                )->add_member( 'position' )->add_number( 2
                )->add_member( 'label' )->add_string( 'Description'
            )->end_record(
        )->end_array( ).

    lo_put_operation->execute( ).

  ENDMETHOD. " put_ddls
ENDCLASS.

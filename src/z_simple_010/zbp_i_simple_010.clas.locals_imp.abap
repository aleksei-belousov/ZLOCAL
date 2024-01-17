CLASS lsc_zi_simple_010 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zi_simple_010 IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_simple DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS co_package    TYPE sxco_package VALUE 'Z_SIMPLE_010'.
    CONSTANTS co_transport  TYPE sxco_transport VALUE 'X1KK900057'.
    CONSTANTS co_abstract_entity_name TYPE sxco_ao_object_name VALUE 'ZXCO_MY_ENTITY'.
    DATA mo_environment TYPE REF TO if_xco_cp_gen_env_dev_system.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR simple RESULT result.

    METHODS calc_on_modify FOR DETERMINE ON MODIFY
      IMPORTING keys FOR simple~calc_on_modify.

    METHODS test FOR MODIFY IMPORTING keys FOR ACTION simple~test.
    METHODS test2 FOR MODIFY IMPORTING keys FOR ACTION simple~test2.

    METHODS put_ddls.

ENDCLASS.

CLASS lhc_simple IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calc_on_modify.

   "read transfered instances
    READ ENTITIES OF zc_simple_010 "IN LOCAL MODE
      ENTITY Simple
        FIELDS ( Data1 Data2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    "read and set Data3
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
        <entity>-Data3 = <entity>-Data1 + <entity>-Data2.
    ENDLOOP.

    "update instances
    MODIFY ENTITIES OF zc_simple_010 "IN LOCAL MODE
      ENTITY Simple
        UPDATE FIELDS ( Data3 )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
                           %tky     = entity-%tky
                           Data3    = entity-Data3
                    ) ).

  ENDMETHOD. " calc_on_modify

  METHOD test.

    DATA(lo_view_entity) = xco_cp_cds=>view_entity( 'ZC_SIMPLE_010' ).

    DATA(lo_view_entity_content) = lo_view_entity->content( ).

    DATA(ls_view_entity_content) = lo_view_entity_content->get( ).

    DATA(lv_short_description) = ls_view_entity_content-short_description.

    DATA(ls_data_source) = ls_view_entity_content-data_source.

    DATA(lv_root_indicator) = ls_view_entity_content-root_indicator.

    DATA(lt_name_list) = ls_view_entity_content-name_list.

    DATA(lo_where) = ls_view_entity_content-where.

    DATA(lt_group_by) = ls_view_entity_content-group_by.

    " Attributes can be accessed directly via corresponding get methods, such as:
    lt_name_list = lo_view_entity_content->get_name_list( ).

    LOOP AT lo_view_entity->parameters->all->get( ) INTO DATA(lo_parameter).
      DATA(ls_parameter) = lo_parameter->content( )->get( ).
    ENDLOOP.

    LOOP AT lo_view_entity->associations->all->get( ) INTO DATA(lo_association).
      DATA(ls_association) = lo_association->content( )->get( ).
    ENDLOOP.

    LOOP AT lo_view_entity->compositions->all->get( ) INTO DATA(lo_composition).
      DATA(ls_composition) = lo_composition->content( )->get( ).
    ENDLOOP.

    DATA(lo_fields) = lo_view_entity->fields->all->get( ).
    LOOP AT lo_fields INTO DATA(lo_field).
      DATA(ls_field) = lo_field->content( )->get( ).
    ENDLOOP.

    " Fields/parameters/associations/compositions can be addressed directly, such as:
    lo_field = lo_view_entity->field( 'DATA1' ).
    DATA(lv_does_field_exist) = lo_field->exists( ).

    IF lv_does_field_exist EQ abap_true.
      ls_field = lo_field->content( )->get( ).
      ls_field = lo_field->content( )->get( ).
    ENDIF.

* does not work
*data : lo_annotation type ref to /iwbep/if_mgw_odata_annotation,
*       lo_property   type ref to /iwbep/if_mgw_odata_property,
*       lo_entity_set type ref to /iwbep/if_mgw_odata_entity_set.

  ENDMETHOD. " test

  METHOD test2.

    put_ddls( ).

    "out->write( |PUT operation executed successfully.| ).

    DATA(lo_abstract_entity) = xco_cp_cds=>abstract_entity( co_abstract_entity_name ).

*    DATA(ls_abstract_entity) = lo_abstract_entity->content( )->get( ).
*    "out->write( ls_abstract_entity ).
*
*    LOOP AT lo_abstract_entity->fields->all->get( ) INTO DATA(lo_field).
*      "out->write( |Field { lo_field->name }:| ).
*
*      DATA(ls_field) = lo_field->content( )->get( ).
*      "out->write( ls_field ).
*
*    ENDLOOP.

  ENDMETHOD. " test2

  METHOD put_ddls.

    DATA mo_environment TYPE REF TO if_xco_cp_gen_env_dev_system.
    mo_environment = xco_cp_generation=>environment->dev_system( co_transport ).

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
                )->add_member( 'label' )->add_string( 'Product'
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

  ENDMETHOD.

ENDCLASS.

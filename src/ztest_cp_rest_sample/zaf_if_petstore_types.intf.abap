INTERFACE zaf_if_petstore_types
  PUBLIC .

  CONSTANTS:
    BEGIN OF gcs_internal_struct_type_names,
      pet      TYPE string  VALUE 'PET',
      tag      TYPE string  VALUE 'TAG',
      category TYPE string  VALUE 'CATEGORY',
    END OF   gcs_internal_struct_type_names,

    BEGIN OF gcs_resource_names,
      pets              TYPE string  VALUE `PETS`,
      pet_id             TYPE string  VALUE `PET_ID`,
      pet_id_name_status TYPE string  VALUE `PET_ID_NAME_STATUS`,
    END OF  gcs_resource_names,

    BEGIN OF gcs_resource_paths,
      pets               TYPE string  VALUE `/pet`,
      pet_id             TYPE string  VALUE `/pet/{id}`,
      pet_id_name_status TYPE string  VALUE `/pet/{id}?name={name}&status={status}`,
    END OF  gcs_resource_paths.

  TYPES:

    BEGIN OF tys_category,
      id   TYPE i,
      name TYPE string,
    END OF tys_category,

    BEGIN OF tys_tag,
      id   TYPE i,
      name TYPE string,
    END OF tys_tag,

    BEGIN OF tys_pet,
      id         TYPE i,
      name       TYPE string,
      category   TYPE tys_category,
      photo_urls TYPE STANDARD TABLE OF string    WITH DEFAULT KEY,
      tags       TYPE STANDARD TABLE OF tys_tag  WITH DEFAULT KEY,
      status     TYPE string,
    END OF tys_pet.

ENDINTERFACE.

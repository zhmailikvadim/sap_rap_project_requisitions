CLASS ltcl_projects DEFINITION DEFERRED FOR TESTING.
CLASS lhc_task DEFINITION INHERITING FROM cl_abap_behavior_handler FRIENDS ltcl_projects.

  PRIVATE SECTION.

    METHODS CalculateFields FOR DETERMINE ON SAVE
      IMPORTING keys FOR Task~CalculateFields.

ENDCLASS.

CLASS lhc_task IMPLEMENTATION.

  METHOD CalculateFields.
    READ ENTITIES OF znbs_i_projects IN LOCAL MODE
    ENTITY Task
      FIELDS ( SemanticID )
      WITH CORRESPONDING #( keys )
    RESULT DATA(lt_data).

    DELETE lt_data WHERE ProjectUUID IS INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_projects IN LOCAL MODE
      ENTITY Task
        UPDATE FIELDS ( SemanticID )
        WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                           %key      = ls_data-%key
                           SemanticID  = zcl_static_methods=>get_next_number(  ) ) )
    REPORTED DATA(lt_reported).

    DELETE lt_data WHERE Dueby IS NOT INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_projects IN LOCAL MODE
     ENTITY Task
       UPDATE FIELDS ( Dueby )
       WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                          %key      = ls_data-%key
                          Dueby  = cl_abap_context_info=>get_system_date( ) ) )
   REPORTED lt_reported.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Projects DEFINITION INHERITING FROM cl_abap_behavior_handler FRIENDS ltcl_projects.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Projects RESULT result.

    METHODS CalculateFields FOR DETERMINE ON SAVE
      IMPORTING keys FOR Projects~CalculateFields.

ENDCLASS.

CLASS lhc_Projects IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD CalculateFields.
    READ ENTITIES OF znbs_i_projects IN LOCAL MODE
    ENTITY Projects
      FIELDS ( SemanticID Description )
      WITH CORRESPONDING #( keys )
    RESULT DATA(lt_data).

    DELETE lt_data WHERE ProjectUUID IS INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_projects IN LOCAL MODE
      ENTITY Projects
        UPDATE FIELDS ( SemanticID )
        WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                           %key      = ls_data-%key
                           SemanticID  = zcl_static_methods=>get_next_number(  ) ) )
    REPORTED DATA(lt_reported).

    DELETE lt_data WHERE Dueby IS NOT INITIAL.
    CHECK lt_data IS NOT INITIAL.
    data(date) = cl_abap_context_info=>get_system_date( ).
    MODIFY ENTITIES OF znbs_i_projects IN LOCAL MODE
     ENTITY Projects
       UPDATE FIELDS ( Dueby )
       WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                          %key      = ls_data-%key
                          Dueby  = cl_abap_context_info=>get_system_date( ) ) )
   REPORTED lt_reported.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Epic DEFINITION INHERITING FROM cl_abap_behavior_handler FRIENDS ltcl_projects.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Epic RESULT result.

    METHODS CalculateFields FOR DETERMINE ON SAVE
      IMPORTING keys FOR Epic~CalculateFields.

ENDCLASS.

CLASS lhc_Epic IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD CalculateFields.
    READ ENTITIES OF znbs_i_projects IN LOCAL MODE
    ENTITY Epic
      FIELDS ( SemanticID )
      WITH CORRESPONDING #( keys )
    RESULT DATA(lt_data).

    DELETE lt_data WHERE ProjectUUID IS INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_projects IN LOCAL MODE
      ENTITY Epic
        UPDATE FIELDS ( SemanticID )
        WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                           %key      = ls_data-%key
                           SemanticID  = zcl_static_methods=>get_next_number(  ) ) )
    REPORTED DATA(lt_reported).

    DELETE lt_data WHERE Dueby IS NOT INITIAL.
    CHECK lt_data IS NOT INITIAL.

    cl_abap_context_info=>get_system_date( ).

    MODIFY ENTITIES OF znbs_i_projects IN LOCAL MODE
     ENTITY Epic
       UPDATE FIELDS ( Dueby )
       WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                          %key      = ls_data-%key
                          Dueby  = cl_abap_context_info=>get_system_date( ) ) )
   REPORTED lt_reported.
  ENDMETHOD.

ENDCLASS.

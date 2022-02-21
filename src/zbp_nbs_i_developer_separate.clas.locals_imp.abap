CLASS lhc_epic DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateFields FOR DETERMINE ON SAVE
      IMPORTING keys FOR Epic~CalculateFields.

ENDCLASS.

CLASS lhc_epic IMPLEMENTATION.

  METHOD CalculateFields.
    READ ENTITIES OF znbs_i_developer_separate IN LOCAL MODE
      ENTITY Epic
        FIELDS ( SemanticID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    DELETE lt_data WHERE EpicUUID IS INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_developer_separate IN LOCAL MODE
      ENTITY Epic
        UPDATE FIELDS ( SemanticID )
        WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                           %key      = ls_data-%key
                           SemanticID  = zcl_static_methods=>get_next_number(  ) ) )
    REPORTED DATA(lt_reported).

    DELETE lt_data WHERE Dueby IS NOT INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_developer_separate IN LOCAL MODE
     ENTITY Epic
       UPDATE FIELDS ( Dueby )
       WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                          %key      = ls_data-%key
                          Dueby  = cl_abap_context_info=>get_system_date( ) ) )
   REPORTED lt_reported.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZNBS_I_DEVELOPER_SEPARATE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Developer RESULT result.

ENDCLASS.

CLASS lhc_ZNBS_I_DEVELOPER_SEPARATE IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZNBS_I_EPIC_SEPARATE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Epic RESULT result.

    METHODS EpicCalculateFields FOR DETERMINE ON SAVE IMPORTING keys FOR Epic~CalculateFields.
    METHODS TaskCalculateFields FOR DETERMINE ON SAVE IMPORTING keys FOR Task~CalculateFields.

    "METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
    " IMPORTING keys REQUEST requested_authorizations FOR znbs_i_epic_separate RESULT result.

ENDCLASS.

CLASS lhc_ZNBS_I_EPIC_SEPARATE IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  "METHOD get_instance_authorizations.
  "ENDMETHOD.

  METHOD EpicCalculateFields.
    READ ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
      ENTITY Epic
        FIELDS ( SemanticID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    DELETE lt_data WHERE EpicUUID IS INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
      ENTITY Epic
        UPDATE FIELDS ( SemanticID )
        WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                           %key      = ls_data-%key
                           SemanticID  = zcl_static_methods=>get_next_number(  ) ) )
    REPORTED DATA(lt_reported).

    DELETE lt_data WHERE Dueby IS NOT INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
     ENTITY Epic
       UPDATE FIELDS ( Dueby )
       WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                          %key      = ls_data-%key
                          Dueby  = cl_abap_context_info=>get_system_date( ) ) )
   REPORTED lt_reported.
  ENDMETHOD.

  METHOD taskcalculatefields.
    READ ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
      ENTITY Task
        FIELDS ( SemanticID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_data).

    READ TABLE lt_data INTO DATA(ls_data1) INDEX 1.

    SELECT SINGLE FROM znbs_i_epic_separate AS ep
     INNER JOIN znbs_i_projects AS pr
         ON pr~ProjectUUID = ep~ProjectUUID
     FIELDS ( pr~ProjectUUID )
     WHERE  ep~EpicUUID = @ls_data1-EpicUUID
     INTO @DATA(lv_projectUUID).

    DELETE lt_data WHERE TaskUUID IS INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
      ENTITY Task
        UPDATE FIELDS ( SemanticID  ProjectUUID )
        WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                           %key      = ls_data-%key
                           SemanticID  = zcl_static_methods=>get_next_number(  )
                           ProjectUUID = lv_projectUUID ) )
    REPORTED DATA(lt_reported).

    DELETE lt_data WHERE Dueby IS NOT INITIAL.
    CHECK lt_data IS NOT INITIAL.

    MODIFY ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
     ENTITY Task
       UPDATE FIELDS ( Dueby )
       WITH VALUE #( FOR ls_data IN lt_data INDEX INTO i (
                          %key      = ls_data-%key
                          Dueby  = cl_abap_context_info=>get_system_date( ) ) )
   REPORTED lt_reported.

  ENDMETHOD.

*  METHOD validateProjectUUID.
*    READ ENTITIES OF znbs_i_epic_separate IN LOCAL MODE
*    ENTITY Task
*      FIELDS ( SemanticID ProjectUUID )
*      WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_data).
*
*    loop at lt_data ASSIGNING FIELD-SYMBOL(<fs_data>).
*
*    endloop.
*
**    READ ENTITY znbs_i_epic_separate\\Task
**    FROM VALUE #(
**        FOR <root_key> IN keys ( %key-TaskUUID     = <root_key>-%key-TaskUUID
**                                 %control = VALUE #( ProjectUUID = '00000000-0000-0000-0000-000000000000' ) ) )
**        RESULT DATA(lt_travel_result).
*  ENDMETHOD.

ENDCLASS.

CLASS lhc_ProjectReq DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

  types:
     BEGIN OF TY_ZNBS_PRJ_RQ .
      INCLUDE TYPE ZNBS_PRJ_RQ.
      INCLUDE TYPE IF_CHDO_OBJECT_TOOLS_REL=>TY_ICDIND.
 TYPES END OF TY_ZNBS_PRJ_RQ .
  types:
    TT_ZNBS_PRJ_RQ TYPE STANDARD TABLE OF TY_ZNBS_PRJ_RQ .

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ProjectReq RESULT result.
    METHODS generatepdf FOR MODIFY
      IMPORTING keys FOR ACTION projectreq~generatepdf RESULT result.
    METHODS project_fields_update FOR DETERMINE ON SAVE
      IMPORTING keys FOR projectreq~project_fields_update.

ENDCLASS.

CLASS lhc_ProjectReq IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD GeneratePDF.

*    IF 1 = 2.ENDIF.
*
*    SELECT *
*     FROM znbs_prj_rq
*     INTO TABLE @DATA(lt_data).
*
*    result = CORRESPONDING #( lt_data ).



  ENDMETHOD.

  METHOD project_fields_update.

    GET TIME STAMP FIELD DATA(lv_time_stamp).
    CONVERT TIME STAMP lv_time_stamp TIME ZONE 'UTC'
             INTO DATE DATA(lv_date) TIME DATA(lv_time).

    READ ENTITIES OF znbs_i_prj_rq IN LOCAL MODE
          ENTITY ProjectReq
            FIELDS ( ProjectUUID ProjectID ProjectDescription ProjectStatus )
            WITH CORRESPONDING #( keys )
            RESULT DATA(lt_ProjectReq).

*    DATA lt_new type TT_ZNBS_PRJ_RQ.
*    APPEND INITIAL LINE TO lt_new ASSIGNING FIELD-SYMBOL(<ls_new>).
*    <ls_new> = CORRESPONDING TY_ZNBS_PRJ_RQ( lt_projectreq[ 1 ] ).

    data(ls_new) = CORRESPONDING TY_ZNBS_PRJ_RQ( lt_projectreq[ 1 ] ).

    SELECT SINGLE ProjectUUID, ProjectID, ProjectDescription, ProjectStatusID
        FROM znbs_prj_rq
        WHERE projectuuid = @ls_new-projectuuid
        INTO @DATA(ls_select_old).

    IF sy-subrc = 0.
      DATA(ls_old) = CORRESPONDING znbs_prj_rq( ls_select_old ).
      DATA(lv_object_change_indicator) = CONV if_chdo_object_tools_rel=>ty_cdchngindh( 'U' ).
      DATA(lv_upd_znbs_prj_rq) = CONV if_chdo_object_tools_rel=>ty_cdchngindh( 'U' ).
    ELSE.
      ls_old = ls_new.
      lv_object_change_indicator = 'I'.
      lv_upd_znbs_prj_rq = 'I'.
    ENDIF.

    TRY.
        CALL METHOD zcl_znbs_prj_rq_chdo=>write
          EXPORTING
            objectid                = 'ZNBS_PRJ_RQ'
            utime                   = lv_time
            udate                   = lv_date
            username                = sy-uname
            object_change_indicator = lv_object_change_indicator
            n_znbs_prj_rq           = CORRESPONDING #( ls_new )
            o_znbs_prj_rq            = ls_old
            upd_znbs_prj_rq         = lv_upd_znbs_prj_rq
          IMPORTING
            changenumber            = DATA(lv_changenumber).

      CATCH cx_chdo_write_error INTO DATA(err_ref).
        IF 1 = 2.ENDIF.

    ENDTRY.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZNBS_I_PRJ_RQ DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZNBS_I_PRJ_RQ IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

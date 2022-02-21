CLASS zcl_test_chdo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_CHDO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    IF 1 = 2.
      SELECT SINGLE *
          FROM znbs_prj_rq
          WHERE projectid = '2'
          INTO @DATA(ls_old).

      DATA(ls_new) = ls_old.
      ls_new-projectdescription = 'New Description 555'.

      GET TIME STAMP FIELD DATA(lv_time_stamp).
      CONVERT TIME STAMP lv_time_stamp TIME ZONE 'UTC'
               INTO DATE DATA(lv_date) TIME DATA(lv_time).

      TRY.
          CALL METHOD zcl_znbs_prj_rq_chdo=>write
            EXPORTING
              objectid                = 'ZNBS_PRJ_RQ'
              utime                   = lv_time
              udate                   = lv_date
              username                = sy-uname
              object_change_indicator = 'U'
              o_znbs_prj_rq           = ls_old
*             o_znbs_prj_rq_d         = ls_old
              n_znbs_prj_rq           = ls_new
*             n_znbs_prj_rq_d         = ls_new
              upd_znbs_prj_rq         = 'U'
            IMPORTING
              changenumber            = DATA(lv_changenumber).
        CATCH cx_chdo_write_error INTO DATA(err_ref).
          IF 1 = 2.ENDIF.
      ENDTRY.
    ENDIF.
*
*    IF 1 = 2.
*      DATA: lv_is_authorized TYPE abap_bool.
*      TRY.
*          " iv_object : Change document object name
*          " it_activity : Activity to be checked. Possible values '01' = create,
*          "                                                       '02' = change,
*          "                                                       '03' = read,
*          "                                                       '06' = delete
*          " it_devclass : development class of change document object
*          cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~check_authorization(
*            EXPORTING
*              iv_object        = 'ZNBS_PRJ_RQ'
*              iv_activity      = '03'
*              iv_devclass      = 'ZLOCAL'
*            RECEIVING
*              rv_is_authorized = lv_is_authorized
*          ).
*      ENDTRY.
*
*      IF lv_is_authorized IS INITIAL.
*        out->write( |Exception occurred: authorization error.| ).
*      ELSE.
*        out->write( |Activity can be performed on the change document object.| ).
*      ENDIF.
*    ENDIF.
*
    IF 1 = 1.
      DATA: lt_cdredadd TYPE cl_chdo_read_tools=>tt_cdredadd_tab,
            lr_err      TYPE REF TO cx_chdo_read_error.

      DATA:" lt_cdredadd    TYPE cl_chdo_read_tools=>tt_cdredadd_tab,
            "lr_err         TYPE REF TO cx_chdo_read_error,
            lt_projectuuid TYPE TABLE OF znbs_prj_rq-projectuuid.


      DATA: lt_znbs_i_prj_rq_chdo TYPE TABLE OF znbs_i_prj_rq_chdo,
            lt_nbs_prj_rq         TYPE TABLE OF znbs_prj_rq.

      TRY.
          cl_chdo_read_tools=>changedocument_read(
            EXPORTING
              i_objectclass    = 'ZNBS_PRJ_RQ'  " change document object name
            IMPORTING
              et_cdredadd_tab  = lt_cdredadd    " result returned in table
          ).
        CATCH cx_chdo_read_error INTO lr_err.
*          out->write( |Exception occurred: { lr_err->get_text( ) }| ).
      ENDTRY.

*      delete ADJACENT DUPLICATES FROM lt_cdredadd COMPARING tabkey.

*    lt_projectuuid = VALUE #( FOR <ls_cdredadd> IN lt_cdredadd ( CONV sysuuid_x16( <ls_cdredadd>-tabkey ) ) ).
      LOOP AT lt_cdredadd ASSIGNING FIELD-SYMBOL(<ls_cdredadd>).
        APPEND INITIAL LINE TO lt_projectuuid ASSIGNING FIELD-SYMBOL(<ls_projectuuid>).
        CONDENSE <ls_cdredadd>-tabkey.
        <ls_projectuuid> =  <ls_cdredadd>-tabkey.
      ENDLOOP.

      DELETE ADJACENT DUPLICATES FROM lt_projectuuid.
      DELETE lt_projectuuid WHERE table_line = '00000000000000000000000000000000' .


      SELECT projectuuid, projectid, projectdescription
          FROM znbs_prj_rq
          FOR ALL ENTRIES IN @lt_projectuuid
          WHERE projectuuid = @lt_projectuuid-table_line
          INTO TABLE @DATA(lt_znbs_prj_rq).

      LOOP AT lt_cdredadd ASSIGNING FIELD-SYMBOL(<ls_cdr>).

        CONDENSE <ls_cdr>-tabkey.

        READ TABLE lt_znbs_prj_rq ASSIGNING FIELD-SYMBOL(<ls_znbs_prjrq>)
          WITH KEY projectuuid = <ls_cdr>-tabkey.
        IF sy-subrc = 0.
          APPEND INITIAL LINE TO lt_znbs_i_prj_rq_chdo ASSIGNING FIELD-SYMBOL(<ls_znbs_i_prj_rq_chdo>).
          <ls_znbs_i_prj_rq_chdo> = CORRESPONDING #( <ls_cdr> ).
          <ls_znbs_i_prj_rq_chdo>-projectid = <ls_znbs_prjrq>-projectid.
          <ls_znbs_i_prj_rq_chdo>-projectdescription = <ls_znbs_prjrq>-projectdescription.
        ENDIF.

      ENDLOOP.

      LOOP AT lt_cdredadd ASSIGNING FIELD-SYMBOL(<ls_cdredadd3>).
        out->write( <ls_cdredadd3>-changenr ).
        out->write( <ls_cdredadd3>-chngind ).
        out->write( <ls_cdredadd3>-f_old ).
        out->write( <ls_cdredadd3>-f_new ).
        out->write( <ls_cdredadd3>-username ).
        out->write( <ls_cdredadd3>-udate ).
        out->write( <ls_cdredadd3>-utime ).
        out->write( <ls_cdredadd3>-fname ).

      ENDLOOP.
    ENDIF.


  ENDMETHOD.
ENDCLASS.

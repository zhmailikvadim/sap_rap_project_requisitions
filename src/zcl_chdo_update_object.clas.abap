CLASS zcl_chdo_update_object DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CHDO_UPDATE_OBJECT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
      rt_errors     TYPE if_chdo_object_tools_rel=>ty_tr_error_tab,
      lt_errors_err TYPE LINE OF if_chdo_object_tools_rel=>ty_tr_error_tab,
      lt_tcdob      TYPE iF_CHDO_OBJECT_TOOLS_REL=>ty_tcdobdef_tab,
      p_it_tcdob    TYPE iF_CHDO_OBJECT_TOOLS_REL=>ty_tcdobdef_tab,
      p_it_tcdobt   TYPE if_chdo_object_tools_rel=>ty_tcdobtext_tab,
      p_it_tcdrp    TYPE if_chdo_object_tools_rel=>ty_tcdgen,
      lt_tcdobt     TYPE if_chdo_object_tools_rel=>ty_tcdobtext_tab,
      ls_tcdob      TYPE LINE OF iF_CHDO_OBJECT_TOOLS_REL=>ty_tcdobdef_tab,
      ls_tcdobt     TYPE LINE OF if_chdo_object_tools_rel=>ty_tcdobtext_tab.
    DATA: lr_err                TYPE REF TO cx_chdo_generation_error.

    ls_tcdob-tabname = 'ZNBS_PRJ_RQ'.
    ls_tcdob-multcase = ' '.
    ls_tcdob-docudel = ' '.
    ls_tcdob-docuins = ' '.
    ls_tcdob-docud_if = ' '.

    APPEND ls_tcdob TO p_it_tcdob.

    ls_tcdobt-lang_key = 'E'.
    ls_tcdobt-object_text = 'Single Case: Update'.

    APPEND ls_tcdobt TO p_it_tcdobt.

    p_it_tcdrp-author = sy-uname.
    p_it_tcdrp-textcase = 'X'.
    p_it_tcdrp-devclass = 'ZNBS_PRJ_RQ'.

    CLEAR: rt_errors, lr_err.
    TRY.
*      cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~delete_object(
*        EXPORTING
*          iv_object           = 'ZCHDO_PRJ_RQ'    " change document object name
*          iv_corrnr           = 'TRLK902540'   " transport request number
*          iv_del_cl_when_used = 'X'             " delete class even when it is used
*        IMPORTING
*          et_errors           = rt_errors       " messages from deletion
*      ).

*      cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~create_and_generate_object(
*        EXPORTING
*          iv_object          = 'ZNBS_PRJ_RQ' " change document object name
*          it_cd_object_def   = p_it_tcdob   " change document object definition
*          it_cd_object_text  = p_it_tcdobt  " change document object text
*          is_cd_object_gen   = p_it_tcdrp   " change document object generation info
*          iv_cl_overwrite    = 'X'          " class overwrite flag
*          iv_corrnr          = 'TRLK902540' " transport request number
*        IMPORTING
*          et_errors          = rt_errors    " generation message table
**          et_synt_errors     =
**          et_synt_error_long =
*      ).

        cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~update_object(
          EXPORTING
            iv_object          = 'ZNBS_PRJ_RQ'
            it_cd_object_def   = p_it_tcdob
            it_cd_object_text  = p_it_tcdobt
            is_cd_object_gen   = p_it_tcdrp
            iv_cl_overwrite    = 'X'
            iv_corrnr          = 'TRLK902540'
          IMPORTING
            et_errors          = rt_errors
        ).
      CATCH cx_chdo_generation_error INTO lr_err.
    ENDTRY.
    IF lr_err IS INITIAL.
      READ TABLE rt_errors WITH KEY kind = 'E-'
                               INTO lt_errors_err.
      IF sy-subrc IS INITIAL.
        out->write( |Exception occurred: { lt_errors_err-text } | ).
      ELSE.
        out->write( |Change ZNBS_PRJ_RQ document object updated | ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

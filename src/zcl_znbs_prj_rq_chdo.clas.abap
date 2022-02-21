class ZCL_ZNBS_PRJ_RQ_CHDO definition
  public
  create public .

public section.

  interfaces IF_CHDO_ENHANCEMENTS .

  class-data OBJECTCLASS type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDOBJECTCL read-only value 'ZNBS_PRJ_RQ' ##NO_TEXT.

  class-methods WRITE
    importing
      !OBJECTID type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDOBJECTV
      !UTIME type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDUZEIT
      !UDATE type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDDATUM
      !USERNAME type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDUSERNAME
      !PLANNED_CHANGE_NUMBER type IF_CHDO_OBJECT_TOOLS_REL=>TY_PLANCHNGNR default SPACE
      !OBJECT_CHANGE_INDICATOR type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH default 'U'
      !PLANNED_OR_REAL_CHANGES type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDFLAG default SPACE
      !NO_CHANGE_POINTERS type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDFLAG default SPACE
      !ICDTXT_ZNBS_PRJ_RQ type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDTXT_TAB optional
      !UPD_ICDTXT_ZNBS_PRJ_RQ type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH default SPACE
      !O_ZNBS_PRJ_RQ type ZNBS_PRJ_RQ optional
      !N_ZNBS_PRJ_RQ type ZNBS_PRJ_RQ optional
      !UPD_ZNBS_PRJ_RQ type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH default SPACE
    exporting
      value(CHANGENUMBER) type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHANGENR
    raising
      CX_CHDO_WRITE_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZNBS_PRJ_RQ_CHDO IMPLEMENTATION.


  method WRITE.
*"----------------------------------------------------------------------
*"         this WRITE method is generated for object ZNBS_PRJ_RQ
*"         never change it manually, please!        :10/14/2021
*"         All changes will be overwritten without a warning!
*"
*"         CX_CHDO_WRITE_ERROR is used for error handling
*"----------------------------------------------------------------------

    DATA: l_upd        TYPE if_chdo_object_tools_rel=>ty_cdchngind.

    CALL METHOD cl_chdo_write_tools=>changedocument_open
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        planned_change_number   = planned_change_number
        planned_or_real_changes = planned_or_real_changes.

     IF ( N_ZNBS_PRJ_RQ IS INITIAL ) AND
        ( O_ZNBS_PRJ_RQ IS INITIAL ).
       l_upd  = space.
     ELSE.
       l_upd = UPD_ZNBS_PRJ_RQ.
     ENDIF.

     IF  l_upd  NE space.
       CALL METHOD CL_CHDO_WRITE_TOOLS=>changedocument_single_case
         EXPORTING
           tablename              = 'ZNBS_PRJ_RQ'
           workarea_old           = O_ZNBS_PRJ_RQ
           workarea_new           = N_ZNBS_PRJ_RQ
           change_indicator       = UPD_ZNBS_PRJ_RQ
           docu_delete            = ''
           docu_insert            = ''
           docu_delete_if         = ''
           docu_insert_if         = ''
                  .
     ENDIF.

    IF UPD_ICDTXT_ZNBS_PRJ_RQ NE space.
      CALL METHOD CL_CHDO_WRITE_TOOLS=>changedocument_text_case
        EXPORTING
          texttable              = ICDTXT_ZNBS_PRJ_RQ.
    ENDIF.

    CALL METHOD cl_chdo_write_tools=>changedocument_close
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        date_of_change          = udate
        time_of_change          = utime
        username                = username
        object_change_indicator = object_change_indicator
        no_change_pointers      = no_change_pointers
      IMPORTING
        changenumber            = changenumber.

  endmethod.


  METHOD if_chdo_enhancements~authority_check.
    rv_is_authorized = 'X'.
  ENDMETHOD.
ENDCLASS.

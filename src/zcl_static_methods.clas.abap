CLASS zcl_static_methods DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-DATA: statusClosed type znbs_projectstatus VALUE 'Closed',
                uuidInitial type sysuuid_x16 value '00000000000000000000000000000000'.
    CLASS-METHODS get_next_number RETURNING VALUE(r) TYPE znbs_simple_id12.
    CLASS-METHODS calcMPTStatusChar IMPORTING iv_dateCreated TYPE timestamp
                                              iv_dateDueBy   TYPE datn
                                              iv_status type znbs_projectstatus
                                    EXPORTING ev_StatusChar  TYPE znbs_status_string
                                              ev_Criticality TYPE int1
                                              ev_status_days TYPE int4 .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_STATIC_METHODS IMPLEMENTATION.


  METHOD get_next_number.
    DATA ls_s_semant_id TYPE znbs_semant_ids.
    DATA(lo_random) = cl_abap_random_int=>create( min  = 0
                                                  max = 7 ).
    SELECT SINGLE FROM znbs_semant_ids FIELDS MAX( Uuid ) INTO @DATA(lv_max_id).

    lv_max_id += lo_random->get_next( ).
    ls_s_semant_id-uuid = lv_max_id.

    INSERT INTO znbs_semant_ids VALUES  @ls_s_semant_id.
    CHECK sy-subrc IS INITIAL.

    r = ls_s_semant_id-uuid.
  ENDMETHOD.


  METHOD calcMPTStatusChar.
    DATA:
      lv_dateCreatedChar  TYPE znbs_status_string,
      lv_proc_char        TYPE znbs_status_string,
      lv_proc             TYPE p,
      lv_dueby_days_char  TYPE znbs_status_string,
      lv_dateCreatedDatsn TYPE datn.

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).
    lv_dateCreatedChar = iv_dateCreated.
    CONDENSE lv_dateCreatedChar.
    lv_dateCreatedDatsn = lv_dateCreatedChar(8).
    IF lv_dateCreatedDatsn = 0.
      lv_dateCreatedDatsn = '00000000'.
    ENDIF.
    IF  iv_dateDueBy <> lv_dateCreatedDatsn.
      lv_proc = 100 * ( 1 - ( iv_dateDueBy - lv_today ) / ( iv_datedueby - lv_dateCreatedDatsn ) ).
    ENDIF.
    lv_proc_char = lv_proc.

    ev_statuschar = 'In Time' .
    ev_status_days =  iv_datedueby - lv_today.

    IF ev_status_days > 0.
      ev_criticality = 3.
    ELSEIF ev_status_days = 0.
      ev_criticality = 2.
    ELSEIF ev_status_days < 0.
      ev_criticality = 1.
      ev_statuschar = 'Excepted'.
    ENDIF.

    lv_dueby_days_char = ev_status_days.
    CONDENSE lv_dueby_days_char.

    CONCATENATE ev_StatusChar lv_dueby_days_char 'days' lv_proc_char '%'
        INTO ev_StatusChar SEPARATED BY space.

    CONDENSE ev_StatusChar.

    if iv_status = 'Closed'.
     ev_StatusChar = 'Done'.
     ev_status_days = ''.
     ev_criticality = 4.
    endif.
  ENDMETHOD.
ENDCLASS.

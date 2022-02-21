CLASS zcl_calc_virtuals_task DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CALC_VIRTUALS_TASK IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    DATA lt_original_data TYPE STANDARD TABLE OF znbs_c_task WITH DEFAULT KEY.

    DATA: lv_proc      TYPE p,
          lv_proc_char TYPE c LENGTH 3,
          lv_dats      TYPE datn,
          lv_char      TYPE c LENGTH 20.
    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      zcl_static_methods=>calcmptstatuschar( EXPORTING iv_datecreated = <fs_original_data>-Created
                                                       iv_datedueby = <fs_original_data>-Dueby
                                                       iv_status = <fs_original_data>-TaskStatus_Name
                                             IMPORTING ev_criticality = <fs_original_data>-dueby_days_criticality
                                                       ev_status_days = <fs_original_data>-dueby_days
                                                       ev_statuschar = <fs_original_data>-dueby_char ).
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).
  ENDMETHOD.
ENDCLASS.

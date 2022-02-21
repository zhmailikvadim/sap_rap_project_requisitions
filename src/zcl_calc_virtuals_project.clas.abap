CLASS zcl_calc_virtuals_project DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CALC_VIRTUALS_PROJECT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    DATA lt_original_data TYPE STANDARD TABLE OF znbs_c_projects WITH DEFAULT KEY.

    DATA: lv_proc      TYPE p,
          lv_proc_char TYPE c LENGTH 3,
          lv_dats      TYPE datn,
          lv_char      TYPE c LENGTH 20.
    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      zcl_static_methods=>calcmptstatuschar( EXPORTING iv_datecreated = <fs_original_data>-Created
                                                       iv_datedueby = <fs_original_data>-Dueby
                                                       iv_status = <fs_original_data>-StatusName
                                             IMPORTING ev_criticality = <fs_original_data>-dueby_days_criticality
                                                       ev_status_days = <fs_original_data>-dueby_days
                                                       ev_statuschar = <fs_original_data>-dueby_char ).

**********************************************************************Epic
      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
             INNER JOIN znbs_c_projects AS prj
                ON prj~ProjectUUID = ep~ProjectUUID
             LEFT OUTER JOIN znbs_vh_epicstatus AS st
                ON ep~EpicStatus = st~Uuid
             WHERE st~Name <> @zcl_static_methods=>statusclosed
                AND prj~ProjectUUID = @<fs_original_data>-ProjectUUID
         INTO @<fs_original_data>-epics.

      <fs_original_data>-criticalityEpics = 4.
      IF  <fs_original_data>-epics = 0.
        <fs_original_data>-criticalityEpics = 3.
      ENDIF.

      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
            INNER JOIN znbs_c_projects AS prj
                ON prj~ProjectUUID = ep~ProjectUUID
            LEFT OUTER JOIN znbs_vh_epicstatus AS st
                ON ep~EpicStatus = st~Uuid
            WHERE ep~Dueby <  @lv_today
                AND st~Name <> @zcl_static_methods=>statusclosed
                AND prj~ProjectUUID = @<fs_original_data>-ProjectUUID
         INTO @<fs_original_data>-epics_overdue.

      <fs_original_data>-criticalityOverDue = 4.
      IF  <fs_original_data>-epics_overdue > 0.
        <fs_original_data>-criticalityOverDue = 1.
      ENDIF.

**********************************************************************Task
      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
            INNER JOIN znbs_c_projects AS prj
                ON prj~ProjectUUID = ep~ProjectUUID
            INNER JOIN znbs_c_task AS task
               ON task~EpicUUID = ep~EpicUUID
            LEFT JOIN znbs_vh_taskstatus AS st
               ON task~TaskStatus = st~Uuid
         WHERE st~Name <> @zcl_static_methods=>statusclosed
               AND prj~ProjectUUID = @<fs_original_data>-ProjectUUID
         INTO @<fs_original_data>-tasks.

      <fs_original_data>-criticalityTasks = 4.
      IF  <fs_original_data>-tasks = 0.
        <fs_original_data>-criticalityTasks = 3.
      ENDIF.

      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
             INNER JOIN znbs_c_projects AS prj
                ON prj~ProjectUUID = ep~ProjectUUID
             INNER JOIN znbs_c_task AS task
                ON task~EpicUUID = ep~EpicUUID
             LEFT JOIN znbs_vh_taskstatus AS st
                ON task~TaskStatus = st~Uuid
         WHERE st~Name <> @zcl_static_methods=>statusclosed
               AND task~Dueby <  @lv_today
               AND prj~ProjectUUID = @<fs_original_data>-ProjectUUID
         INTO @<fs_original_data>-tasks_overdue.

      <fs_original_data>-criticalityTaskOverDue = 4.
      IF  <fs_original_data>-tasks_overdue > 0.
        <fs_original_data>-criticalityTaskOverDue = 2.
      ENDIF.

**********************************************************************NoDevelopers

      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
             INNER JOIN znbs_c_projects AS prj
                ON prj~ProjectUUID = ep~ProjectUUID
             LEFT OUTER JOIN znbs_vh_epicstatus AS st
                ON ep~EpicStatus = st~Uuid
             WHERE st~Name <> @zcl_static_methods=>statusclosed
                AND prj~ProjectUUID = @<fs_original_data>-ProjectUUID
                AND ep~Developer = @zcl_static_methods=>uuidinitial
         INTO @<fs_original_data>-NoDevelopers.

      <fs_original_data>-criticalityDevelopers = 4.
      IF  <fs_original_data>-NoDevelopers > 0.
        <fs_original_data>-criticalityDevelopers = 1.
      ENDIF.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).
  ENDMETHOD.
ENDCLASS.

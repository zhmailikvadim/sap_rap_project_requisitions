CLASS zcl_for_virtuals_developer_sep DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FOR_VIRTUALS_DEVELOPER_SEP IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    DATA lt_original_data TYPE STANDARD TABLE OF znbs_c_developer_separate WITH DEFAULT KEY.

    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).

**********************************************************************Epic
      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
         LEFT OUTER JOIN znbs_vh_epicstatus AS st
            ON ep~EpicStatus = st~Uuid
         WHERE ep~Developer = @<fs_original_data>-DeveloperUUID
               AND st~Name <> @zcl_static_methods=>statusclosed
         INTO @<fs_original_data>-epics.

      <fs_original_data>-criticalityEpics = 4.
      IF  <fs_original_data>-epics = 0.
        <fs_original_data>-criticalityEpics = 3.
      ENDIF.

      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
         LEFT OUTER JOIN znbs_vh_epicstatus AS st
            ON ep~EpicStatus = st~Uuid
         WHERE Developer = @<fs_original_data>-DeveloperUUID AND
                            Dueby <  @lv_today AND
                            st~Name <> @zcl_static_methods=>statusclosed
         INTO @<fs_original_data>-epics_overdue.

      <fs_original_data>-criticalityOverDue = 4.
      IF  <fs_original_data>-epics_overdue > 0.
        <fs_original_data>-criticalityOverDue = 1.
      ENDIF.

**********************************************************************Task
      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
         INNER JOIN znbs_c_task AS task
            ON task~EpicUUID = ep~EpicUUID
         LEFT JOIN znbs_vh_taskstatus AS st
            ON task~TaskStatus = st~Uuid
         WHERE ep~Developer = @<fs_original_data>-DeveloperUUID
               AND st~Name <> @zcl_static_methods=>statusclosed
         INTO @<fs_original_data>-tasks.

      <fs_original_data>-criticalityTasks = 4.
      IF  <fs_original_data>-tasks = 0.
        <fs_original_data>-criticalityTasks = 3.
      ENDIF.

      SELECT SINGLE COUNT( * )
         FROM znbs_c_epic AS ep
         INNER JOIN znbs_c_task AS task
            ON task~EpicUUID = ep~EpicUUID
         LEFT JOIN znbs_vh_taskstatus AS st
            ON task~TaskStatus = st~Uuid
         WHERE ep~Developer = @<fs_original_data>-DeveloperUUID AND
                              st~Name <> @zcl_static_methods=>statusclosed AND
                              task~Dueby <  @lv_today
         INTO @<fs_original_data>-tasks_overdue.

      <fs_original_data>-criticalityTaskOverDue = 4.
      IF  <fs_original_data>-tasks_overdue > 0.
        <fs_original_data>-criticalityTaskOverDue = 2.
      ENDIF.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).
  ENDMETHOD.
ENDCLASS.

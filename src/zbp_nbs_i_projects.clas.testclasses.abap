*"* use this source file for your ABAP unit test classes
CLASS ltcl_projects DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA:
      cds_test_environment TYPE REF TO if_cds_test_environment,
      sql_test_environment TYPE REF TO if_osql_test_environment.

    DATA:
      lo_projects        TYPE REF TO lhc_projects,
      lt_late_reported   TYPE RESPONSE FOR REPORTED LATE znbs_i_projects,
      lt_late_failed     TYPE RESPONSE FOR FAILED LATE znbs_i_projects,
      lt_calcFields_keys TYPE TABLE FOR DETERMINATION znbs_i_projects\\projects~calculatefields.

    CLASS-METHODS:
      class_setup,
      class_teardown.
    METHODS:
      setup,
      teardown,
      cds_test FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_projects IMPLEMENTATION.
  METHOD class_setup.
    cds_test_environment = cl_cds_test_environment=>create_for_multiple_cds( i_for_entities = VALUE #( ( i_for_entity = 'ZNBS_C_PROJECTS')
                                                                                                       ( i_for_entity = 'ZNBS_C_EPIC')
                                                                                                       ( i_for_entity = 'ZNBS_C_TASK') ) ).
    cds_test_environment->enable_double_redirection(  ). "For Open SQL access to the test double
  ENDMETHOD.

  METHOD class_teardown.
    cds_test_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    cds_test_environment->clear_doubles( ).
    CREATE OBJECT lo_projects FOR TESTING.
  ENDMETHOD.

  METHOD teardown.
    ROLLBACK ENTITIES.
  ENDMETHOD.

  METHOD cds_test.
    DATA cds_mock_projects TYPE STANDARD TABLE OF znbs_i_projects.
    cds_mock_projects = VALUE #( ( description = '1'  ) ).
    cds_test_environment->insert_test_data( cds_mock_projects ).
    SELECT * FROM znbs_i_projects INTO TABLE @DATA(act_results). "#EC CI_ALL_FIELDS_NEEDED
    cl_abap_unit_assert=>assert_equals( msg = 'Projects insert error' act = act_results exp = cds_mock_projects ).

    lo_projects->calculatefields(  EXPORTING keys = CORRESPONDING #( cds_mock_projects ) CHANGING reported = lt_late_reported ).

  ENDMETHOD.
ENDCLASS.

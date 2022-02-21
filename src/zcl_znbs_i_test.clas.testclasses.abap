"!@testing ZNBS_I_TEST
CLASS ltc_ZNBS_I_TEST
DEFINITION FINAL FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.
  PRIVATE SECTION.

    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      "! In CLASS_SETUP, corresponding doubles and clone(s) for the CDS view under test and its dependencies are created.
      class_setup RAISING cx_static_check,
      "! In CLASS_TEARDOWN, Generated database entities (doubles & clones) should be deleted at the end of test class execution.
      class_teardown.

    DATA:
      act_results        TYPE STANDARD TABLE OF znbs_i_test WITH EMPTY KEY,
      lt_znbs_dev_profs  TYPE STANDARD TABLE OF znbs_dev_profs WITH EMPTY KEY,
      lt_znbs_i_profiles TYPE STANDARD TABLE OF znbs_i_profiles WITH EMPTY KEY.

    METHODS:
      "! SETUP method creates a common start state for each test method,
      "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
      setup RAISING cx_static_check,
      prepare_testdata_set,
      "!  In this method test data is inserted into the generated double(s) and the test is executed and
      "!  the results should be asserted with the actuals.
      test1 FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltc_ZNBS_I_TEST IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'ZNBS_I_TEST' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD test1.
    prepare_testdata_set( ).
    SELECT * FROM znbs_i_test INTO TABLE @act_results.
    cl_abap_unit_assert=>fail( msg = 'Place your assertions here' ).
  ENDMETHOD.

  METHOD prepare_testdata_set.

    "Prepare test data for 'znbs_dev_profs'
    lt_znbs_dev_profs = VALUE #(
      (
        client = '100'
      ) ).
    environment->insert_test_data( i_data =  lt_znbs_dev_profs ).

    "Prepare test data for 'znbs_i_profiles'
    "TODO: Provide the test data here
    lt_znbs_i_profiles = VALUE #(
      (
      ) ).
    environment->insert_test_data( i_data =  lt_znbs_i_profiles ).

  ENDMETHOD.

ENDCLASS.

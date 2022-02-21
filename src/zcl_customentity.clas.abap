CLASS zcl_customentity DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_rap_query_provider.
  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CUSTOMENTITY IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA(lv_sql_filter) = io_request->get_filter( )->get_as_sql_string( ).

    DATA(sort_elements) = io_request->get_sort_elements( ).
    DATA(lt_sort_criteria) = VALUE string_table( FOR sort_element IN sort_elements
                                               ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                                                      THEN ` descending`
                                                                                      ELSE ` ascending` ) ) ).
    DATA(lv_sort_string)  = COND #( WHEN lt_sort_criteria IS INITIAL THEN `udate descending`
                                                                     ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
                                                                            DATA(lv_search_string) = io_request->get_search_expression( ).

    DATA(lv_search_sql) =
        | projectdescription LIKE '%{ cl_abap_dyn_prg=>escape_quotes( lv_search_string ) }%'  OR projectid LIKE '%{ cl_abap_dyn_prg=>escape_quotes( lv_search_string ) }% ' |.

    IF lv_sql_filter IS INITIAL.
      lv_sql_filter = lv_search_sql.
    ELSE.
      lv_sql_filter = |( { lv_sql_filter } AND ( { lv_search_sql } ) )|.
    ENDIF.


    IF io_request->is_data_requested(  ).

      DATA: lt_cdredadd    TYPE cl_chdo_read_tools=>tt_cdredadd_tab,
            lr_err         TYPE REF TO cx_chdo_read_error,
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

      LOOP AT lt_cdredadd ASSIGNING FIELD-SYMBOL(<ls_cdredadd>).
        APPEND INITIAL LINE TO lt_projectuuid ASSIGNING FIELD-SYMBOL(<ls_projectuuid>).
        CONDENSE <ls_cdredadd>-tabkey.
        <ls_projectuuid> =  <ls_cdredadd>-tabkey.
      ENDLOOP.

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
          <ls_znbs_i_prj_rq_chdo>-projectuuid = <ls_znbs_prjrq>-projectuuid.
          <ls_znbs_i_prj_rq_chdo>-projectdescription = <ls_znbs_prjrq>-projectdescription.
        ENDIF.
      ENDLOOP.

      DATA(lv_offset) = io_request->get_paging(  )->get_offset(  ).
      DATA(lv_paging) = io_request->get_paging(  )->get_page_size(  ).

      SELECT  *
          FROM @lt_znbs_i_prj_rq_chdo AS znbs
          WHERE (lv_sql_filter)
          ORDER BY (lv_sort_string)
          INTO TABLE @DATA(lt_znbs_prj_rq_chdo)
          UP TO @lv_paging ROWS
          OFFSET @lv_offset.

      IF io_request->is_total_numb_of_rec_requested( ).
        SELECT COUNT( * )
            FROM @lt_znbs_i_prj_rq_chdo as zcount
            WHERE (lv_sql_filter)
            INTO @DATA(lv_prj_rq_count).

        io_response->set_total_number_of_records( lv_prj_rq_count ).
      ENDIF.

*      io_response->set_total_number_of_records( lines( lt_znbs_i_prj_rq_chdo ) ).
      io_response->set_data( lt_znbs_prj_rq_chdo ).
    ENDIF.

    TRY.
      CATCH
      cx_rfc_dest_provider_error INTO DATA(lx_dest).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

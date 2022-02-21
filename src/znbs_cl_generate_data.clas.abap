CLASS znbs_cl_generate_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZNBS_CL_GENERATE_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_statuses   TYPE TABLE OF znbs_statuses,
          lt_partners   TYPE TABLE OF znbs_partners,
          lt_categories TYPE TABLE OF znbs_categories,
          lt_teams      TYPE TABLE OF znbs_teams,
          lt_systems    TYPE TABLE OF znbs_systems,
          lt_profiles   TYPE TABLE OF znbs_profiles,
          lv_uuid       TYPE sysuuid_x16,
          lv_flpos      TYPE i.

    lt_statuses = VALUE #(
        ( uuid = 1
        name = 'Approving' type = 'Status' flowposition = 1 )
        ( uuid = 2
        name = 'Developments in Progress' type = 'Status' flowposition = 2 )
        ( uuid = 10
        name = 'Closed' type = 'Status' flowposition = 3 )


        ( uuid = 4
        name = 'PTQ in Progress' type = 'SubStatus' flowposition = 1 )
        ( uuid = 5
        name = 'HyperCare in Progress' type = 'SubStatus' flowposition = 2 )
        ( uuid = 6
        name = 'Feedback Providing' type = 'SubStatus' flowposition = 3 )
        ( uuid = 20
        name = 'Closed' type = 'SubStatus' flowposition = 4 )
        ).
    DELETE FROM znbs_statuses.
    INSERT znbs_statuses FROM TABLE @lt_statuses.
    out->write( sy-dbcnt ).


    lt_partners = VALUE #(
       ( uuid = 1 type =  'Employee'
         name = 'Volha Krencar' description = 'Volha Krencar' email = 'Volha_Krencar@gmail.com' )
       ( uuid = 2 type =  'BussinesPartner'
         name = 'Natasha Zub' description = 'Natasha Zub' email = 'Natasha_Zub@gmail.com' )
       ( uuid = 3 type =  'Developer'
         name = 'Sveta Bobr' description = 'Sveta Bobr' email = 'Sveta_Bobr@gmail.com' )
        ).
    DELETE FROM znbs_partners.
    INSERT znbs_partners FROM TABLE @lt_partners.
    out->write( sy-dbcnt ).


    lt_categories = VALUE #(
       ( uuid = 1 name =  'Lean Digital Core' )
       ( uuid = 2 name =  'OBBR')
        ).
    DELETE FROM znbs_categories.
    INSERT znbs_categories FROM TABLE @lt_categories.
    out->write( sy-dbcnt ).

    lt_teams = VALUE #(
       ( uuid = 1 name =  'ABAP on Cloud'
         description = 'ABAP on Cloud' role = 'Developers' )
       ( uuid = 2 name =  'ABAP'
         description = 'ABAP' role = 'Developers' )
       ( uuid = 3 name =  'JS'
         description = 'Java Script' role = 'Developers' )
       ( uuid = 4 name =  'Java'
         description = 'Java' role = 'Developers' )
       ( uuid = 5 name =  'Testing'
         description = 'Testing' role = 'Testers' )
        ).

    DELETE FROM znbs_teams.
    INSERT znbs_teams FROM TABLE @lt_teams.
    out->write( sy-dbcnt ).

    lt_systems = VALUE #(
       ( uuid = 1 systemids =  'D11 ABAP SHARED' )
       ( uuid = 2 systemids =  'E88 ABAP' )
       ( uuid = 3 systemids =  'NWD ABAP' )
        ).
    DELETE FROM znbs_systems.
    INSERT znbs_systems FROM TABLE @lt_systems.
    out->write( sy-dbcnt ).

    lt_profiles = VALUE #(
       ( profileuuid = 1 name =  'ABAP on Cloud' )
       ( profileuuid = 2 name =  'ABAP' )
       ( profileuuid = 3 name =  'JS' )
       ( profileuuid = 4 name =  'Java' )
       ( profileuuid = 5 name =  'C#' )
       ( profileuuid = 6 name =  'Phyton' )
        ).
    DELETE FROM znbs_profiles.
    INSERT znbs_profiles FROM TABLE @lt_profiles.
    out->write( sy-dbcnt ).



*    DELETE FROM znbs_projects_d.
*    DELETE FROM znbs_projects.*    out->write( sy-dbcnt ).

*    DELETE FROM znbs_prj_status.
*    INSERT znbs_prj_status FROM TABLE @lt_prj_status.

*    lv_flpos = 0.
*    DO 9 TIMES.
*      UPDATE znbs_prj_status
*          SET projectstatus = REPLACE( projectstatus,'0000', ' ' )
*          WHERE flowposition = @lv_flpos.
*      lv_flpos = lv_flpos + 1.
*    ENDDO.

*    SELECT * FROM znbs_partners INTO TABLE @lt_partners.
*    out->write( sy-dbcnt ).
*    out->write( 'Project Status data inserted successfully!').

*    DELETE FROM znbs_teams.
*    DELETE FROM znbs_categories.
*    DELETE FROM znbs_partners.
*    DELETE FROM znbs_statuses.
*    DELETE FROM znbs_projects_d.
*    DELETE FROM znbs_projects.
*    DELETE from znbs_epic.
*
*    DELETE from znbs_epic_d.
*    DELETE FROM znbs_task.
*    DELETE FROM znbs_task_d.
*    DELETE FROM znbs_developer.
*    DELETE FROM znbs_developer_d.
*    DELETE FROM znbs_systems.
*    DELETE FROM znbs_prj_teams.
*    DELETE FROM znbs_prj_teams_d.
  ENDMETHOD.
ENDCLASS.

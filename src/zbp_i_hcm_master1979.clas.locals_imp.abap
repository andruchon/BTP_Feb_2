CLASS lcl_buffer DEFINITION .
  PUBLIC SECTION.
    CONSTANTS: created TYPE c LENGTH 1 VALUE 'C',
               UPDAted TYPE c LENGTH 1 VALUE 'U',
               deleted TYPE c LENGTH 1 VALUE 'D'.
    TYPES: BEGIN OF ty_buffer_master.
             INCLUDE TYPE zhcm_master1979 AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_BUFFER_MASTER.
    TYPES: tt_master TYPE SORTED TABLE OF ty_buffer_master WITH UNIQUE KEY e_number.
    CLASS-DATA mt_buffer_master TYPE tt_master.
ENDCLASS.
CLASS lhc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR HCMMaster RESULT result.

    METHODS:  create FOR MODIFY IMPORTING entities FOR CREATE HCMMaster,
      update FOR MODIFY IMPORTING entities FOR UPDATE HCMMaster,
      delete FOR MODIFY IMPORTING keys FOR DELETE HCMMaster.

    METHODS read FOR READ IMPORTING keys FOR READ HCMMaster RESULT result.

ENDCLASS.

CLASS lhc_HCMMaster IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
    GET TIME STAMP FIELD DATA(lv_time_stamp).

    SELECT MAX( e_number )
    FROM zhcm_master1979
    INTO @DATA(lv_max_emp_number).

    LOOP AT entities INTO DATA(ls_entities).
      ls_entities-%data-CreaDateTime = lv_time_stamp.
      ls_entities-%data-CreaUname = cl_abap_context_info=>get_user_technical_name(  ). "sy-uname
      ls_entities-%data-ENumber = lv_max_emp_number + 1.

      INSERT VALUE #( flag = lcl_buffer=>created
                      data = CORRESPONDING #( ls_entities-%data
             MAPPING e_number       = ENumber
                     e_name         = EName
                     e_department   = EDepartment
                     status         = Status
                     job_tittle     = JobTittle
                     start_date     = StartDate
                     end_date       = EndDate
                     email          = Email
                     m_number       = MNumber
                     m_name         = MName
                     m_department   = MDepartment
                     crea_date_time = CreaDateTime
                     crea_uname     = CreaUname
                     lchg_date_time = LchgDateTime
                     lchg_uname     = LchgUname ) ) INTO TABLE lcl_buffer=>mt_buffer_master.

      IF NOT ls_entities-%cid IS INITIAL.
        INSERT VALUE #( %cid = ls_entities-%cid
                        enumber = ls_entities-enumber ) INTO TABLE mapped-hcmmaster.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.

    GET TIME STAMP FIELD DATA(lv_time_stamp).

    LOOP AT entities INTO DATA(ls_entities).

      SELECT SINGLE *
     FROM zhcm_master1979
     WHERE e_number EQ @ls_entities-%data-enumber
     INTO @DATA(ls__ddbb).

      ls_entities-%data-LchgDateTime = lv_time_stamp.
      ls_entities-%data-LchgUname = cl_abap_context_info=>get_user_technical_name(  ). "sy-uname

      INSERT VALUE #( flag = lcl_buffer=>updated
                      data = VALUE #(
                      e_number = ls_entities-%data-ENumber
                      e_name = COND #( WHEN ls_entities-%control-EName EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-EName
                                                        ELSE ls__ddbb-e_name )
                     e_department   = COND #( WHEN ls_entities-%control-EDepartment EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-EDepartment
                                                        ELSE ls__ddbb-e_department )
                     status         = COND #( WHEN ls_entities-%control-Status EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-Status
                                                        ELSE ls__ddbb-status )
                     job_tittle     = COND #( WHEN ls_entities-%control-JobTittle EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-JobTittle
                                                        ELSE ls__ddbb-job_tittle )
                     start_date     = COND #( WHEN ls_entities-%control-Startdate EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-Startdate
                                                        ELSE ls__ddbb-start_date )
                     end_date       = COND #( WHEN ls_entities-%control-Enddate EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-Enddate
                                                        ELSE ls__ddbb-End_date )
                     email          = COND #( WHEN ls_entities-%control-Email EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-Email
                                                        ELSE ls__ddbb-Email )
                     m_number       = COND #( WHEN ls_entities-%control-Mnumber EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-MNumber
                                                        ELSE ls__ddbb-M_Number )
                     m_name         = COND #( WHEN ls_entities-%control-MName EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-MName
                                                        ELSE ls__ddbb-M_Name )
                     m_department   = COND #( WHEN ls_entities-%control-Mdepartment EQ if_abap_behv=>mk-on
                                                        THEN  ls_entities-%data-Mdepartment
                                                        ELSE ls__ddbb-M_department )
                     crea_date_time = ls__ddbb-crea_date_time
                     crea_uname     = ls__ddbb-crea_uname
*                     lchg_date_time = cond #( when ls_entities-%control-LchgDateTime eq if_abap_behv=>mk-on
*                                                        then  ls_entities-%control-LchgDateTime
*                                                        elSE ls__ddbb-lchg_date_time )
*                     lchg_uname     = cond #( when ls_entities-%control-LchgUname eq if_abap_behv=>mk-on
*                                                        then  ls_entities-%control-LchgUname
*                                                        elSE ls__ddbb-lchg_uname )
                                                         ) ) INTO TABLE lcl_buffer=>mt_buffer_master.

      IF NOT ls_entities-enumber IS INITIAL.
        INSERT VALUE #( %cid = ls_entities-%data-enumber
                        enumber = ls_entities-%data-enumber ) INTO TABLE mapped-hcmmaster.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_keys).

      INSERT VALUE #( flag = lcl_buffer=>deleted
                      data = VALUE #( e_number = ls_keys-%key-ENumber ) )
                  INTO TABLE lcl_buffer=>mt_buffer_master.

      IF  ls_keys-ENumber IS NOT INITIAL.
        INSERT VALUE #( %cid = ls_keys-%key-ENumber
                        ENumber = ls_keys-%key-ENumber )
             INTO TABLE mapped-hcmmaster.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_HCMMaster DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS:
      finalize REDEFINITION,
      check_before_save REDEFINITION,
      save REDEFINITION.
*      cleanup REDEFINITION,
*      cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_HCMMaster IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA: lt_data_created TYPE STANDARD TABLE OF zhcm_master1979,
          lt_data_updated TYPE STANDARD TABLE OF zhcm_master1979,
          lt_data_deleted TYPE STANDARD TABLE OF zhcm_master1979.

    lt_data_created = VALUE #( FOR <row> IN lcl_buffer=>mt_buffer_master
                         WHERE ( flag = lcl_buffer=>created ) ( <row>-data ) ).
    IF lt_data_created IS NOT INITIAL.
      INSERT zhcm_master1979 FROM TABLE @lt_data_created.
    ENDIF.

    lt_data_updated = VALUE #( FOR <row> IN lcl_buffer=>mt_buffer_master
                         WHERE ( flag = lcl_buffer=>updated ) ( <row>-data ) ).
    IF lt_data_updated IS NOT INITIAL.
      UPDATE zhcm_master1979 FROM TABLE @lt_data_updated.
    ENDIF.

    lt_data_deleted = VALUE #( FOR <row> IN lcl_buffer=>mt_buffer_master
                        WHERE ( flag = lcl_buffer=>deleted ) ( <row>-data ) ).
    IF lt_data_deleted IS NOT INITIAL.
      DELETE zhcm_master1979 FROM TABLE @lt_data_DELEted.
    ENDIF.

    CLEAR lcl_buffer=>mt_buffer_master.
  ENDMETHOD.

*  METHOD cleanup.
*  ENDMETHOD.
*
*  METHOD cleanup_finalize.
*  ENDMETHOD.

ENDCLASS.

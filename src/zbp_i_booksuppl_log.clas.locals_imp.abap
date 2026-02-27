CLASS lhc_Supplement DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalSupplPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Supplement~calculateTotalSupplPrice.

ENDCLASS.

CLASS lhc_Supplement IMPLEMENTATION.

  METHOD calculateTotalSupplPrice.
    IF NOT keys IS INITIAL.
      zcl_aux_travel_det_1979log=>calculate_price( it_travel_id =
      VALUE #( FOR GROUPS <booking_suppl> OF booking_key IN keys
      GROUP BY booking_key-travel_id WITHOUT MEMBERS ( <booking_suppl> ) ) ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_supplemt DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PUBLIC SECTION.
    CONSTANTS: create TYPE string VALUE 'C',
               UPDATe TYPE string VALUE 'U',
               delete TYPE string VALUE 'D'.
  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.
ENDCLASS.

CLASS lsc_supplemt IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_supplemnts TYPE zbooksup_1979log,
          lv_op_type    TYPE zde_flag1979,
          lv_update     TYPE zde_flag1979.

    IF NOT create-supplement IS INITIAL.
      lt_supplemnts = CORRESPONDING #( create-supplement[ 1 ] ).
      lv_op_type = lsc_supplemt=>create.
    ENDIF.

    IF NOT update-supplement IS INITIAL.
      lt_supplemnts = CORRESPONDING #( update-supplement[ 1 ] ).
      lv_op_type = lsc_supplemt=>update.
    ENDIF.

    IF NOT delete-supplement IS INITIAL.
      lt_supplemnts = CORRESPONDING #( delete-supplement[ 1 ] ).
      lv_op_type = lsc_supplemt=>delete.
    ENDIF.

    IF NOT lt_supplemnts IS INITIAL.
      CALL FUNCTION 'ZFM_SUPPL_1979LOG'
        EXPORTING
          it_suupplents = lt_supplemnts
          iv_op_type    = lv_op_type
        IMPORTING
          ev_updated    = lv_update.
      IF lv_update EQ abap_true.
*          REPORTED-supplement[ ].
      ENDIF.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

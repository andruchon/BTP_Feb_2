FUNCTION zfm_suppl_1979log.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IT_SUUPPLENTS) TYPE  ZTT_SUPPL_1979LOG
*"     REFERENCE(IV_OP_TYPE) TYPE  ZDE_FLAG1979
*"  EXPORTING
*"     REFERENCE(EV_UPDATED) TYPE  ZDE_FLAG1979
*"----------------------------------------------------------------------
  CHECK it_suupplents IS NOT INITIAL.

  CASE iv_op_type.
    WHEN 'C'.
      INSERT zbooksup_1979log FROM TABLE @it_suupplents.
    WHEN 'U'.
      UPDATE zbooksup_1979log FROM TABLE @it_suupplents.
    WHEN 'D'.
      DELETE zbooksup_1979log FROM TABLE @it_suupplents.
    WHEN OTHERS.
  ENDCASE.

  IF sy-subrc EQ 0.
    ev_updated = abap_true.
  ENDIF.


ENDFUNCTION.

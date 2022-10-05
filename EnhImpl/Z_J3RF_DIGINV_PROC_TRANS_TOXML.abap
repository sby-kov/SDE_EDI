METHOD transform_to_xml.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""$"$\SE:(1) Class CL_J3RF_DIGINV_PROCESSOR, Method TRANSFORM_TO_XML, Start                                                                                    A
*$*$-Start: (1)---------------------------------------------------------------------------------$*$*
ENHANCEMENT 1  Z_J3RF_DIGINV_PROC_TRANS_TOXML.    "active version
* проверка на приказ 820
DATA lv_eo TYPE string. "J_3RFINV_ORIGE .
FIELD-SYMBOLS: <fs1> type data
             , <eo>  type data
             , <fv>  type data
             , <knd> type data
             .
Assign ir_data->* to <fs1>.
ASSIGN COMPONENT 'EXT_ORIG'     OF structure <fs1> TO <eo>.
ASSIGN COMPONENT 'FILEFORMVER'  OF structure <fs1> TO <fv>.
ASSIGN COMPONENT 'KND'          OF structure <fs1> TO <knd>.
  lv_eo = <eo>.
  IF zcl_fns=>kschl( ext_orig = lv_eo ) = '820'.  "<fs1>-ext_orig   <eo>
*    IF 'BYST, ESAPUNOV' CS sy-uname. " см. ENDIF !

      <fv>  = '5.01' .
      " тут уточнить, м.б. КНД зависит от: СЧФ или УПД или..., тогда CASE
      <knd> = '1115131' .

*    ENDIF. " BYST, ESAPUNOV

  ENDIF.
ENDENHANCEMENT.
*$*$-End:   (1)---------------------------------------------------------------------------------$*$*
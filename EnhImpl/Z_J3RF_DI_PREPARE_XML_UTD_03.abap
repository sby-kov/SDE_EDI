ENHANCEMENT-POINT J3RF_DI_PREPARE_XML_UTD_03 SPOTS ES_J3RF_DI_REGINV .
*$*$-Start: J3RF_DI_PREPARE_XML_UTD_03----------------------------------------------------------$*$*
ENHANCEMENT 1  Z_J3RF_DI_PREPARE_XML_UTD_03.    "active version
*
*  data ze_xml_utd like e_xml_utd .
*  ze_xml_utd = E_XML_UTD.
    DATA(lv_uname) = sy-uname.
*    IF lv_uname = 'BYST' OR lv_uname = 'ESAPUNOV'.
      DATA: lv_FNS820 TYPE string VALUE '---' . " для отработки по 820 приказу
      DATA(lv_type) = '****'.
* проверка на 820: ЕС: Этот признак = тип документа ZUT1, ZUT2, ZUT3
* т.е. когда делаем в VF02 вых.док-т такого типа, это значит по 820 приказу ФНС. Это в таблице исх.счф J_3RF_REGINV_OUT, поле KSCHL  найти можно по
      SELECT SINGLE KSCHL FROM J_3RF_REGINV_OUT
            INTO lv_type
            WHERE EXT_ORIG = e_xml_utd-EXT_ORIG.
      IF sy-subrc = 0 .
        IF 'ZUT1, ZUT2, ZUT3' CS lv_type .
            lv_FNS820 = '820'.
        ENDIF.
      ENDIF.

      IF e_xml_utd-gov_contr_id IS INITIAL.
* для тега <ДопСвФХЖ1>
*        e_xml_utd-gov_contr_id = 'ГосКонтр-0079999999'.
        e_xml_utd-curr_name = 'Российский рубль'.
*        e_xml_utd-curr_rate = 59 .  "597 / 10 .
        e_xml_utd-invoice_crt_details = '1'.  " для ZUT1
        IF lv_type = 'ZUT2'.
          e_xml_utd-invoice_crt_details = '4'.
        ENDIF.
* для приверки Диадок
        e_xml_utd-fileformver         = '5.01' .
        e_xml_utd-knd	                = '1115131'	.

      ENDIF.

* для тега <ИнфПолФХЖ1>
    IF e_xml_utd-info_file_id is initial.
      e_xml_utd-info_file_id  = '000C291B-B31C-1EED-8BB6-D83FFC8BD9B6' .

      DATA: lt_it TYPE J_3RF_DIXML_INFOTEXT_T
          , ls_it TYPE J_3RF_DIXML_INFOTEXT
          .
      ls_it-infotext = 'текст-1 файла'.
      ls_it-infoid  = 'комментарий-1'.
      APPEND ls_it TO lt_it.
      e_xml_utd-info_text = lt_it.  " пихнём в поле

    ENDIF.
*    info
*  e_xml_utd-INFO_TEXT

*  ENDIF.

ENDENHANCEMENT.
*$*$-End:   J3RF_DI_PREPARE_XML_UTD_03----------------------------------------------------------$*$*

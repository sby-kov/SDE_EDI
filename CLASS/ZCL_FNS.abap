CLASS zcl_fns DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS kschl
      IMPORTING ext_orig      TYPE string
      RETURNING value(lv_fns) TYPE string "NA_KSCHL
    .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FNS IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_FNS=>KSCHL
* +-------------------------------------------------------------------------------------------------+
* | [--->] EXT_ORIG                       TYPE        STRING
* | [<-()] LV_FNS                         TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD kschl.
* проверка на 820: ЕС: Этот признак = тип документа ZUT1, ZUT2, ZUT3
* т.е. когда делаем в VF02 вых.док-т такого типа, это значит по 820 приказу ФНС.
    DATA lv_type TYPE na_kschl.
*    DATA:  lv_FNS  TYPE string
*        .
* Это в таблице исх.счф J_3RF_REGINV_OUT, поле KSCHL  найти можно по EXT_ORIG
    SELECT SINGLE kschl FROM j_3rf_reginv_out
          INTO lv_type
          WHERE EXT_ORIG = ext_orig. "e_xml_utd-EXT_ORIG.
    IF sy-subrc = 0 .
      IF 'ZUT1, ZUT2, ZUT3' CS lv_type .
        lv_fns = '820'.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
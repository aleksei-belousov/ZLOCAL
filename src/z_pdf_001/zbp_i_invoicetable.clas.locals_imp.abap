CLASS lhc_invoice DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION IMPORTING keys REQUEST requested_authorizations FOR invoice RESULT result.

    METHODS on_create  FOR DETERMINE ON MODIFY IMPORTING keys FOR invoice~on_create.

    METHODS make_pdf FOR MODIFY IMPORTING keys FOR ACTION invoice~make_pdf.

ENDCLASS.

CLASS lhc_invoice IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD. " get_instance_authorizations

  METHOD make_pdf.

*   read transfered instances
    READ ENTITIES OF zi_invoicetable IN LOCAL MODE
      ENTITY Invoice
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

        IF ( <entity>-%is_draft = '00' ). " Saved
        ENDIF.

        IF ( <entity>-%is_draft = '01' ). " Draft
        ENDIF.

        DATA lv_xml_data        TYPE xstring.
        DATA lv_xdp             TYPE xstring.
        DATA ls_options         TYPE cl_fp_ads_util=>ty_gs_options_pdf.
        DATA ev_pdf             TYPE xstring.
        DATA ev_pages           TYPE int4.
        DATA ev_trace_string    TYPE string.

        TRY.

*           XML
            DATA(xml_data) =
            '<?xml version="1.0" encoding="UTF-8"?>' &&
            '<form1>' &&
            '<InvoiceNumber>' && <entity>-Invoice && '</InvoiceNumber>' &&
            '<Comments>' && <entity>-Comments && '</Comments>' &&
            '</form1>'.

            lv_xml_data = cl_abap_message_digest=>string_to_xstring( xml_data ).

*           XDP
*            lv_xdp = <entity>-xdp. " cl_abap_message_digest=>string_to_xstring( text ).

*           Convert Base64 (string) into Xstring (binary)
            DATA(base64_xdp) =
            'PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCjw/eGZhIGdlbmVyYXRvcj0iQWRvYmVMaXZlQ3ljbGVEZXNpZ25lcl9WMTEuMC4xLjIwMTQwMjE4LjEuOTA3MTYyX1NBUCIgQVBJVmVyc2lvbj0iMy42LjEzMzI0LjAiPz4NCjx4ZHA6eGRwIHhtbG5zOnhkcD0iaHR0cDovL25zLmFkb2JlLmNv' &&
'bS94ZHAvIiB0aW1lU3' &&
            'RhbXA9IjIwMjMtMTEtMjJUMTI6MTk6NDZaIiB1dWlkPSIxZWJkNWRiYi02OGI0LTQ3NWUtYTY0ZC00YmFiM2MzZjQyZWUiPg0KPHRlbXBsYXRlIHhtbG5zOnhsaWZmPSJ1cm46b2FzaXM6bmFtZXM6dGM6eGxpZmY6ZG9jdW1lbnQ6MS4xIiB4bWxucz0iaHR0cDovL3d3dy54ZmEub3JnL3NjaGVtYS94ZmEtdGVtcG' &&
'xhdGUvMy4zLyI+DQog' &&
            'ICA8P2Zvcm1TZXJ2ZXIgZGVmYXVsdFBERlJlbmRlckZvcm1hdCBhY3JvYmF0MTAuMGR5bmFtaWM/Pg0KICAgPD9mb3JtU2VydmVyIGFsbG93UmVuZGVyQ2FjaGluZyAwPz4NCiAgIDw/Zm9ybVNlcnZlciBmb3JtTW9kZWwgYm90aD8+DQogICA8c3ViZm9ybSBuYW1lPSJmb3JtMSIgbGF5b3V0PSJ0YiIgbG9jYWxl' &&
'PSJza19TSyIgcmVzdG' &&
            '9yZVN0YXRlPSJhdXRvIj4NCiAgICAgIDxwYWdlU2V0Pg0KICAgICAgICAgPHBhZ2VBcmVhIG5hbWU9IlBhZ2UxIiBpZD0iUGFnZTEiPg0KICAgICAgICAgICAgPGNvbnRlbnRBcmVhIHg9IjAuMjVpbiIgeT0iMC4yNWluIiB3PSIxOTcuM21tIiBoPSIyODQuM21tIi8+DQogICAgICAgICAgICA8bWVkaXVtIHN0b2' &&
'NrPSJhNCIgc2hvcnQ9' &&
            'IjIxMG1tIiBsb25nPSIyOTdtbSIvPg0KICAgICAgICAgICAgPD90ZW1wbGF0ZURlc2lnbmVyIGV4cGFuZCAxPz48L3BhZ2VBcmVhPg0KICAgICAgICAgPD90ZW1wbGF0ZURlc2lnbmVyIGV4cGFuZCAxPz48L3BhZ2VTZXQ+DQogICAgICA8c3ViZm9ybSB3PSIxOTcuM21tIiBoPSIyODQuM21tIj4NCiAgICAgICAg' &&
'IDxmaWVsZCBuYW1lPS' &&
            'JJbnZvaWNlTnVtYmVyIiB5PSI0MS4yNzVtbSIgeD0iNjYuNjc1bW0iIHc9IjYybW0iIGg9IjltbSIgYWNjZXNzPSJyZWFkT25seSI+DQogICAgICAgICAgICA8dWk+DQogICAgICAgICAgICAgICA8bnVtZXJpY0VkaXQ+DQogICAgICAgICAgICAgICAgICA8Ym9yZGVyPg0KICAgICAgICAgICAgICAgICAgICAgPG' &&
'VkZ2Ugc3Ryb2tlPSJs' &&
            'b3dlcmVkIi8+DQogICAgICAgICAgICAgICAgICA8L2JvcmRlcj4NCiAgICAgICAgICAgICAgICAgIDxtYXJnaW4vPg0KICAgICAgICAgICAgICAgPC9udW1lcmljRWRpdD4NCiAgICAgICAgICAgIDwvdWk+DQogICAgICAgICAgICA8Zm9udCB0eXBlZmFjZT0iQXJpYWwiLz4NCiAgICAgICAgICAgIDxtYXJnaW4g' &&
'dG9wSW5zZXQ9IjFtbS' &&
            'IgYm90dG9tSW5zZXQ9IjFtbSIgbGVmdEluc2V0PSIxbW0iIHJpZ2h0SW5zZXQ9IjFtbSIvPg0KICAgICAgICAgICAgPHBhcmEgdkFsaWduPSJtaWRkbGUiLz4NCiAgICAgICAgICAgIDx2YWx1ZT4NCiAgICAgICAgICAgICAgIDxkZWNpbWFsIGZyYWNEaWdpdHM9Ii0xIi8+DQogICAgICAgICAgICA8L3ZhbHVlPg' &&
'0KICAgICAgICAgICAg' &&
            'PGNhcHRpb24gcmVzZXJ2ZT0iMjVtbSI+DQogICAgICAgICAgICAgICA8cGFyYSB2QWxpZ249Im1pZGRsZSIvPg0KICAgICAgICAgICAgICAgPHZhbHVlPg0KICAgICAgICAgICAgICAgICAgPHRleHQgeGxpZmY6cmlkPSJCQTk1RTI5MS1FRjdFLTRBOUQtOEExRS04MDcwM0ExNDg1NzIiPkludm9pY2UgTnVtYmVy' &&
'PC90ZXh0Pg0KICAgIC' &&
            'AgICAgICAgICAgPC92YWx1ZT4NCiAgICAgICAgICAgIDwvY2FwdGlvbj4NCiAgICAgICAgICAgIDxiaW5kIG1hdGNoPSJkYXRhUmVmIiByZWY9IiQuSW52b2ljZU51bWJlciIvPg0KICAgICAgICAgPC9maWVsZD4NCiAgICAgICAgIDxmaWVsZCBuYW1lPSJDb21tZW50IiB5PSI1My45NzVtbSIgeD0iNjYuNjc1bW' &&
'0iIHc9IjkyLjA3NW1t' &&
            'IiBoPSI5bW0iIGFjY2Vzcz0icmVhZE9ubHkiPg0KICAgICAgICAgICAgPHVpPg0KICAgICAgICAgICAgICAgPHRleHRFZGl0Pg0KICAgICAgICAgICAgICAgICAgPGJvcmRlcj4NCiAgICAgICAgICAgICAgICAgICAgIDxlZGdlIHN0cm9rZT0ibG93ZXJlZCIvPg0KICAgICAgICAgICAgICAgICAgPC9ib3JkZXI+' &&
'DQogICAgICAgICAgIC' &&
            'AgICAgICA8bWFyZ2luLz4NCiAgICAgICAgICAgICAgIDwvdGV4dEVkaXQ+DQogICAgICAgICAgICA8L3VpPg0KICAgICAgICAgICAgPGZvbnQgdHlwZWZhY2U9IkFyaWFsIi8+DQogICAgICAgICAgICA8bWFyZ2luIHRvcEluc2V0PSIxbW0iIGJvdHRvbUluc2V0PSIxbW0iIGxlZnRJbnNldD0iMW1tIiByaWdodE' &&
'luc2V0PSIxbW0iLz4N' &&
            'CiAgICAgICAgICAgIDxwYXJhIHZBbGlnbj0ibWlkZGxlIi8+DQogICAgICAgICAgICA8Y2FwdGlvbiByZXNlcnZlPSIyNW1tIj4NCiAgICAgICAgICAgICAgIDxwYXJhIHZBbGlnbj0ibWlkZGxlIi8+DQogICAgICAgICAgICAgICA8dmFsdWU+DQogICAgICAgICAgICAgICAgICA8dGV4dCB4bGlmZjpyaWQ9IkQ5' &&
'RDU0NDgyLUZBMzItND' &&
            'c5NC1CQjJBLTUzQjYzRkNDQjBDMiI+Q29tbWVudHM8L3RleHQ+DQogICAgICAgICAgICAgICA8L3ZhbHVlPg0KICAgICAgICAgICAgPC9jYXB0aW9uPg0KICAgICAgICAgICAgPGJpbmQgbWF0Y2g9ImRhdGFSZWYiIHJlZj0iJC5Db21tZW50cyIvPg0KICAgICAgICAgPC9maWVsZD4NCiAgICAgICAgIDw/dGVtcG' &&
'xhdGVEZXNpZ25lciBl' &&
            'eHBhbmQgMT8+PC9zdWJmb3JtPg0KICAgICAgPHByb3RvLz4NCiAgICAgIDxkZXNjPg0KICAgICAgICAgPHRleHQgbmFtZT0idmVyc2lvbiI+MTEuMC4xLjIwMTQwMjE4LjEuOTA3MTYyLjkwMzgwMTwvdGV4dD4NCiAgICAgIDwvZGVzYz4NCiAgICAgIDw/dGVtcGxhdGVEZXNpZ25lciBIeXBoZW5hdGlvbiBleGNs' &&
'dWRlSW5pdGlhbENhcD' &&
            'oxLCBleGNsdWRlQWxsQ2FwczoxLCB3b3JkQ2hhckNudDo3LCByZW1haW5DaGFyQ250OjMsIHB1c2hDaGFyQ250OjM/Pg0KICAgICAgPD90ZW1wbGF0ZURlc2lnbmVyIGV4cGFuZCAxPz4NCiAgICAgIDw/cmVuZGVyQ2FjaGUuc3Vic2V0ICJBcmlhbCIgMCAwIFVURi0xNiAyIDY0IDAwMDMwMDI2MDAyQzAwMzEwMD' &&
'Q1MDA0NjAwNDgwMDRD' &&
            'MDA1MDAwNTEwMDUyMDA1NTAwNTYwMDU3MDA1ODAwNTk/Pjwvc3ViZm9ybT4NCiAgIDw/dGVtcGxhdGVEZXNpZ25lciBEZWZhdWx0UHJldmlld0R5bmFtaWMgMT8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgR3JpZCBzaG93OjEsIHNuYXA6MSwgdW5pdHM6MCwgY29sb3I6ZmY4MDgwLCBvcmlnaW46KDAsMCksIGlu' &&
'dGVydmFsOigxMjUwMD' &&
            'AsMTI1MDAwKT8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgV2lkb3dPcnBoYW5Db250cm9sIDA/Pg0KICAgPD90ZW1wbGF0ZURlc2lnbmVyIFNhdmVQREZXaXRoTG9nIDA/Pg0KICAgPD90ZW1wbGF0ZURlc2lnbmVyIERlZmF1bHRMYW5ndWFnZSBGb3JtQ2FsYz8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgRGVmYX' &&
'VsdFJ1bkF0IGNsaWVu' &&
            'dD8+DQogICA8P2Fjcm9iYXQgSmF2YVNjcmlwdCBzdHJpY3RTY29waW5nPz4NCiAgIDw/UERGUHJpbnRPcHRpb25zIGVtYmVkVmlld2VyUHJlZnMgMD8+DQogICA8P1BERlByaW50T3B0aW9ucyBlbWJlZFByaW50T25Gb3JtT3BlbiAwPz4NCiAgIDw/UERGUHJpbnRPcHRpb25zIHNjYWxpbmdQcmVmcyAwPz4NCiAg' &&
'IDw/UERGUHJpbnRPcH' &&
            'Rpb25zIGVuZm9yY2VTY2FsaW5nUHJlZnMgMD8+DQogICA8P1BERlByaW50T3B0aW9ucyBwYXBlclNvdXJjZSAwPz4NCiAgIDw/UERGUHJpbnRPcHRpb25zIGR1cGxleE1vZGUgMD8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgRGVmYXVsdFByZXZpZXdUeXBlIGludGVyYWN0aXZlPz4NCiAgIDw/dGVtcGxhdGVEZX' &&
'NpZ25lciBEZWZhdWx0' &&
            'UHJldmlld1BhZ2luYXRpb24gc2ltcGxleD8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgWERQUHJldmlld0Zvcm1hdCAyMD8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgRGVmYXVsdFByZXZpZXdEYXRhRmlsZU5hbWUgLlwxLnhtbD8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgRGVmYXVsdENhcHRpb25Gb250U2V0' &&
'dGluZ3MgZmFjZTpBcm' &&
            'lhbDtzaXplOjEwO3dlaWdodDpub3JtYWw7c3R5bGU6bm9ybWFsPz4NCiAgIDw/dGVtcGxhdGVEZXNpZ25lciBEZWZhdWx0VmFsdWVGb250U2V0dGluZ3MgZmFjZTpBcmlhbDtzaXplOjEwO3dlaWdodDpub3JtYWw7c3R5bGU6bm9ybWFsPz4NCiAgIDw/dGVtcGxhdGVEZXNpZ25lciBTYXZlVGFnZ2VkUERGIDA/Pg' &&
'0KICAgPD90ZW1wbGF0' &&
            'ZURlc2lnbmVyIFNhdmVQREZXaXRoRW1iZWRkZWRGb250cyAwPz4NCiAgIDw/dGVtcGxhdGVEZXNpZ25lciBGb3JtVGFyZ2V0VmVyc2lvbiAzMz8+DQogICA8P3RlbXBsYXRlRGVzaWduZXIgUnVsZXJzIGhvcml6b250YWw6MSwgdmVydGljYWw6MSwgZ3VpZGVsaW5lczoxLCBjcm9zc2hhaXJzOjA/Pg0KICAgPD90' &&
'ZW1wbGF0ZURlc2lnbm' &&
            'VyIFpvb20gODc/PjwvdGVtcGxhdGU+DQo8Y29uZmlnIHhtbG5zPSJodHRwOi8vd3d3LnhmYS5vcmcvc2NoZW1hL3hjaS8zLjAvIj4NCiAgIDxhZ2VudCBuYW1lPSJkZXNpZ25lciI+DQogICAgICA8IS0tICBbMC4ubl0gIC0tPg0KICAgICAgPGRlc3RpbmF0aW9uPnBkZjwvZGVzdGluYXRpb24+DQogICAgICA8cG' &&
'RmPg0KICAgICAgICAg' &&
            'PCEtLSAgWzAuLm5dICAtLT4NCiAgICAgICAgIDxmb250SW5mby8+DQogICAgICA8L3BkZj4NCiAgIDwvYWdlbnQ+DQogICA8cHJlc2VudD4NCiAgICAgIDwhLS0gIFswLi5uXSAgLS0+DQogICAgICA8cGRmPg0KICAgICAgICAgPCEtLSAgWzAuLm5dICAtLT4NCiAgICAgICAgIDx2ZXJzaW9uPjEuNzwvdmVyc2lv' &&
'bj4NCiAgICAgICAgID' &&
            'xhZG9iZUV4dGVuc2lvbkxldmVsPjg8L2Fkb2JlRXh0ZW5zaW9uTGV2ZWw+DQogICAgICA8L3BkZj4NCiAgICAgIDxjb21tb24+DQogICAgICAgICA8ZGF0YT4NCiAgICAgICAgICAgIDx4c2w+DQogICAgICAgICAgICAgICA8dXJpLz4NCiAgICAgICAgICAgIDwveHNsPg0KICAgICAgICAgICAgPG91dHB1dFhTTD' &&
'4NCiAgICAgICAgICAg' &&
            'ICAgIDx1cmkvPg0KICAgICAgICAgICAgPC9vdXRwdXRYU0w+DQogICAgICAgICA8L2RhdGE+DQogICAgICA8L2NvbW1vbj4NCiAgICAgIDx4ZHA+DQogICAgICAgICA8cGFja2V0cz4qPC9wYWNrZXRzPg0KICAgICAgPC94ZHA+DQogICA8L3ByZXNlbnQ+DQo8L2NvbmZpZz4NCjx4ZmE6ZGF0YXNldHMgeG1sbnM6' &&
'eGZhPSJodHRwOi8vd3' &&
            'd3LnhmYS5vcmcvc2NoZW1hL3hmYS1kYXRhLzEuMC8iPg0KICAgPHhmYTpkYXRhIHhmYTpkYXRhTm9kZT0iZGF0YUdyb3VwIi8+DQogICA8ZGQ6ZGF0YURlc2NyaXB0aW9uIHhtbG5zOmRkPSJodHRwOi8vbnMuYWRvYmUuY29tL2RhdGEtZGVzY3JpcHRpb24vIiBkZDpuYW1lPSJmb3JtMSI+DQogICAgICA8Zm9ybT' &&
'E+DQogICAgICAgICA8' &&
            'SW52b2ljZU51bWJlci8+DQogICAgICAgICA8Q29tbWVudHMvPg0KICAgICAgPC9mb3JtMT4NCiAgIDwvZGQ6ZGF0YURlc2NyaXB0aW9uPg0KPC94ZmE6ZGF0YXNldHM+DQo8Y29ubmVjdGlvblNldCB4bWxucz0iaHR0cDovL3d3dy54ZmEub3JnL3NjaGVtYS94ZmEtY29ubmVjdGlvbi1zZXQvMi44LyI+DQogICA8' &&
'eG1sQ29ubmVjdGlvbi' &&
            'BuYW1lPSJEYXRhQ29ubmVjdGlvbiIgZGF0YURlc2NyaXB0aW9uPSJmb3JtMSI+DQogICAgICA8dXJpPi5cMS54bWw8L3VyaT4NCiAgICAgIDw/dGVtcGxhdGVEZXNpZ25lciBmaWxlRGlnZXN0IHNoYUhhc2g9IlYyb0VHcWlxdk5mcU1CMHNWcVVpTWJUejJaaz0iPz48L3htbENvbm5lY3Rpb24+DQo8L2Nvbm5lY3' &&
'Rpb25TZXQ+DQo8bG9j' &&
            'YWxlU2V0IHhtbG5zPSJodHRwOi8vd3d3LnhmYS5vcmcvc2NoZW1hL3hmYS1sb2NhbGUtc2V0LzIuNy8iPg0KICAgPGxvY2FsZSBuYW1lPSJza19TSyIgZGVzYz0iU2xvdmFrIChTbG92YWtpYSkiPg0KICAgICAgPGNhbGVuZGFyU3ltYm9scyBuYW1lPSJncmVnb3JpYW4iPg0KICAgICAgICAgPG1vbnRoTmFtZXM+' &&
'DQogICAgICAgICAgIC' &&
            'A8bW9udGg+amFudcSCy4dyPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5mZWJydcSCy4dyPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5tYXJlYzwvbW9udGg+DQogICAgICAgICAgICA8bW9udGg+YXByxILCrWw8L21vbnRoPg0KICAgICAgICAgICAgPG1vbnRoPm3EgsuHajwvbW9udGg+DQogICAgIC' &&
'AgICAgICA8bW9udGg+' &&
            'asSCxZ9uPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5qxILFn2w8L21vbnRoPg0KICAgICAgICAgICAgPG1vbnRoPmF1Z3VzdDwvbW9udGg+DQogICAgICAgICAgICA8bW9udGg+c2VwdGVtYmVyPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5va3TEgsWCYmVyPC9tb250aD4NCiAgICAgICAgICAgIDxt' &&
'b250aD5ub3ZlbWJlcj' &&
            'wvbW9udGg+DQogICAgICAgICAgICA8bW9udGg+ZGVjZW1iZXI8L21vbnRoPg0KICAgICAgICAgPC9tb250aE5hbWVzPg0KICAgICAgICAgPG1vbnRoTmFtZXMgYWJicj0iMSI+DQogICAgICAgICAgICA8bW9udGg+amFuPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5mZWI8L21vbnRoPg0KICAgICAgICAgIC' &&
'AgPG1vbnRoPm1hcjwv' &&
            'bW9udGg+DQogICAgICAgICAgICA8bW9udGg+YXByPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5txILLh2o8L21vbnRoPg0KICAgICAgICAgICAgPG1vbnRoPmrEgsWfbjwvbW9udGg+DQogICAgICAgICAgICA8bW9udGg+asSCxZ9sPC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5hdWc8L21vbnRoPg0K' &&
'ICAgICAgICAgICAgPG' &&
            '1vbnRoPnNlcDwvbW9udGg+DQogICAgICAgICAgICA8bW9udGg+b2t0PC9tb250aD4NCiAgICAgICAgICAgIDxtb250aD5ub3Y8L21vbnRoPg0KICAgICAgICAgICAgPG1vbnRoPmRlYzwvbW9udGg+DQogICAgICAgICA8L21vbnRoTmFtZXM+DQogICAgICAgICA8ZGF5TmFtZXM+DQogICAgICAgICAgICA8ZGF5Pk' &&
'5lZGXDhMS+YTwvZGF5' &&
            'Pg0KICAgICAgICAgICAgPGRheT5Qb25kZWxvazwvZGF5Pg0KICAgICAgICAgICAgPGRheT5VdG9yb2s8L2RheT4NCiAgICAgICAgICAgIDxkYXk+U3RyZWRhPC9kYXk+DQogICAgICAgICAgICA8ZGF5PsS5wqB0dnJ0b2s8L2RheT4NCiAgICAgICAgICAgIDxkYXk+UGlhdG9rPC9kYXk+DQogICAgICAgICAgICA8' &&
'ZGF5PlNvYm90YTwvZG' &&
            'F5Pg0KICAgICAgICAgPC9kYXlOYW1lcz4NCiAgICAgICAgIDxkYXlOYW1lcyBhYmJyPSIxIj4NCiAgICAgICAgICAgIDxkYXk+TmU8L2RheT4NCiAgICAgICAgICAgIDxkYXk+UG88L2RheT4NCiAgICAgICAgICAgIDxkYXk+VXQ8L2RheT4NCiAgICAgICAgICAgIDxkYXk+U3Q8L2RheT4NCiAgICAgICAgICAgID' &&
'xkYXk+xLnCoHQ8L2Rh' &&
            'eT4NCiAgICAgICAgICAgIDxkYXk+UGE8L2RheT4NCiAgICAgICAgICAgIDxkYXk+U288L2RheT4NCiAgICAgICAgIDwvZGF5TmFtZXM+DQogICAgICAgICA8bWVyaWRpZW1OYW1lcz4NCiAgICAgICAgICAgIDxtZXJpZGllbT5BTTwvbWVyaWRpZW0+DQogICAgICAgICAgICA8bWVyaWRpZW0+UE08L21lcmlkaWVt' &&
'Pg0KICAgICAgICAgPC' &&
            '9tZXJpZGllbU5hbWVzPg0KICAgICAgICAgPGVyYU5hbWVzPg0KICAgICAgICAgICAgPGVyYT5wcmVkIG4ubC48L2VyYT4NCiAgICAgICAgICAgIDxlcmE+bi5sLjwvZXJhPg0KICAgICAgICAgPC9lcmFOYW1lcz4NCiAgICAgIDwvY2FsZW5kYXJTeW1ib2xzPg0KICAgICAgPGRhdGVQYXR0ZXJucz4NCiAgICAgIC' &&
'AgIDxkYXRlUGF0dGVy' &&
            'biBuYW1lPSJmdWxsIj5FRUVFLCBELiBNTU1NIFlZWVk8L2RhdGVQYXR0ZXJuPg0KICAgICAgICAgPGRhdGVQYXR0ZXJuIG5hbWU9ImxvbmciPkQuIE1NTU0gWVlZWTwvZGF0ZVBhdHRlcm4+DQogICAgICAgICA8ZGF0ZVBhdHRlcm4gbmFtZT0ibWVkIj5ELk0uWVlZWTwvZGF0ZVBhdHRlcm4+DQogICAgICAgICA8' &&
'ZGF0ZVBhdHRlcm4gbm' &&
            'FtZT0ic2hvcnQiPkQuTS5ZWVlZPC9kYXRlUGF0dGVybj4NCiAgICAgIDwvZGF0ZVBhdHRlcm5zPg0KICAgICAgPHRpbWVQYXR0ZXJucz4NCiAgICAgICAgIDx0aW1lUGF0dGVybiBuYW1lPSJmdWxsIj5IOk1NOlNTIFo8L3RpbWVQYXR0ZXJuPg0KICAgICAgICAgPHRpbWVQYXR0ZXJuIG5hbWU9ImxvbmciPkg6TU' &&
'06U1MgWjwvdGltZVBh' &&
            'dHRlcm4+DQogICAgICAgICA8dGltZVBhdHRlcm4gbmFtZT0ibWVkIj5IOk1NOlNTPC90aW1lUGF0dGVybj4NCiAgICAgICAgIDx0aW1lUGF0dGVybiBuYW1lPSJzaG9ydCI+SDpNTTwvdGltZVBhdHRlcm4+DQogICAgICA8L3RpbWVQYXR0ZXJucz4NCiAgICAgIDxkYXRlVGltZVN5bWJvbHM+R2FuamtIbXNTRURG' &&
'd1d4aEt6WjwvZGF0ZV' &&
            'RpbWVTeW1ib2xzPg0KICAgICAgPG51bWJlclBhdHRlcm5zPg0KICAgICAgICAgPG51bWJlclBhdHRlcm4gbmFtZT0ibnVtZXJpYyI+eix6ejkuenp6PC9udW1iZXJQYXR0ZXJuPg0KICAgICAgICAgPG51bWJlclBhdHRlcm4gbmFtZT0iY3VycmVuY3kiPnoseno5Ljk5ICQ8L251bWJlclBhdHRlcm4+DQogICAgIC' &&
'AgICA8bnVtYmVyUGF0' &&
            'dGVybiBuYW1lPSJwZXJjZW50Ij56LHp6OSU8L251bWJlclBhdHRlcm4+DQogICAgICA8L251bWJlclBhdHRlcm5zPg0KICAgICAgPG51bWJlclN5bWJvbHM+DQogICAgICAgICA8bnVtYmVyU3ltYm9sIG5hbWU9ImRlY2ltYWwiPiw8L251bWJlclN5bWJvbD4NCiAgICAgICAgIDxudW1iZXJTeW1ib2wgbmFtZT0i' &&
'Z3JvdXBpbmciPsOCwq' &&
            'A8L251bWJlclN5bWJvbD4NCiAgICAgICAgIDxudW1iZXJTeW1ib2wgbmFtZT0icGVyY2VudCI+JTwvbnVtYmVyU3ltYm9sPg0KICAgICAgICAgPG51bWJlclN5bWJvbCBuYW1lPSJtaW51cyI+LTwvbnVtYmVyU3ltYm9sPg0KICAgICAgICAgPG51bWJlclN5bWJvbCBuYW1lPSJ6ZXJvIj4wPC9udW1iZXJTeW1ib2' &&
'w+DQogICAgICA8L251' &&
            'bWJlclN5bWJvbHM+DQogICAgICA8Y3VycmVuY3lTeW1ib2xzPg0KICAgICAgICAgPGN1cnJlbmN5U3ltYm9sIG5hbWU9InN5bWJvbCI+U2s8L2N1cnJlbmN5U3ltYm9sPg0KICAgICAgICAgPGN1cnJlbmN5U3ltYm9sIG5hbWU9Imlzb25hbWUiPlNLSzwvY3VycmVuY3lTeW1ib2w+DQogICAgICAgICA8Y3VycmVu' &&
'Y3lTeW1ib2wgbmFtZT' &&
            '0iZGVjaW1hbCI+LDwvY3VycmVuY3lTeW1ib2w+DQogICAgICA8L2N1cnJlbmN5U3ltYm9scz4NCiAgICAgIDx0eXBlZmFjZXM+DQogICAgICAgICA8dHlwZWZhY2UgbmFtZT0iTXlyaWFkIFBybyIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9Ik1pbmlvbiBQcm8iLz4NCiAgICAgICAgIDx0eXBlZmFjZSBuYW' &&
'1lPSJDb3VyaWVyIFN0' &&
            'ZCIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9IkFkb2JlIFBpIFN0ZCIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9IkFkb2JlIEhlYnJldyIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9IkFkb2JlIEFyYWJpYyIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9IkFkb2JlIFRoYWkiLz4NCiAgICAg' &&
'ICAgIDx0eXBlZmFjZS' &&
            'BuYW1lPSJLb3p1a2EgR290aGljIFByby1WSSBNIi8+DQogICAgICAgICA8dHlwZWZhY2UgbmFtZT0iS296dWthIE1pbmNobyBQcm8tVkkgUiIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9IkFkb2JlIE1pbmcgU3RkIEwiLz4NCiAgICAgICAgIDx0eXBlZmFjZSBuYW1lPSJBZG9iZSBTb25nIFN0ZCBMIi8+DQ' &&
'ogICAgICAgICA8dHlw' &&
            'ZWZhY2UgbmFtZT0iQWRvYmUgTXl1bmdqbyBTdGQgTSIvPg0KICAgICAgICAgPHR5cGVmYWNlIG5hbWU9IkFkb2JlIERldmFuYWdhcmkiLz4NCiAgICAgIDwvdHlwZWZhY2VzPg0KICAgPC9sb2NhbGU+DQo8L2xvY2FsZVNldD4NCjx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFk' &&
'b2JlIFhNUCBDb3JlID' &&
            'UuNC1jMDA1IDc4LjE1MDA1NSwgMjAxMy8wOC8wNy0yMjo1ODo0NyAgICAgICAgIj4NCiAgIDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+DQogICAgICA8cmRmOkRlc2NyaXB0aW9uIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YX' &&
'AvMS4wLyIgeG1sbnM6' &&
            'cGRmPSJodHRwOi8vbnMuYWRvYmUuY29tL3BkZi8xLjMvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6ZGVzYz0iaHR0cDovL25zLmFkb2JlLmNvbS94ZmEvcHJvbW90ZWQtZGVzYy8iIHJkZjphYm91dD0iIj4NCiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIw' &&
'MjMtMTEtMjJUMTI6MT' &&
            'k6NDZaPC94bXA6TWV0YWRhdGFEYXRlPg0KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBMaXZlQ3ljbGUgRGVzaWduZXIgMTEuMDwveG1wOkNyZWF0b3JUb29sPg0KICAgICAgICAgPHBkZjpQcm9kdWNlcj5BZG9iZSBMaXZlQ3ljbGUgRGVzaWduZXIgMTEuMDwvcGRmOlByb2R1Y2VyPg0KICAgICAgIC' &&
'AgPHhtcE1NOkRvY3Vt' &&
            'ZW50SUQ+dXVpZDoxZWJkNWRiYi02OGI0LTQ3NWUtYTY0ZC00YmFiM2MzZjQyZWU8L3htcE1NOkRvY3VtZW50SUQ+DQogICAgICAgICA8ZGVzYzp2ZXJzaW9uIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4NCiAgICAgICAgICAgIDxyZGY6dmFsdWU+MTEuMC4xLjIwMTQwMjE4LjEuOTA3MTYyLjkwMzgwMTwvcmRm' &&
'OnZhbHVlPg0KICAgIC' &&
            'AgICAgICAgPGRlc2M6cmVmPi90ZW1wbGF0ZS9zdWJmb3JtWzFdPC9kZXNjOnJlZj4NCiAgICAgICAgIDwvZGVzYzp2ZXJzaW9uPg0KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+DQogICA8L3JkZjpSREY+DQo8L3g6eG1wbWV0YT48L3hkcDp4ZHA+DQo='.
            lv_xdp = cl_web_http_utility=>decode_x_base64( base64_xdp ).

*           Render PDF
            cl_fp_ads_util=>render_pdf(
                EXPORTING iv_xml_data      = lv_xml_data
                          iv_xdp_layout    = lv_xdp
                          iv_locale        = 'en_EN'
                          is_options       = ls_options
                IMPORTING ev_pdf           = ev_pdf
                          ev_pages         = ev_pages
                          ev_trace_string  = ev_trace_string
            ).

            IF ( sy-subrc = 0 ).

*               Convert Xstring (binary) into Base64 (string) (for testing)
                DATA(base64_pdf) = cl_web_http_utility=>encode_x_base64( ev_pdf ).

                DATA(filename2) = <entity>-FileName1.
                REPLACE ALL OCCURRENCES OF '.xdp' IN filename2 WITH '.pdf'.
                DATA(mimetype2) = 'application/pdf'.

                MODIFY ENTITIES OF zi_invoicetable IN LOCAL MODE
                    ENTITY Invoice
                    UPDATE FIELDS ( pdf FileName2 MimeType2 )
                    WITH VALUE #( (
                        %tky        = <entity>-%tky
                        pdf         = ev_pdf
                        FileName2   = filename2
                        MimeType2   = mimetype2
                    ) )
                    FAILED DATA(failed2)
                    MAPPED DATA(mapped2)
                    REPORTED DATA(reported2).
            ENDIF.

        CATCH cx_fp_ads_util.
        CATCH cx_abap_message_digest.

        ENDTRY.

    ENDLOOP.

  ENDMETHOD.  " make_pdf

  METHOD on_create.

*   read transfered instances
    READ ENTITIES OF zi_invoicetable IN LOCAL MODE
      ENTITY Invoice
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

        IF ( <entity>-%is_draft = '00' ). " Saved
        ENDIF.

        IF ( <entity>-%is_draft = '01' ). " Draft
        ENDIF.

*       Generate New Invoice Number
        DATA invoice TYPE zi_invoicetable-Invoice VALUE '0000000000'.
        SELECT MAX( invoice ) FROM zi_invoicetable INTO (@invoice).
        invoice  = ( invoice + 1 ).

*        Does not work here
*        MODIFY ENTITIES OF zi_invoicetable IN LOCAL MODE
*            ENTITY Invoice
*            UPDATE FIELDS ( Invoice )
*            WITH VALUE #( (
*                %tky    = <entity>-%tky
*                Invoice = invoice
*            ) )
*            FAILED DATA(failed2)
*            MAPPED DATA(mapped2)
*            REPORTED DATA(reported2).

    ENDLOOP.

  ENDMETHOD. " on_create

ENDCLASS.

CLASS zcl_shipment_002 DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA i_url         TYPE string VALUE 'https://felina-hu-scpi-test-eyjk96r2.it-cpi018-rt.cfapps.eu10-003.hana.ondemand.com/http/FiegeShipmentBindingRequest'.
    DATA i_username    TYPE string VALUE 'sb-1e950f89-c676-4acd-b0dc-24e58f8aab45!b143168|it-rt-felina-hu-scpi-test-eyjk96r2!b117912'.
    DATA i_password    TYPE string VALUE 'cc744b1f-5237-4a7e-ab44-858fdd00fb73$3wcTQpYfe1kbmjltnA8zSDb5ogj0TpaYon4WHM-TwfE='.

    METHODS http_call importing out type ref to if_oo_adt_classrun_out.
    METHODS pdf_test  importing out type ref to if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_SHIPMENT_002 IMPLEMENTATION.


  METHOD http_call.

    TRY.

        DATA(http_destination) = cl_http_destination_provider=>create_by_url( i_url = i_url ).

        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = http_destination ).

*        lo_http_client->accept_cookies( i_allow = abap_true ).

        lo_http_client->get_http_request( )->set_authorization_basic(
            i_username = i_username
            i_password = i_password
        ).

        lo_http_client->get_http_request( )->set_text( 'Hello, CPI!' ).

        DATA(lo_http_response) = lo_http_client->execute(
            i_method   = if_web_http_client=>get
*            i_timeout  = 0
        ).

        DATA(text) = lo_http_response->get_text( ).

        DATA(status) = lo_http_response->get_status( ).

        DATA(header_fields) = lo_http_response->get_header_fields( ).

        DATA(header_status) = lo_http_response->get_header_field( '~status_code' ).

        out->write( text )->write( status )->write( header_status ).

        " Whole Header
        out->write( cl_abap_char_utilities=>cr_lf && 'Whole Header:' && cl_abap_char_utilities=>cr_lf ).
        LOOP AT header_fields INTO DATA(header_field).
            out->write( cl_abap_char_utilities=>cr_lf ).
            out->write( header_field ).
        ENDLOOP.

    CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
      " Handle remote Exception
*      RAISE SHORTDUMP lx_remote.

    CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
      " Handle Exception
*      RAISE SHORTDUMP lx_gateway.

    CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
      " Handle Exception
*      RAISE SHORTDUMP lx_web_http_client_error.

    CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        "handle exception
*      RAISE SHORTDUMP lx_http_dest_provider_error.

    ENDTRY.

  ENDMETHOD. " http_call


  METHOD if_oo_adt_classrun~main.

*    http_call( out ).
    pdf_test( out ).

  ENDMETHOD. " if_oo_adt_classrun~main


  METHOD pdf_test.

    DATA lv_xml_data        TYPE xstring.
    DATA lv_xdp             TYPE xstring.
    DATA ls_options         TYPE cl_fp_ads_util=>ty_gs_options_pdf.
    DATA ev_pdf             TYPE xstring.
    DATA ev_pages           TYPE int4.
    DATA ev_trace_string    TYPE string.

    TRY.
      CATCH cx_abap_message_digest.
        "handle exception
    ENDTRY.

    TRY.

        lv_xml_data = cl_abap_message_digest=>string_to_xstring( '<Hello>Hello</Hello>' ).

        DATA(text) =
        '<?xml version="1.0" encoding="UTF-8"?>' &&
        '<?xfa generator="AdobeLiveCycleDesigner_V11.0.1.20140218.1.907162_SAP" APIVersion="3.6.13324.0"?>' &&
        '<xdp:xdp xmlns:xdp="http://ns.adobe.com/xdp/" timeStamp="2023-11-20T11:44:07Z" uuid="37ac46e2-2819-445b-aa91-56ed450f107a">' &&
        '<template xmlns:xliff="urn:oasis:names:tc:xliff:document:1.1" xmlns="http://www.xfa.org/schema/xfa-template/3.3/">' &&
        '   <?formServer defaultPDFRenderFormat acrobat10.0dynamic?>' &&
        '   <subform name="form1" layout="tb" locale="sk_SK" restoreState="auto">' &&
        '      <pageSet>' &&
        '         <pageArea name="Page1" id="Page1">' &&
        '            <contentArea x="0.25in" y="0.25in" w="576pt" h="756pt"/>' &&
        '            <medium stock="default" short="612pt" long="792pt"/>' &&
        '            <?templateDesigner expand 1?></pageArea>' &&
        '         <?templateDesigner expand 1?></pageSet>' &&
        '      <subform w="576pt" h="756pt">' &&
        '         <draw name="Text1" y="63.5mm" x="82.55mm" w="29.2864mm" h="5.2331mm">' &&
        '            <ui>' &&
        '               <textEdit/>' &&
        '            </ui>' &&
        '            <value>' &&
        '               <text xliff:rid="0E9ACF09-B226-41A9-AC98-DF9E03E8B1B7">Hello, PDF!</text>' &&
        '            </value>' &&
        '            <font typeface="Arial"/>' &&
        '            <margin topInset="0.5mm" bottomInset="0.5mm" leftInset="0.5mm" rightInset="0.5mm"/>' &&
        '         </draw>' &&
        '         <?templateDesigner expand 1?></subform>' &&
        '      <proto/>' &&
        '      <desc>' &&
        '         <text name="version">11.0.1.20140218.1.907162.903801</text>' &&
        '      </desc>' &&
        '      <?templateDesigner expand 1?>' &&
        '      <?renderCache.subset "Arial" 0 0 UTF-16 2 60 00030004000F00270029002B0033003700470048004C004F00520057005B?></subform>' &&
        '   <?templateDesigner DefaultPreviewDynamic 1?>' &&
        '   <?templateDesigner DefaultRunAt client?>' &&
        '   <?templateDesigner Grid show:1, snap:1, units:0, color:ff8080, origin:(0,0), interval:(125000,125000)?>' &&
        '   <?templateDesigner FormTargetVersion 33?>' &&
        '   <?templateDesigner DefaultCaptionFontSettings face:Arial;size:10;weight:normal;style:normal?>' &&
        '   <?templateDesigner DefaultValueFontSettings face:Arial;size:10;weight:normal;style:normal?>' &&
        '   <?templateDesigner DefaultLanguage FormCalc?>' &&
        '   <?acrobat JavaScript strictScoping?>' &&
        '   <?templateDesigner WidowOrphanControl 0?>' &&
        '   <?templateDesigner Rulers horizontal:1, vertical:1, guidelines:1, crosshairs:0?>' &&
        '   <?templateDesigner Zoom 100?>' &&
        '   <?templateDesigner SaveTaggedPDF 0?>' &&
        '   <?templateDesigner SavePDFWithEmbeddedFonts 0?>' &&
        '   <?templateDesigner SavePDFWithLog 0?></template>' &&
        '<config xmlns="http://www.xfa.org/schema/xci/3.0/">' &&
        '   <agent name="designer">' &&
        '      <!--  [0..n]  -->' &&
        '      <destination>pdf</destination>' &&
        '      <pdf>' &&
        '         <!--  [0..n]  -->' &&
        '         <fontInfo/>' &&
        '      </pdf>' &&
        '   </agent>' &&
        '   <present>' &&
        '      <!--  [0..n]  -->' &&
        '      <pdf>' &&
        '         <!--  [0..n]  -->' &&
        '         <fontInfo>' &&
        '            <embed>0</embed>' &&
        '         </fontInfo>' &&
        '         <tagged>0</tagged>' &&
        '         <version>1.7</version>' &&
        '         <adobeExtensionLevel>8</adobeExtensionLevel>' &&
        '      </pdf>' &&
        '      <xdp>' &&
        '         <packets>*</packets>' &&
        '      </xdp>' &&
        '   </present>' &&
        '</config>' &&
        '<localeSet xmlns="http://www.xfa.org/schema/xfa-locale-set/2.7/">' &&
        '   <locale name="sk_SK" desc="Slovak (Slovakia)">' &&
        '      <calendarSymbols name="gregorian">' &&
        '         <monthNames>' &&
        '            <month>január</month>' &&
        '            <month>február</month>' &&
        '            <month>marec</month>' &&
        '            <month>apríl</month>' &&
        '            <month>máj</month>' &&
        '            <month>jún</month>' &&
        '            <month>júl</month>' &&
        '            <month>august</month>' &&
        '            <month>september</month>' &&
        '            <month>október</month>' &&
        '            <month>november</month>' &&
        '            <month>december</month>' &&
        '         </monthNames>' &&
        '         <monthNames abbr="1">' &&
        '            <month>jan</month>' &&
        '            <month>feb</month>' &&
        '            <month>mar</month>' &&
        '            <month>apr</month>' &&
        '            <month>máj</month>' &&
        '            <month>jún</month>' &&
        '            <month>júl</month>' &&
        '            <month>aug</month>' &&
        '            <month>sep</month>' &&
        '            <month>okt</month>' &&
        '            <month>nov</month>' &&
        '            <month>dec</month>' &&
        '         </monthNames>' &&
        '         <dayNames>' &&
        '            <day>Nedeľa</day>' &&
        '            <day>Pondelok</day>' &&
        '            <day>Utorok</day>' &&
        '            <day>Streda</day>' &&
        '            <day>Štvrtok</day>' &&
        '            <day>Piatok</day>' &&
        '            <day>Sobota</day>' &&
        '         </dayNames>' &&
        '         <dayNames abbr="1">' &&
        '            <day>Ne</day>' &&
        '            <day>Po</day>' &&
        '            <day>Ut</day>' &&
        '            <day>St</day>' &&
        '            <day>Št</day>' &&
        '            <day>Pa</day>' &&
        '            <day>So</day>' &&
        '         </dayNames>' &&
        '         <meridiemNames>' &&
        '            <meridiem>AM</meridiem>' &&
        '            <meridiem>PM</meridiem>' &&
        '         </meridiemNames>' &&
        '         <eraNames>' &&
        '            <era>pred n.l.</era>' &&
        '            <era>n.l.</era>' &&
        '         </eraNames>' &&
        '      </calendarSymbols>' &&
        '      <datePatterns>' &&
        '         <datePattern name="full">EEEE, D. MMMM YYYY</datePattern>' &&
        '         <datePattern name="long">D. MMMM YYYY</datePattern>' &&
        '         <datePattern name="med">D.M.YYYY</datePattern>' &&
        '         <datePattern name="short">D.M.YYYY</datePattern>' &&
        '      </datePatterns>' &&
        '      <timePatterns>' &&
        '         <timePattern name="full">H:MM:SS Z</timePattern>' &&
        '         <timePattern name="long">H:MM:SS Z</timePattern>' &&
        '         <timePattern name="med">H:MM:SS</timePattern>' &&
        '         <timePattern name="short">H:MM</timePattern>' &&
        '      </timePatterns>' &&
        '      <dateTimeSymbols>GanjkHmsSEDFwWxhKzZ</dateTimeSymbols>' &&
        '      <numberPatterns>' &&
        '         <numberPattern name="numeric">z,zz9.zzz</numberPattern>' &&
        '         <numberPattern name="currency">z,zz9.99 $</numberPattern>' &&
        '         <numberPattern name="percent">z,zz9%</numberPattern>' &&
        '      </numberPatterns>' &&
        '      <numberSymbols>' &&
        '         <numberSymbol name="decimal">,</numberSymbol>' &&
        '         <numberSymbol name="grouping"> </numberSymbol>' &&
        '         <numberSymbol name="percent">%</numberSymbol>' &&
        '         <numberSymbol name="minus">-</numberSymbol>' &&
        '         <numberSymbol name="zero">0</numberSymbol>' &&
        '      </numberSymbols>' &&
        '      <currencySymbols>' &&
        '         <currencySymbol name="symbol">Sk</currencySymbol>' &&
        '         <currencySymbol name="isoname">SKK</currencySymbol>' &&
        '         <currencySymbol name="decimal">,</currencySymbol>' &&
        '      </currencySymbols>' &&
        '      <typefaces>' &&
        '         <typeface name="Myriad Pro"/>' &&
        '         <typeface name="Minion Pro"/>' &&
        '         <typeface name="Courier Std"/>' &&
        '         <typeface name="Adobe Pi Std"/>' &&
        '         <typeface name="Adobe Hebrew"/>' &&
        '         <typeface name="Adobe Arabic"/>' &&
        '         <typeface name="Adobe Thai"/>' &&
        '         <typeface name="Kozuka Gothic Pro-VI M"/>' &&
        '         <typeface name="Kozuka Mincho Pro-VI R"/>' &&
        '         <typeface name="Adobe Ming Std L"/>' &&
        '         <typeface name="Adobe Song Std L"/>' &&
        '         <typeface name="Adobe Myungjo Std M"/>' &&
        '         <typeface name="Adobe Devanagari"/>' &&
        '      </typefaces>' &&
        '   </locale>' &&
        '</localeSet>' &&
        '<x:xmpmeta xmlns:x="adobe:ns:meta/" x:xmptk="Adobe XMP Core 5.4-c005 78.150055, 2013/08/07-22:58:47        ">' &&
        '   <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">' &&
        '      <rdf:Description xmlns:xmp="http://ns.adobe.com/xap/1.0/" xmlns:pdf="http://ns.adobe.com/pdf/1.3/" xmlns:xmpMM="http://ns.adobe.com/xap/1.0/mm/" xmlns:desc="http://ns.adobe.com/xfa/promoted-desc/" rdf:about="">' &&
        '         <xmp:MetadataDate>2023-11-20T11:44:07Z</xmp:MetadataDate>' &&
        '         <xmp:CreatorTool>Adobe LiveCycle Designer 11.0</xmp:CreatorTool>' &&
        '         <pdf:Producer>Adobe LiveCycle Designer 11.0</pdf:Producer>' &&
        '         <xmpMM:DocumentID>uuid:37ac46e2-2819-445b-aa91-56ed450f107a</xmpMM:DocumentID>' &&
        '         <desc:version rdf:parseType="Resource">' &&
        '            <rdf:value>11.0.1.20140218.1.907162.903801</rdf:value>' &&
        '            <desc:ref>/template/subform[1]</desc:ref>' &&
        '         </desc:version>' &&
        '      </rdf:Description>' &&
        '   </rdf:RDF>' &&
        '</x:xmpmeta></xdp:xdp>'.

        lv_xdp = cl_abap_message_digest=>string_to_xstring( text ).

*       Render PDF
        cl_fp_ads_util=>render_pdf(
            EXPORTING iv_xml_data      = lv_xml_data
                      iv_xdp_layout    = lv_xdp
                      iv_locale        = 'en_EN'
                      is_options       = ls_options
            IMPORTING ev_pdf           = ev_pdf
                      ev_pages         = ev_pages
                      ev_trace_string  = ev_trace_string
        ).

*       CALL TRANSFORMATION id SOURCE root = it_table RESULT XML DATA(lv_xstring).

*       Back would be like:
*       DATA it_table TYPE TABLE OF string.
*       CALL TRANSFORMATION id SOURCE XML ev_pdf RESULT root = it_table[].

*       There is also a static method called "create_out( )" that can be used to convert strings into xstrings.

*       Convert xstring into string
*       So the following line of code did the trick.
        DATA(codepage) = cl_abap_conv_codepage=>get_sap_codepage( ).
        codepage = '1100'.
        codepage = '1160'.
        DATA(rv_csv_data) = cl_abap_conv_codepage=>create_in_from_sap_cp( sap_cp = codepage )->convert( ev_pdf ).

        out->write( rv_csv_data  ).

    CATCH cx_fp_ads_util.
    CATCH cx_abap_message_digest.
    CATCH cx_sy_conversion_codepage.
    CATCH cx_parameter_invalid_range.

    ENDTRY.

  ENDMETHOD. " pdf_test
ENDCLASS.

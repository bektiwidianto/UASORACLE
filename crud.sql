set define off
set verify off
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040200 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,2614113542434089));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2012.01.01');
 
end;
/

prompt  Set Application Offset...
 
begin
 
   -- SET APPLICATION OFFSET
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

 
begin
 
wwv_flow_api.remove_restful_service (
  p_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_name => 'crud'
  );
 
null;
 
end;
/

prompt  ...restful service
--
--application/restful_services/crud
 
begin
 
wwv_flow_api.create_restful_module (
  p_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_name => 'crud'
 ,p_parsing_schema => 'OBE'
 ,p_items_per_page => 25
 ,p_status => 'PUBLISHED'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3146512534667371 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'barang'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3147308190734085 + wwv_flow_api.g_id_offset
 ,p_template_id => 3146512534667371 + wwv_flow_api.g_id_offset
 ,p_source_type => 'QUERY'
 ,p_format => 'DEFAULT'
 ,p_method => 'GET'
 ,p_require_https => 'NO'
 ,p_source => 
'select * from t_barang'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3146610391667372 + wwv_flow_api.g_id_offset
 ,p_template_id => 3146512534667371 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'POST'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'declare'||unistr('\000a')||
'  id t_barang.kd_barang%TYPE;'||unistr('\000a')||
'begin'||unistr('\000a')||
'  id := t_barang_seq.nextval;'||unistr('\000a')||
''||unistr('\000a')||
'  insert into t_barang'||unistr('\000a')||
'  (kd_barang, nm_barang, jns_barang, jml_barang, harga)'||unistr('\000a')||
'  values'||unistr('\000a')||
'  (id, :nm_barang, :jns_barang, :jml_barang, :harga);'||unistr('\000a')||
''||unistr('\000a')||
'  :t_barang := id;'||unistr('\000a')||
'end;'||unistr('\000a')||
''
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3147131823722033 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3146610391667372 + wwv_flow_api.g_id_offset
 ,p_name => 'harga'
 ,p_bind_variable_name => 'harga'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3147024897720080 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3146610391667372 + wwv_flow_api.g_id_offset
 ,p_name => 'jml_barang'
 ,p_bind_variable_name => 'jml_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3146915547717352 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3146610391667372 + wwv_flow_api.g_id_offset
 ,p_name => 'jns_barang'
 ,p_bind_variable_name => 'jns_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3146723381710234 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3146610391667372 + wwv_flow_api.g_id_offset
 ,p_name => 'kd_barang'
 ,p_bind_variable_name => 'kd_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3146803080713762 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3146610391667372 + wwv_flow_api.g_id_offset
 ,p_name => 'nm_barang'
 ,p_bind_variable_name => 'nm_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3147503829817235 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'barang/{id}'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3147619759821794 + wwv_flow_api.g_id_offset
 ,p_template_id => 3147503829817235 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'DELETE'
 ,p_require_https => 'NO'
 ,p_source => 
'begin'||unistr('\000a')||
'delete t_barang where kd_barang = :id;'||unistr('\000a')||
'commit;'||unistr('\000a')||
'end;'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3147732272853600 + wwv_flow_api.g_id_offset
 ,p_template_id => 3147503829817235 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'PUT'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'BEGIN'||unistr('\000a')||
'   UPDATE t_barang SET nm_barang = :nm_barang, jns_barang = :jns_barang, jml_barang = :jml_barang,'||unistr('\000a')||
'                        harga = :harga'||unistr('\000a')||
'      WHERE kd_barang = :id;'||unistr('\000a')||
'  :location := :id;'||unistr('\000a')||
'  :status := 200;'||unistr('\000a')||
'END;'||unistr('\000a')||
''
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3147811195875631 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3147732272853600 + wwv_flow_api.g_id_offset
 ,p_name => 'harga'
 ,p_bind_variable_name => 'harga'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3148124008879257 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3147732272853600 + wwv_flow_api.g_id_offset
 ,p_name => 'jml_barang'
 ,p_bind_variable_name => 'jml_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3148020199878185 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3147732272853600 + wwv_flow_api.g_id_offset
 ,p_name => 'jns_barang'
 ,p_bind_variable_name => 'jns_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3147917082877283 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3147732272853600 + wwv_flow_api.g_id_offset
 ,p_name => 'nm_barang'
 ,p_bind_variable_name => 'nm_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3152427468614488 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'customer'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3152510630619093 + wwv_flow_api.g_id_offset
 ,p_template_id => 3152427468614488 + wwv_flow_api.g_id_offset
 ,p_source_type => 'QUERY'
 ,p_format => 'DEFAULT'
 ,p_method => 'GET'
 ,p_require_https => 'NO'
 ,p_source => 
'select * from t_customer'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3152614702639044 + wwv_flow_api.g_id_offset
 ,p_template_id => 3152427468614488 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'POST'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'declare'||unistr('\000a')||
'  id t_customer.kd_customer%TYPE;'||unistr('\000a')||
'begin'||unistr('\000a')||
'  id := t_customer_seq.nextval;'||unistr('\000a')||
''||unistr('\000a')||
'  insert into t_customer'||unistr('\000a')||
'  (kd_customer, username, alamat, no_tlp, password)'||unistr('\000a')||
'  values'||unistr('\000a')||
'  (id, :username, :alamat, :no_tlp, :password);'||unistr('\000a')||
''||unistr('\000a')||
'  :t_customer := id;'||unistr('\000a')||
'end;'||unistr('\000a')||
''
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153230809681331 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152614702639044 + wwv_flow_api.g_id_offset
 ,p_name => 'alamat'
 ,p_bind_variable_name => 'alamat'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153527477689729 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152614702639044 + wwv_flow_api.g_id_offset
 ,p_name => 'kd_customer'
 ,p_bind_variable_name => 'kd_customer'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153304968683280 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152614702639044 + wwv_flow_api.g_id_offset
 ,p_name => 'no_tlp'
 ,p_bind_variable_name => 'no_tlp'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153411894685237 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152614702639044 + wwv_flow_api.g_id_offset
 ,p_name => 'password'
 ,p_bind_variable_name => 'password'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153108300674816 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152614702639044 + wwv_flow_api.g_id_offset
 ,p_name => 'username'
 ,p_bind_variable_name => 'username'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3152721628641032 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'customer/{id}'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3152807907646469 + wwv_flow_api.g_id_offset
 ,p_template_id => 3152721628641032 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'DELETE'
 ,p_require_https => 'NO'
 ,p_source => 
'begin'||unistr('\000a')||
'delete t_customer where kd_customer = :id;'||unistr('\000a')||
'commit;'||unistr('\000a')||
'end;'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3152919812659366 + wwv_flow_api.g_id_offset
 ,p_template_id => 3152721628641032 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'PUT'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'BEGIN'||unistr('\000a')||
'   UPDATE t_customer SET username = :username, alamat = :alamat, no_tlp = :no_tlp, password = :password'||unistr('\000a')||
'      WHERE kd_customer = :id;'||unistr('\000a')||
'  :location := :id;'||unistr('\000a')||
'  :status := 200;'||unistr('\000a')||
'END;'||unistr('\000a')||
''
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153627955699296 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152919812659366 + wwv_flow_api.g_id_offset
 ,p_name => 'alamat'
 ,p_bind_variable_name => 'alamat'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153806961702721 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152919812659366 + wwv_flow_api.g_id_offset
 ,p_name => 'no_tlp'
 ,p_bind_variable_name => 'no_tlp'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153915965705270 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152919812659366 + wwv_flow_api.g_id_offset
 ,p_name => 'password'
 ,p_bind_variable_name => 'password'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3153732110700518 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3152919812659366 + wwv_flow_api.g_id_offset
 ,p_name => 'username'
 ,p_bind_variable_name => 'username'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3148608564959376 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'pembelian'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3148725187964050 + wwv_flow_api.g_id_offset
 ,p_template_id => 3148608564959376 + wwv_flow_api.g_id_offset
 ,p_source_type => 'QUERY'
 ,p_format => 'DEFAULT'
 ,p_method => 'GET'
 ,p_require_https => 'NO'
 ,p_source => 
'select * from t_pembelian'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3149406580014906 + wwv_flow_api.g_id_offset
 ,p_template_id => 3148608564959376 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'POST'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'declare'||unistr('\000a')||
'  id t_pembelian.kd_transaksi%TYPE;'||unistr('\000a')||
'begin'||unistr('\000a')||
'  id := t_pembelian_seq.nextval;'||unistr('\000a')||
''||unistr('\000a')||
'  insert into t_pembelian'||unistr('\000a')||
'  (kd_transaksi, kd_barang, kd_supplier, tgl, jml, harga)'||unistr('\000a')||
'  values'||unistr('\000a')||
'  (id, :kd_barang, :kd_supplier, TO_DATE(:tgl, ''yyyy/mm/dd''), :jml, :harga);'||unistr('\000a')||
''||unistr('\000a')||
'  :t_pembelian := id;'||unistr('\000a')||
'end;'||unistr('\000a')||
''
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3150022080038032 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3149406580014906 + wwv_flow_api.g_id_offset
 ,p_name => 'harga'
 ,p_bind_variable_name => 'harga'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'STRING'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3149914461035806 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3149406580014906 + wwv_flow_api.g_id_offset
 ,p_name => 'jml'
 ,p_bind_variable_name => 'jml'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3149611559025669 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3149406580014906 + wwv_flow_api.g_id_offset
 ,p_name => 'kd_barang'
 ,p_bind_variable_name => 'kd_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3149726451029848 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3149406580014906 + wwv_flow_api.g_id_offset
 ,p_name => 'kd_supplier'
 ,p_bind_variable_name => 'kd_supplier'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3148905925967928 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'penjualan'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3149012158969737 + wwv_flow_api.g_id_offset
 ,p_template_id => 3148905925967928 + wwv_flow_api.g_id_offset
 ,p_source_type => 'QUERY'
 ,p_format => 'DEFAULT'
 ,p_method => 'GET'
 ,p_require_https => 'NO'
 ,p_source => 
'select * from t_penjualan'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3151411566488263 + wwv_flow_api.g_id_offset
 ,p_template_id => 3148905925967928 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'POST'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'declare'||unistr('\000a')||
'  id t_penjualan.kd_transaksi%TYPE;'||unistr('\000a')||
'begin'||unistr('\000a')||
'  id := t_penjualan_seq.nextval;'||unistr('\000a')||
''||unistr('\000a')||
'  insert into t_penjualan'||unistr('\000a')||
'  (kd_transaksi, kd_barang, kd_customer, tgl, jml, harga)'||unistr('\000a')||
'  values'||unistr('\000a')||
'  (id, :kd_barang, :kd_customer, TO_DATE(:tgl, ''yyyy/mm/dd''), :jml, :harga);'||unistr('\000a')||
''||unistr('\000a')||
'  :t_penjualan := id;'||unistr('\000a')||
'end;'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3152002824504569 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3151411566488263 + wwv_flow_api.g_id_offset
 ,p_name => 'harga'
 ,p_bind_variable_name => 'harga'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3151930052502973 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3151411566488263 + wwv_flow_api.g_id_offset
 ,p_name => 'jml'
 ,p_bind_variable_name => 'jml'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3151604771495677 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3151411566488263 + wwv_flow_api.g_id_offset
 ,p_name => 'kd_barang'
 ,p_bind_variable_name => 'kd_barang'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3151717585499380 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3151411566488263 + wwv_flow_api.g_id_offset
 ,p_name => 'kd_customer'
 ,p_bind_variable_name => 'kd_customer'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'INT'
  );
 
wwv_flow_api.create_restful_param (
  p_id => 3154215188723862 + wwv_flow_api.g_id_offset
 ,p_handler_id => 3151411566488263 + wwv_flow_api.g_id_offset
 ,p_name => 'tgl'
 ,p_bind_variable_name => 'tgl'
 ,p_source_type => 'HEADER'
 ,p_access_method => 'IN'
 ,p_param_type => 'TIMESTAMP'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3151021300443953 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'supplier'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3151330005474707 + wwv_flow_api.g_id_offset
 ,p_template_id => 3151021300443953 + wwv_flow_api.g_id_offset
 ,p_source_type => 'QUERY'
 ,p_format => 'DEFAULT'
 ,p_method => 'GET'
 ,p_require_https => 'NO'
 ,p_source => 
'select * from t_supplier'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3151218923471537 + wwv_flow_api.g_id_offset
 ,p_template_id => 3151021300443953 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'POST'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'declare'||unistr('\000a')||
'  id t_supplier.id_supplier%TYPE;'||unistr('\000a')||
'begin'||unistr('\000a')||
'  id := t_supplier_seq.nextval;'||unistr('\000a')||
''||unistr('\000a')||
'  insert into t_supplier'||unistr('\000a')||
'  (id_supplier, nm_supplier, alamat, no_tlp)'||unistr('\000a')||
'  values'||unistr('\000a')||
'  (id, :nm_supplier, :alamat, :no_tlp);'||unistr('\000a')||
''||unistr('\000a')||
'  :t_supplier := id;'||unistr('\000a')||
'end;'
  );
 
wwv_flow_api.create_restful_template (
  p_id => 3151105501448877 + wwv_flow_api.g_id_offset
 ,p_module_id => 3146404849667369 + wwv_flow_api.g_id_offset
 ,p_uri_template => 'supplier/{id}'
 ,p_priority => 0
 ,p_etag_type => 'HASH'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3152215947554801 + wwv_flow_api.g_id_offset
 ,p_template_id => 3151105501448877 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'DELETE'
 ,p_require_https => 'NO'
 ,p_source => 
'begin'||unistr('\000a')||
'delete t_supplier where id_supplier = :id;'||unistr('\000a')||
'commit;'||unistr('\000a')||
'end;'
  );
 
wwv_flow_api.create_restful_handler (
  p_id => 3152313270610415 + wwv_flow_api.g_id_offset
 ,p_template_id => 3151105501448877 + wwv_flow_api.g_id_offset
 ,p_source_type => 'PLSQL'
 ,p_format => 'DEFAULT'
 ,p_method => 'PUT'
 ,p_mimes_allowed => 'application/json'
 ,p_require_https => 'NO'
 ,p_source => 
'BEGIN'||unistr('\000a')||
'   UPDATE t_supplier SET nm_supplier = :nm_supplier, alamat = :alamat, no_tlp = :no_tlp'||unistr('\000a')||
'      WHERE id_supplier = :id;'||unistr('\000a')||
'  :location := :id;'||unistr('\000a')||
'  :status := 200;'||unistr('\000a')||
'END;'||unistr('\000a')||
''
  );
 
null;
 
end;
/

commit;
begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
set define on
prompt  ...done

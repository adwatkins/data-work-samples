ALTER SESSION SET CURRENT_SCHEMA=apex_040200
/
begin
  wwv_flow_api.set_security_group_id(p_security_group_id=>123456789);
  wwv_flow_fnd_user_api.create_fnd_user (
    p_user_name    => 'TESTUSER1',
    p_first_name   => 'FIRST',
    p_last_name    => 'LAST',
    p_web_password => 'pass',
    p_email_address=> 'name@company.com',
    p_default_schema               => 'A',
    p_account_locked               => 'N');
  commit;
end;
/
ALTER SESSION SET CURRENT_SCHEMA=AO



/
ALTER SESSION SET CURRENT_SCHEMA = APEX_040200;
declare 
    nm owa.vc_arr; 
    vl owa.vc_arr;
begin

    nm(1) := 'foo'; 
    vl(1) := 'bar'; 
    wwv_flow_api.set_security_group_id(p_security_group_id=>2590924964525269);
    owa.init_cgi_env( nm.count, nm, vl); 
    wwv_flow_fnd_user_api.create_fnd_user (
      p_user_name    => 'TESTUSER2',
      p_first_name   => 'New',
      p_last_name    => 'Testuser',
      p_web_password => 'Password123',
      p_default_schema               => 'B',
      p_account_locked               => 'N',
      p_failed_access_attempts       => 0,
      p_change_password_on_first_use => 'N',
      p_first_password_use_occurred  => 'N',
      p_allow_app_building_yn        => 'Y',
      p_allow_sql_workshop_yn        => 'Y',
      p_allow_websheet_dev_yn        => 'Y',
      p_allow_team_development_yn    => 'N');    
end;


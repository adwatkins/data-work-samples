 select dbms_metadata.get_ddl('VIEW', upper('apex_workspace_apex_users'), 'APEX_040200') obj from dual;
  CREATE OR REPLACE FORCE VIEW "APEX_040200"."APEX_WORKSPACE_APEX_USERS" ("WORKSPACE_ID", "WORKSPACE_NAME", "WORKSPACE_DISPLAY_NAME", "FIRST_SCHEMA_PROVISIONED", "USER_NAME", "FIRST_NAME", "LAST_NAME", "EMAIL", "DATE_CREATED", "DATE_LAST_UPDATED", "AVAILABLE_SCHEMAS", "IS_ADMIN", "IS_APPLICATION_DEVELOPER", "ACCOUNT_LOCKED", "DESCRIPTION") AS
  select
    workspace_id,
    workspace_name,
    workspace_display_name,
    first_schema_provisioned,
    user_name,
    first_name,
    last_name,
    email,
    date_created,
    date_last_updated,
    available_schemas,
    substr(decode(instr(nvl(role_privs,'x'),'ADMIN'),0,'No','Yes'),1,3)  is_admin,
    substr(decode(instr(nvl(role_privs,'x'),'EDIT'),0,'No','Yes'),1,3)   is_application_developer,
    decode(account_locked,'Y','Yes','No')                                account_locked,
    description
from (
select
    w.PROVISIONING_COMPANY_ID                                         workspace_id,
    w.short_name                                                      workspace_name,
    w.display_name                                                    workspace_display_name,
    w.FIRST_SCHEMA_PROVISIONED                                        first_schema_provisioned,
    u.user_name                                                       user_name,
    u.first_name                                                      first_name,
    u.last_name                                                       last_name,
    u.EMAIL_address                                                   email,
    u.CREATION_DATE                                                   date_created,
    u.LAST_UPDATE_DATE                                                date_last_updated,
    count(distinct s.schema)                                          available_schemas,
    (select developer_role
       from wwv_flow_developers
      where userid            = u.user_name
        and security_group_id = w.PROVISIONING_COMPANY_ID)            role_privs,
    u.account_locked                                                  account_locked,
    u.description                                                     description
from
     wwv_flow_fnd_user u,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid,
            (select sys_context('USERENV','CURRENT_USER') from sys.dual) cu
        from sys.dual) d
where (s.schema  = cu
   or (select wwv_flow_security.has_apex_administrator_role_yn(cu) from sys.dual)='Y'
   or d.sgid              = w.PROVISIONING_COMPANY_ID )
  and s.security_group_id         = w.PROVISIONING_COMPANY_ID
  and u.security_group_id         = w.PROVISIONING_COMPANY_ID
  and s.security_group_id         = u.security_group_id
  and w.PROVISIONING_COMPANY_ID ! = 0
group by  w.PROVISIONING_COMPANY_ID,
          w.short_name,
          w.display_name,
          w.FIRST_SCHEMA_PROVISIONED,
          u.user_name,
          u.first_name,
          u.last_name,
          u.EMAIL_address,
          u.CREATION_DATE,
          u.LAST_UPDATE_DATE,
          u.account_locked,
          u.description
) ilv

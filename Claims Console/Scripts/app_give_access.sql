--GROUP
insert into app_user_access 
(app_user_access_id, app_feature_id, access_type, staff_title_id, has_view, has_edit, has_delete)
values
(app_user_access_seq.nextval, 315, 'G', 19, 'Y', 'N', 'N')
/
--USER
insert into app_user_access 
(APP_USER_ACCESS_ID, APP_FEATURE_ID, ACCESS_TYPE, STAFF_TITLE_ID, STAFF_ID, HAS_VIEW, HAS_EDIT, HAS_DELETE)
values 
(app_user_access_seq.nextval, 600, 'U', NULL, 528, 'Y', 'N', 'N')
/
declare
begin utilities.updateAppAccess(500, 'Y', 'N'); end;
/
select * from app_user_access where staff_title_id = 19
/
select * from app_user_access
/
insert into app_user_access (app_user_access_id, app_feature_id, access_type, staff_title_id, staff_id, has_view, has_edit, has_delete) 
values (app_user_access_seq.nextval, 100, 'G', 14, NULL, 'Y', 'Y', 'N')
/
select * from app_user_access order by app_user_access_id desc
/
insert into app_user_access (app_user_access_id, app_feature_id, access_type, staff_title_id, staff_id, has_view, has_edit, has_delete) 
values (app_user_access_seq.nextval, 100, 'G', 61, NULL, 'Y', 'Y', 'N')

CREATE OR REPLACE 
PACKAGE app_feature
  IS

    PROCEDURE UPSERT_VIEW_ALL(
    featID apex_app_feature.apex_app_feature_id%type,
    cUSER apex_app_user_access.create_user%type
    );

END;
/
CREATE TABLE app_feature
    (app_feature_id            NUMBER(5,0) NOT NULL,
    feature_name                   VARCHAR2(400) NOT NULL,
    feature_notes                  VARCHAR2(400))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  data
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/

ALTER TABLE app_feature
ADD CONSTRAINT pk_app_feature PRIMARY KEY (app_feature_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/
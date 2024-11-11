CREATE TABLE app_user_access
    (app_user_access_id        NUMBER(10,0) NOT NULL,
    app_feature_id            NUMBER(5,0) NOT NULL,
    access_type                    VARCHAR2(1) NOT NULL,
    staff_title_id                 NUMBER(10,0),
    staff_id                       NUMBER(10,0),
    has_view                       VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    has_edit                       VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    has_delete                     VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    create_date                    DATE DEFAULT sysdate NOT NULL,
    create_user                    VARCHAR2(20) DEFAULT user NOT NULL,
    modify_date                    DATE,
    modify_user                    VARCHAR2(20))
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

CREATE INDEX ix_app_access_title ON app_user_access
  (
    staff_title_id                  ASC
  )
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

CREATE INDEX ix_app_access_user ON app_user_access
  (
    staff_id                        ASC
  )
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

ALTER TABLE app_user_access
ADD CONSTRAINT ck_app_user_sec_delete CHECK (has_delete in ('Y','N'))
/

ALTER TABLE app_user_access
ADD CONSTRAINT ck_app_user_sec_edit CHECK (has_delete in ('Y','N'))
/

ALTER TABLE app_user_access
ADD CONSTRAINT ck_app_user_sec_view CHECK (has_view in ('Y','N'))
/

ALTER TABLE app_user_access
ADD CONSTRAINT ck_app_user_sec_type CHECK (access_type in ('G', 'U', 'A'))
/



ALTER TABLE app_user_access
ADD CONSTRAINT uc_app_group UNIQUE (app_feature_id, access_type, 
  staff_title_id, staff_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  data
  STORAGE   (
    INITIAL     65536
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

ALTER TABLE app_user_access
ADD CONSTRAINT pk_app_user_access PRIMARY KEY (app_user_access_id)
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

ALTER TABLE app_user_access
ADD CONSTRAINT fk_app_access_user FOREIGN KEY (staff_id)
REFERENCES staff (staff_id)
/
ALTER TABLE app_user_access
ADD CONSTRAINT fk_app_access_title FOREIGN KEY (staff_title_id)
REFERENCES staff_title (staff_title_id)
/
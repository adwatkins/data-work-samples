CREATE TABLE contract
    (contract_id                    NUMBER(10,0) NOT NULL,
    contract_gid                   NUMBER(10,0) NOT NULL,
    finance_gid                    NUMBER(10,0) NOT NULL,
    contract_name                  VARCHAR2(250) NOT NULL,
    parent_company_id              NUMBER(10,0),
    specialty_id                   NUMBER(10,0) NOT NULL,
    avg_arr                        NUMBER(10,2),
    contract_status                         VARCHAR2(1),
    golive_date                DATE,
    runout_date                DATE,
    reported_term_date             DATE,
    first_invoice_date             DATE,
    last_invoice_date              DATE,
    billing_city                   VARCHAR2(50),
    billing_state                  VARCHAR2(2),
    billing_zip                    VARCHAR2(5),
    shipping_city                  VARCHAR2(50),
    shipping_state                 VARCHAR2(2),
    shipping_zip                   VARCHAR2(5),
    notes                          VARCHAR2(2000),
    create_date                    DATE,
    create_user                    NUMBER(10,0),
    modify_date                    DATE,
    modify_user                    NUMBER(10,0),
    is_reference                   VARCHAR2(1) DEFAULT 'N',
    is_escalated                   VARCHAR2(1) DEFAULT 'N',
    nps_score                      NUMBER(2,0),
    contact_name                   VARCHAR2(100),
    contact_title_role             VARCHAR2(100),
    contact_email                  VARCHAR2(100),
    survey_grp                     NUMBER(1,0))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  data
  STORAGE   (
    INITIAL     131072
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Indexes for CONTRACT

CREATE INDEX ix_contract_muser ON contract
  (
    modify_user                     ASC
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

CREATE INDEX ix_contract_cuser ON contract
  (
    create_user                     ASC
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

CREATE INDEX ix_contract_parent_co ON contract
  (
    parent_company_id               ASC
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

CREATE INDEX ix_contract_specialty ON contract
  (
    specialty_id                    ASC
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



-- Constraints for CONTRACT

ALTER TABLE contract
ADD CONSTRAINT ck_reference CHECK (is_reference in ('Y','N'))
/

ALTER TABLE contract
ADD CONSTRAINT ck_contract_status CHECK (contract_status in ('A','I','W','P'))
/

ALTER TABLE contract
ADD CONSTRAINT uc_contract_fin_gid UNIQUE (finance_gid)
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

ALTER TABLE contract
ADD CONSTRAINT uc_contract_gid UNIQUE (contract_gid)
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

ALTER TABLE contract
ADD CONSTRAINT pk_contract PRIMARY KEY (contract_id)
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

ALTER TABLE contract
ADD CONSTRAINT ck_contract_nps CHECK (nps_score >= 0 AND nps_score <=10
)
/



ALTER TABLE contract
ADD CONSTRAINT ck_contract_escalated CHECK (is_escalated in ('Y','N'))
/




-- Triggers for CONTRACT

CREATE OR REPLACE TRIGGER contract_bu
 BEFORE
  UPDATE
 ON contract
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
begin
     :new.modify_date := sysdate;
    
    insert into hist_contract
    (
        hist_contract_id,
        hist_date,
        contract_id,
        contract_gid,
        finance_gid,
        contract_name,
        parent_company_id,
        specialty_id,
        avg_arr,
        contract_status,
        grs_golive_date,
        grs_runout_date,
        reported_term_date,
        first_invoice_date,
        last_invoice_date,
        billing_city,
        billing_state,
        billing_zip,
        shipping_city,
        shipping_state,
        shipping_zip,
        notes,
        is_reference,
        create_date,
        create_user,
        modify_date,
        modify_user
    )
    values
    ( 
        hist_contract_seq.nextval,
        sysdate,
        :old.contract_id,
        :old.contract_gid,
        :old.finance_gid,
        :old.contract_name,
        :old.parent_company_id,
        :old.specialty_id,
        :old.avg_arr,
        :old.contract_status,
        :old.grs_golive_date,
        :old.grs_runout_date,
        :old.reported_term_date,
        :old.first_invoice_date,
        :old.last_invoice_date,
        :old.billing_city,
        :old.billing_state,
        :old.billing_zip,
        :old.shipping_city,
        :old.shipping_state,
        :old.shipping_zip,
        :old.notes,
        :old.is_reference,
        :old.create_date,
        :old.create_user,
        :old.modify_date,
        :old.modify_user
    );
end;
/

ALTER TABLE contract
ADD CONSTRAINT fk_contract_muser FOREIGN KEY (modify_user)
REFERENCES staff (staff_id)
/
ALTER TABLE contract
ADD CONSTRAINT fk_contract_cuser FOREIGN KEY (create_user)
REFERENCES staff (staff_id)
/
ALTER TABLE contract
ADD CONSTRAINT fk_contract_specialty FOREIGN KEY (specialty_id)
REFERENCES specialty (specialty_id)
/
ALTER TABLE contract
ADD CONSTRAINT fk_contract_parent_co FOREIGN KEY (parent_company_id)
REFERENCES parent_company (parent_company_id)
/
CREATE TABLE client
    (client_id                     NUMBER(*,0) NOT NULL,
    client_name                    VARCHAR2(200) NOT NULL,
    platform_id                    VARCHAR2(1) NOT NULL,
    platform_client_id             VARCHAR2(15),
    salesforce_client_id           NUMBER(10,0),
    parent_company_id              NUMBER(*,0),
    specialty_id                   NUMBER(*,0) NOT NULL,
    billing_city                   VARCHAR2(50),
    billing_state                  VARCHAR2(2),
    billing_zip5                   VARCHAR2(5),
    shipping_city                  VARCHAR2(50),
    shipping_state                 VARCHAR2(2),
    shipping_zip5                  VARCHAR2(5),
    client_status_id               VARCHAR2(1),
    create_date                    DATE DEFAULT sysdate,
    update_date                    DATE DEFAULT sysdate,
    update_source_id               NUMBER(*,0),
    greenway_golive_date           DATE,
    rcm_golive_date                DATE,
    invoice_first_date             DATE,
    invoice_last_date              DATE,
    rcm_runout_date                DATE,
    reported_term_date             DATE,
    greenway_term_date             DATE,
    avg_arr                        NUMBER(10,2),
    is_billable                    VARCHAR2(1),
    is_actual                      VARCHAR2(1),
    notes                          VARCHAR2(4000),
    alias_id                       NUMBER(3,0),
    finance_gid                    NUMBER(10,0),
    contract_id                    NUMBER(10,0),
    is_escalated                   VARCHAR2(1) DEFAULT NULL,
    director                       NUMBER(10,0),
    crm                            NUMBER(10,0),
    client_lead                    NUMBER(10,0),
    create_user                    NUMBER(10,0),
    modify_user                    NUMBER(10,0),
    gpx_mig_date                   DATE,
    term_notes                     VARCHAR2(4000))
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





-- Indexes for CLIENT

CREATE INDEX ix_client_cuser ON client
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

CREATE INDEX ix_client_platform ON client
  (
    platform_id                     ASC
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

CREATE INDEX ix_client_parent ON client
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

CREATE INDEX ix_client_status ON client
  (
    client_status_id                ASC
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

CREATE INDEX ix_client_data_source ON client
  (
    update_source_id                ASC
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

CREATE INDEX ix_client_specialty ON client
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

CREATE INDEX ix_client_contract ON client
  (
    contract_id                     ASC
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

CREATE INDEX ix_client_muser ON client
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



-- Constraints for CLIENT



ALTER TABLE client
ADD CONSTRAINT ck_is_actual CHECK (is_actual in ('Y', 'N'))
/

ALTER TABLE client
ADD CONSTRAINT ck_is_billable CHECK (is_billable in ('Y', 'N'))
/

ALTER TABLE client
ADD CONSTRAINT uc_sf_client_id UNIQUE (salesforce_client_id)
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

ALTER TABLE client
ADD CONSTRAINT pk_client PRIMARY KEY (client_id)
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




ALTER TABLE client
ADD CONSTRAINT ck_client_escalated CHECK (is_escalated in ('1', '2', '3', null))
/








-- Triggers for CLIENT

CREATE OR REPLACE TRIGGER client_bu
 BEFORE
  UPDATE
 ON client
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
begin
    insert into client_history
    (
    client_history_id,
    history_date,
    client_id,
    client_name,
    platform_id,
    platform_client_id,
    salesforce_client_id,
    parent_company_id,
    specialty_id,
    billing_city,
    billing_state,
    billing_zip5,
    shipping_city,
    shipping_state,
    shipping_zip5,
    client_status_id,
    create_date,
    update_date,
    update_source_id,
    greenway_golive_date,
    rcm_golive_date,
    invoice_first_date,
    invoice_last_date,
    rcm_runout_date,
    reported_term_date,
    greenway_term_date,
    avg_arr,
    is_billable,
    is_actual,
    notes,
    alias_id,
    finance_gid,
    contract_id,
    is_escalated,
    director,
    crm,
    client_lead,
    create_user,
    modify_user,
    gpx_mig_date,
    term_notes
    )
    values
    (
    client_history_seq.NEXTVAL,
    sysdate,
    :old.client_id,
    :old.client_name,
    :old.platform_id,
    :old.platform_client_id,
    :old.salesforce_client_id,
    :old.parent_company_id,
    :old.specialty_id,
    :old.billing_city,
    :old.billing_state,
    :old.billing_zip5,
    :old.shipping_city,
    :old.shipping_state,
    :old.shipping_zip5,
    :old.client_status_id,
    :old.create_date,
    :old.update_date,
    :old.update_source_id,
    :old.greenway_golive_date,
    :old.rcm_golive_date,
    :old.invoice_first_date,
    :old.invoice_last_date,
    :old.rcm_runout_date,
    :old.reported_term_date,
    :old.greenway_term_date,
    :old.avg_arr,
    :old.is_billable,
    :old.is_actual,
    :old.notes,
    :old.alias_id,
    :old.finance_gid,
    :old.contract_id,
    :old.is_escalated,
    :old.director,
    :old.crm,
    :old.client_lead,
    :old.create_user,
    :old.modify_user,
    :old.gpx_mig_date,
    :old.term_notes
    );
end;
/


-- Comments for CLIENT

COMMENT ON TABLE client IS 'List of RCM clients'
/
COMMENT ON COLUMN client.billing_city IS 'Billing city for the client'
/
COMMENT ON COLUMN client.billing_state IS 'Billing State abbreviation for the client'
/
COMMENT ON COLUMN client.billing_zip5 IS 'First 5 digits of the client''s billing zip code'
/
COMMENT ON COLUMN client.client_id IS 'Primary key.  Internal numeric identifier.'
/
COMMENT ON COLUMN client.client_name IS 'Name of the RCM client'
/
COMMENT ON COLUMN client.client_status_id IS 'Status indicator for the client.  FK to client_status'
/
COMMENT ON COLUMN client.create_date IS 'Date the client record was initially creatd in the data mart'
/
COMMENT ON COLUMN client.gpx_mig_date IS 'GPx Migration Date'
/
COMMENT ON COLUMN client.greenway_golive_date IS 'Date the client went live on a Greenway platform (not RCM specific)'
/
COMMENT ON COLUMN client.greenway_term_date IS 'Final date client was a Greenway customer'
/
COMMENT ON COLUMN client.invoice_first_date IS 'Date of first RCM specific invoice'
/
COMMENT ON COLUMN client.invoice_last_date IS 'Date of last RCM specific invoice.  Finance term date.'
/
COMMENT ON COLUMN client.is_actual IS 'Y = actual client that is worked / N = Billable parent client only.'
/
COMMENT ON COLUMN client.is_billable IS 'Y = billable client / N = non-billable client.  Should have a billable parent.'
/
COMMENT ON COLUMN client.is_escalated IS '1 = New 2 = Existing 3 = Escalated'
/
COMMENT ON COLUMN client.parent_company_id IS 'Identifies parent billing company for the client.  FK to parent_company.'
/
COMMENT ON COLUMN client.platform_client_id IS 'Platform specific identifier for the client (AL0551, 861, etc.)'
/
COMMENT ON COLUMN client.platform_id IS 'RCM platform the client is using'
/
COMMENT ON COLUMN client.rcm_golive_date IS 'Date the client began receiving RCM services'
/
COMMENT ON COLUMN client.rcm_runout_date IS 'Final date work done by RCM for client.'
/
COMMENT ON COLUMN client.reported_term_date IS 'Term date reported to the Board'
/
COMMENT ON COLUMN client.salesforce_client_id IS '10-digit Salesforce identifier for the client'
/
COMMENT ON COLUMN client.shipping_city IS 'Shipping city for the client'
/
COMMENT ON COLUMN client.shipping_state IS 'Shipping State abbreviation for the client'
/
COMMENT ON COLUMN client.shipping_zip5 IS 'First 5 digits of the client''s shipping zip code'
/
COMMENT ON COLUMN client.specialty_id IS 'Identifies the specialty associated with the client.  FK to specialty'
/
COMMENT ON COLUMN client.update_date IS 'Date the client record was last updated in the data mart'
/
COMMENT ON COLUMN client.update_source_id IS 'Indicates the source last used to update the client information.  FK to data_source.'
/

-- End of DDL Script for Table AO.CLIENT

-- Foreign Key
ALTER TABLE client
ADD CONSTRAINT fk_client_muser FOREIGN KEY (modify_user)
REFERENCES staff (staff_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_cuser FOREIGN KEY (create_user)
REFERENCES staff (staff_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_clientlead FOREIGN KEY (client_lead)
REFERENCES staff (staff_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_crm FOREIGN KEY (crm)
REFERENCES staff (staff_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_director FOREIGN KEY (director)
REFERENCES staff (staff_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_specialty FOREIGN KEY (specialty_id)
REFERENCES specialty (specialty_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_data_source FOREIGN KEY (update_source_id)
REFERENCES data_source (data_source_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_status FOREIGN KEY (client_status_id)
REFERENCES client_status (client_status_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_parent_company FOREIGN KEY (parent_company_id)
REFERENCES parent_company (parent_company_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_platform FOREIGN KEY (platform_id)
REFERENCES platform (platform_id)
/
ALTER TABLE client
ADD CONSTRAINT fk_client_contract FOREIGN KEY (contract_id)
REFERENCES contract (contract_id)
/
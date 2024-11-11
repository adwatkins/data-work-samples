CREATE TABLE hist_contract
    (hist_contract_id               NUMBER(10,0) NOT NULL,
    hist_date                      DATE NOT NULL,
    contract_id                    NUMBER(10,0) NOT NULL,
    contract_gid                   NUMBER(10,0) NOT NULL,
    finance_gid                    NUMBER(10,0) NOT NULL,
    contract_name                  VARCHAR2(250) NOT NULL,
    parent_company_id              NUMBER(10,0),
    specialty_id                   NUMBER(10,0) NOT NULL,
    avg_arr                        NUMBER(10,2),
    status                         VARCHAR2(1),
    grs_golive_date                DATE,
    grs_runout_date                DATE,
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
    create_user                    VARCHAR2(20),
    modify_date                    DATE,
    modify_user                    VARCHAR2(20),
    is_reference                   VARCHAR2(1))
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

CREATE INDEX ix_hist_contract_contract ON hist_contract
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

ALTER TABLE hist_contract
ADD CONSTRAINT pk_hist_contract PRIMARY KEY (hist_contract_id)
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

COMMENT ON TABLE hist_contract IS 'Contains contracted customers who may have one parent company and one or more clients (database).'
/
COMMENT ON COLUMN hist_contract.avg_arr IS 'Average annual recurring revenue, calculated over last 6 months (when availabe) from invoices.'
/
COMMENT ON COLUMN hist_contract.billing_city IS 'Billing city listed in Salesforce for contract customer.'
/
COMMENT ON COLUMN hist_contract.billing_state IS 'Billing state listed in Salesforce for contract customer.'
/
COMMENT ON COLUMN hist_contract.billing_zip IS 'Billing zip code listed in Salesforce for contract customer.'
/
COMMENT ON COLUMN hist_contract.contract_gid IS 'Salesforce GID for the client.  In most cases should match the finance_gid.'
/
COMMENT ON COLUMN hist_contract.contract_id IS 'ID of contract record that was changed.  Foreign key to contract table.'
/
COMMENT ON COLUMN hist_contract.contract_name IS 'Customer name from Salesforce'
/
COMMENT ON COLUMN hist_contract.finance_gid IS 'GID reported by Finance as billable GID.  In most cases should match the contract_gid.'
/
COMMENT ON COLUMN hist_contract.first_invoice_date IS 'Date of first invoice to contract customer.'
/
COMMENT ON COLUMN hist_contract.grs_golive_date IS 'Date GRS started services on any client database for contract customer.'
/
COMMENT ON COLUMN hist_contract.grs_runout_date IS 'Date GRS finishes work on all client databases for contract customer.'
/
COMMENT ON COLUMN hist_contract.hist_contract_id IS 'Primary key.  Internal number generated via sequence.'
/
COMMENT ON COLUMN hist_contract.hist_date IS 'Date history record was created.  Can be used as end date range for when data in this record was valid.'
/
COMMENT ON COLUMN hist_contract.last_invoice_date IS 'Date of last invoice to contract customer.'
/
COMMENT ON COLUMN hist_contract.notes IS 'Additional notes regarding the contract customer'
/
COMMENT ON COLUMN hist_contract.parent_company_id IS 'Identifies parent company for the customer contract.  Foreign key to parent_company table.'
/
COMMENT ON COLUMN hist_contract.reported_term_date IS 'Termination date first reported to the Board.'
/
COMMENT ON COLUMN hist_contract.shipping_city IS 'Shipping city listed in Salesforce for contract customer.'
/
COMMENT ON COLUMN hist_contract.shipping_state IS 'Shipping state listed in Salesforce for contract customer.'
/
COMMENT ON COLUMN hist_contract.shipping_zip IS 'Shipping zip code listed in Salesforce for contract customer.'
/
COMMENT ON COLUMN hist_contract.specialty_id IS 'Primary specialty associated with the customer contract.  Foreign key to specialty table.'
/
COMMENT ON COLUMN hist_contract.status IS 'Contract status: P=Pre-Go-live (in implementation) / A=Active / W=Workdown / I=Inactive '
/

ALTER TABLE hist_contract
ADD CONSTRAINT fk_hist_contract_contract FOREIGN KEY (contract_id)
REFERENCES contract (contract_id)
/
CREATE TABLE contract_metrics
    (contract_metrics_id            NUMBER(10,0) NOT NULL,
    contract_id                    NUMBER(10,0) NOT NULL,
    date_key                       VARCHAR2(6) NOT NULL,
    invoice_pcnt_charged           NUMBER(6,2),
    invoice_min_fee                NUMBER(10,2),
    invoice_collections            NUMBER(10,2),
    invoice_charges                NUMBER(10,2),
    invoice_amt                    NUMBER(10,2),
    providers_full_time            NUMBER(4,0),
    providers_part_time            NUMBER(4,0),
    visits_ins                     NUMBER(10,0),
    visits_priv                    NUMBER(10,0),
    claims_clean                   NUMBER(10,0),
    claims_unclean                 NUMBER(10,0),
    kpi_clean_claim_pcnt           NUMBER(6,2),
    kpi_days_ar                    NUMBER(5,2),
    kpi_aging_0to60                NUMBER(6,2),
    aging_30_amt                   NUMBER(10,2),
    aging_60_amt                   NUMBER(10,2),
    aging_90_amt                   NUMBER(10,2),
    aging_120_amt                  NUMBER(10,2),
    aging_121plus_amt              NUMBER(10,2),
    charges                        NUMBER(10,2),
    outstanding_ar                 NUMBER(10,2),
    is_workdown                    VARCHAR2(1),
    notes                          VARCHAR2(2000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  data
  STORAGE   (
    INITIAL     327680
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/

CREATE INDEX ix_contract_metrics_contract ON contract_metrics
  (
    contract_id                     ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     196608
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX ix_contract_datekey ON contract_metrics
  (
    date_key                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     196608
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE INDEX ix_contract_contract_datekey ON contract_metrics
  (
    contract_id                     ASC,
    date_key                        ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     196608
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

ALTER TABLE contract_metrics
ADD CONSTRAINT ck_contract_metrics_is_wkdwn CHECK (is_workdown in (null, 'Y'))
/

ALTER TABLE contract_metrics
ADD CONSTRAINT pk_contract_metrics PRIMARY KEY (contract_metrics_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     131072
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

CREATE OR REPLACE TRIGGER contract_metrics_bu
 BEFORE
  UPDATE
 ON contract_metrics
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
begin
    insert into hist_contract_metrics
    (
        hist_contract_metrics_id,
        hist_date,
        contract_metrics_id,
        contract_id,
        date_key,
        invoice_pcnt_charged,
        invoice_min_fee,
        invoice_collections,
        invoice_charges,
        invoice_amt,
        providers_full_time,
        providers_part_time,
        visits_ins,
        visits_priv,
        claims_clean,
        claims_unclean,
        kpi_clean_claim_pcnt,
        kpi_days_ar,
        kpi_aging_0to60,
        aging_30_amt,
        aging_60_amt,
        aging_90_amt,
        aging_120_amt,
        aging_121plus_amt,
        charges,
        outstanding_ar,
        is_workdown,
        notes
    )
    values
    ( 
        hist_contract_metrics_seq.nextval,
        sysdate,
        :old.contract_metrics_id,
        :old.contract_id,
        :old.date_key,
        :old.invoice_pcnt_charged,
        :old.invoice_min_fee,
        :old.invoice_collections,
        :old.invoice_charges,
        :old.invoice_amt,
        :old.providers_full_time,
        :old.providers_part_time,
        :old.visits_ins,
        :old.visits_priv,
        :old.claims_clean,
        :old.claims_unclean,
        :old.kpi_clean_claim_pcnt,
        :old.kpi_days_ar,
        :old.kpi_aging_0to60,
        :old.aging_30_amt,
        :old.aging_60_amt,
        :old.aging_90_amt,
        :old.aging_120_amt,
        :old.aging_121plus_amt,
        :old.charges,
        :old.outstanding_ar,
        :old.is_workdown,
        :old.notes
    );
end;
/

ALTER TABLE contract_metrics
ADD CONSTRAINT fk_contract_metrics_contract FOREIGN KEY (contract_id)
REFERENCES contract (contract_id)
/
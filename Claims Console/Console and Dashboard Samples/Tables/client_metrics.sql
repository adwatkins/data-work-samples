CREATE TABLE client_metrics
    (client_metrics_id              NUMBER(10,0) NOT NULL,
    client_id                      NUMBER(10,0) NOT NULL,
    date_key                       VARCHAR2(6) NOT NULL,
    total_visits                   NUMBER(10,0),
    ins_visits                     NUMBER(10,0),
    priv_visits                    NUMBER(10,0),
    total_claims                   NUMBER(10,0),
    clean_claims                   NUMBER(10,0),
    unclean_claims                 NUMBER(10,0),
    days_ar                        NUMBER(10,2),
    providers_billed               NUMBER(4,0),
    providers_ft                   NUMBER(4,0),
    providers_pt                   NUMBER(4,0),
    amt_resp_pat                   NUMBER(10,2),
    amt_resp_coll                  NUMBER(10,2),
    amt_resp_ins                   NUMBER(10,2),
    amt_resp_other                 NUMBER(10,2),
    days_ar_mgma_pcnt              NUMBER(5,2),
    clean_claim_pcnt               NUMBER(10,2),
    aging_0to60_pcnt               NUMBER(10,2),
    aging_0to30                    NUMBER(10,2),
    aging_31to60                   NUMBER(10,2),
    aging_61to90                   NUMBER(10,2),
    aging_91to120                  NUMBER(10,2),
    aging_121plus                  NUMBER(10,2),
    aging_total                    NUMBER(10,2),
    outstanding_ar                 NUMBER(10,2),
    charges_90days                 NUMBER(10,2),
    kpi_score_clean_claims         NUMBER(10,2),
    kpi_score_aging_0to60          NUMBER(10,2),
    kpi_score_days_ar              NUMBER(10,2),
    kpi_score_total                NUMBER(10,2),
    medal                          VARCHAR2(1),
    is_workdown                    VARCHAR2(1) DEFAULT 'N',
    crm                            VARCHAR2(100),
    client_lead                    VARCHAR2(100),
    director                       VARCHAR2(100),
    undetermined_claims            NUMBER(10,0),
    vp_no_connection               VARCHAR2(1),
    vp_verified_0_cnt              VARCHAR2(1),
    vp_notes                       VARCHAR2(4000),
    last_month_used                VARCHAR2(1))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  TABLESPACE  data
  STORAGE   (
    INITIAL     2097152
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
  NOCACHE
  MONITORING
/





-- Indexes for CLIENT_METRICS

CREATE INDEX ix_client_metrics_client ON client_metrics
  (
    client_id                       ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     393216
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Constraints for CLIENT_METRICS

ALTER TABLE client_metrics
ADD CONSTRAINT ck_workdown CHECK (is_workdown in ('Y', 'N'))
/

ALTER TABLE client_metrics
ADD CONSTRAINT ck_medal CHECK (medal in ('G','S','B','W','O'))
/

ALTER TABLE client_metrics
ADD CONSTRAINT pk_client_metrics PRIMARY KEY (client_metrics_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     262144
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

ALTER TABLE client_metrics
ADD CONSTRAINT ck_vp_verified_0_cnt CHECK (VP_VERIFIED_0_CNT in ('Y', 'N')
)
/

ALTER TABLE client_metrics
ADD CONSTRAINT ck_vp_no_connection CHECK (VP_NO_CONNECTION in ('Y', 'N')
)
/



-- Triggers for CLIENT_METRICS

CREATE OR REPLACE TRIGGER client_metrics_bu
 BEFORE
  UPDATE
 ON client_metrics
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
declare
begin
    
    insert into hist_client_metrics
    (
        hist_client_metrics_id,
        hist_date, 
        client_metrics_id,
        client_id,
        date_key,
        total_visits,
        ins_visits,
        priv_visits,
        total_claims,
        clean_claims,
        unclean_claims,
        days_ar,
        providers_billed,
        providers_ft,
        providers_pt,
        amt_resp_pat,
        amt_resp_coll,
        amt_resp_ins,
        amt_resp_other,
        days_ar_mgma_pcnt,
        clean_claim_pcnt,
        aging_0to60_pcnt,
        aging_0to30,
        aging_31to60,
        aging_61to90,
        aging_91to120,
        aging_121plus,
        aging_total,
        outstanding_ar,
        charges_90days,
        kpi_score_clean_claims,
        kpi_score_aging_0to60,
        kpi_score_days_ar,
        kpi_score_total,
        medal,
        is_workdown,
        crm,
        client_lead,
        director,
        undetermined_claims,
        vp_no_connection,
        vp_verified_0_cnt,
        vp_notes
    )
    values
    ( 
        hist_client_metrics_seq.nextval,
        sysdate,
        :old.client_metrics_id,
        :old.client_id,
        :old.date_key,
        :old.total_visits,
        :old.ins_visits,
        :old.priv_visits,
        :old.total_claims,
        :old.clean_claims,
        :old.unclean_claims,
        :old.days_ar,
        :old.providers_billed,
        :old.providers_ft,
        :old.providers_pt,
        :old.amt_resp_pat,
        :old.amt_resp_coll,
        :old.amt_resp_ins,
        :old.amt_resp_other,
        :old.days_ar_mgma_pcnt,
        :old.clean_claim_pcnt,
        :old.aging_0to60_pcnt,
        :old.aging_0to30,
        :old.aging_31to60,
        :old.aging_61to90,
        :old.aging_91to120,
        :old.aging_121plus,
        :old.aging_total,
        :old.outstanding_ar,
        :old.charges_90days,
        :old.kpi_score_clean_claims,
        :old.kpi_score_aging_0to60,
        :old.kpi_score_days_ar,
        :old.kpi_score_total,
        :old.medal,
        :old.is_workdown,
        :old.crm,
        :old.client_lead,
        :old.director,
        :old.undetermined_claims,
        :old.vp_no_connection,
        :old.vp_verified_0_cnt,
        :old.vp_notes
    );
end;
/

COMMENT ON COLUMN client_metrics.amt_resp_coll IS 'Dollar amount of patient collections responsiblity for the month, based on DOS'
/
COMMENT ON COLUMN client_metrics.amt_resp_ins IS 'Dollar amount of insurance responsiblity for the month, based on DOS'
/
COMMENT ON COLUMN client_metrics.amt_resp_other IS 'Dollar amount of "other" responsiblity for the month, based on DOS.  Not often used and typically counted with insurance responsibility.'
/
COMMENT ON COLUMN client_metrics.amt_resp_pat IS 'Dollar amount of patient responsiblity for the month, based on DOS'
/
COMMENT ON COLUMN client_metrics.days_ar_mgma_pcnt IS 'Reflects percentage of MGMA.  Closer to 0 the better!'
/

ALTER TABLE client_metrics
ADD CONSTRAINT fk_client_metrics_client FOREIGN KEY (client_id)
REFERENCES client (client_id)
/
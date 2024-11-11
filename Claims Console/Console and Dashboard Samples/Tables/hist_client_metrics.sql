CREATE TABLE hist_client_metrics
    (hist_client_metrics_id         NUMBER(10,0) NOT NULL,
    hist_date                      DATE NOT NULL,
    client_metrics_id              NUMBER(10,0) NOT NULL,
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
    is_workdown                    VARCHAR2(1),
    crm                            VARCHAR2(100),
    client_lead                    VARCHAR2(100),
    director                       VARCHAR2(100),
    undetermined_claims            NUMBER(10,0),
    vp_no_connection               VARCHAR2(1),
    vp_verified_0_cnt              VARCHAR2(1),
    vp_notes                       VARCHAR2(4000))
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

CREATE INDEX ix_hist_client_metrics_id ON hist_client_metrics
  (
    client_metrics_id               ASC
  )
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     917504
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/



-- Constraints for HIST_CLIENT_METRICS

ALTER TABLE hist_client_metrics
ADD CONSTRAINT pk_hist_client_metrics PRIMARY KEY (hist_client_metrics_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
  TABLESPACE  indx
  STORAGE   (
    INITIAL     524288
    NEXT        1048576
    MINEXTENTS  1
    MAXEXTENTS  2147483645
  )
/

ALTER TABLE hist_client_metrics
ADD CONSTRAINT fk_hist_client_metrics_id FOREIGN KEY (client_metrics_id)
REFERENCES client_metrics (client_metrics_id)
/
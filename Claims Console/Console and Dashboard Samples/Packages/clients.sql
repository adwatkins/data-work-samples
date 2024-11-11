CREATE OR REPLACE 
PACKAGE clients
is

    procedure ImportClients_SF_Stage;
    
    procedure Update_MGMA_Days_AR(sDateKey client_metrics.date_key%type);
    
    procedure CreateMetricsForPreviousMonth;
    
    procedure AddContract(
    GID contract.contract_gid%type,
    FGID contract.finance_gid%type,
    CNAME contract.contract_name%type,
    ParentID contract.parent_company_id%type,
    SPEC contract.specialty_id%type,
    bcity contract.billing_city%type,
    bstate contract.billing_state%type,
    bzip contract.billing_zip%type,
    scity contract.shipping_city%type,
    sstate contract.shipping_state%type,
    szip contract.shipping_zip%type,
    GLDATE contract.grs_golive_date%type,
    is_ref contract.is_reference%type,
    escal contract.is_escalated%type,
    nts contract.notes%type,
    cont_out out contract.contract_id%type,
    billship number,
    finSame number,
    nCreateUser in client.create_user%type,
    sIsSuccessful out varchar2,
    sMsg out varchar2
    );

    procedure ContractStageMove(
    GID stage_client_sf.salesforce_client_id%type
    );
    
    procedure ContractToClient(
    GID client.salesforce_client_id%type
    );
    
    procedure AddFromApex(
        CGID contract.contract_gid%type,
        FGID contract.finance_gid%type,
        pcid client.platform_client_id%type,
        cname contract.contract_name%type,
        plat client.platform_id%type,
        specid specialty.specialty_id%type,
        gldate contract.grs_golive_date%type,
        bc contract.billing_city%type,
        bs contract.billing_state%type,
        bz contract.billing_zip%type,
        sc contract.shipping_city%type,
        ss contract.shipping_state%type,
        sz contract.shipping_zip%type,
        notes contract.notes%type,
        dir client.director%type,
        crman client.crm%type,
        clead client.client_lead%type,
        billship number,
        sMsg OUT varchar2
    );
    
    procedure AddClientToContract(
        cont_id contract.contract_id%type,
        CGID contract.contract_gid%type,
        FGID contract.finance_gid%type,
        pcid client.platform_client_id%type,
        cname contract.contract_name%type,
        plat client.platform_id%type,
        parent client.parent_company_id%type,
        specid specialty.specialty_id%type,
        gldate contract.grs_golive_date%type,
        gpx_mig client.gpx_mig_date%type,
        bcity contract.billing_city%type,
        bstate contract.billing_state%type,
        bzip contract.billing_zip%type,
        scity contract.shipping_city%type,
        sstate contract.shipping_state%type,
        szip contract.shipping_zip%type,
        notes contract.notes%type,
        dir client.director%type,
        crman client.crm%type,
        clead client.client_lead%type,
        billship number,
        nCreateUser in client.create_user%type,
        sIsSuccessful out varchar2,
        sMsg out varchar2
    );
    
    procedure AddClientsFromSF(nSourceID data_source.data_source_id%type);
    
    procedure AddClientHistory(
        nClient client.client_id%type,
        nDataSource data_source.data_source_id%type);
    
     procedure UpdateExistingClientsFromSF(nSourceID data_source.data_source_id%type);
    
end clients;
/

GRANT EXECUTE ON clients TO rcm
/
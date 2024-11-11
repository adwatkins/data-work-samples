-- Start of DDL Script for Package AO.ALLOCATION
-- Generated 9/28/2017 1:57:05 PM from AO@rcmartd.ehsmed.net

CREATE OR REPLACE 
PACKAGE allocation
  IS

    procedure get_staff(
        nClientID in client.client_id%type,
        nDirector out client.director%type,
        nCrm out client.crm%type,
        nClead out client.client_lead%type
    );
    
    procedure update_staff(
        nClientID in client.client_id%type,
        nDirector in client.director%type,
        nCrm in client.crm%type,
        nClead in client.client_lead%type
    );
    
    procedure get_allocation(
        nStaffID in analyst_allocation.staff_id%type,
        nClientID out analyst_allocation.client_id%type,
        nWork out analyst_allocation.work_pcnt%type,
        sPrim out analyst_allocation.primary_site%type,
        nVis out analyst_allocation.primary_site%type,
        nClientID2 out analyst_allocation.client_id%type,
        nWork2 out analyst_allocation.work_pcnt%type,
        sPrim2 out analyst_allocation.primary_site%type,
        nVis2 out analyst_allocation.primary_site%type,
        nClientID3 out analyst_allocation.client_id%type,
        nWork3 out analyst_allocation.work_pcnt%type,
        sPrim3 out analyst_allocation.primary_site%type,
        nVis3 out analyst_allocation.primary_site%type,        
        nClientID4 out analyst_allocation.client_id%type,
        nWork4 out analyst_allocation.work_pcnt%type,
        sPrim4 out analyst_allocation.primary_site%type,   
        nVis4 out analyst_allocation.primary_site%type,     
        nClientID5 out analyst_allocation.client_id%type,
        nWork5 out analyst_allocation.work_pcnt%type,
        sPrim5 out analyst_allocation.primary_site%type,
        nVis5 out analyst_allocation.primary_site%type,        
        nClientID6 out analyst_allocation.client_id%type,
        nWork6 out analyst_allocation.work_pcnt%type,
        sPrim6 out analyst_allocation.primary_site%type,
        nVis6 out analyst_allocation.primary_site%type
    );

    procedure update_allocation_b(
        nStaffID in analyst_allocation.staff_id%type,
        nClientID in analyst_allocation.client_id%type,
        nWork in analyst_allocation.work_pcnt%type,
        sPrim in analyst_allocation.primary_site%type,
        nClientID2 in analyst_allocation.client_id%type,
        nWork2 in analyst_allocation.work_pcnt%type,
        sPrim2 in analyst_allocation.primary_site%type,
        nClientID3 in analyst_allocation.client_id%type,
        nWork3 in analyst_allocation.work_pcnt%type,
        sPrim3 in analyst_allocation.primary_site%type,        
        nClientID4 in analyst_allocation.client_id%type,
        nWork4 in analyst_allocation.work_pcnt%type,
        sPrim4 in analyst_allocation.primary_site%type,        
        nClientID5 in analyst_allocation.client_id%type,
        nWork5 in analyst_allocation.work_pcnt%type,
        sPrim5 in analyst_allocation.primary_site%type,        
        nClientID6 in analyst_allocation.client_id%type,
        nWork6 in analyst_allocation.work_pcnt%type,
        sPrim6 in analyst_allocation.primary_site%type,
        nCreateUser IN staff.staff_id%type,
        sIsSuccessful out varchar2,
        sMsg out varchar2
    );

    procedure get_max_sites(
        nMaxID in aa_config_max_clients.aa_config_max_clients_id%type,
        sPlatform out platform.platform_id%type,
        nMaxClients out aa_config_max_clients.max_clients%type
    );
    
    procedure update_max_sites(
        nMaxID in aa_config_max_clients.aa_config_max_clients_id%type,
        sPlatform in platform.platform_id%type,
        nMaxClients in aa_config_max_clients.max_clients%type
    );
    
    procedure get_visit_capacity(
        nConfigID in aa_config_capacity.aa_config_capacity_id%type,
        sPlatform out platform.platform_id%type,
        nTenureFrom out aa_config_capacity.tenure_range_from%type,
        nTenureTo out aa_config_capacity.tenure_range_to%type,
        nVisits out aa_config_capacity.visit_capacity%type
    );
    
    procedure update_visit_capacity
    (
        nConfigID in aa_config_capacity.aa_config_capacity_id%type,
        nTenureFrom in aa_config_capacity.tenure_range_from%type,
        nTenureTo in aa_config_capacity.tenure_range_to%type,
        nVisits in aa_config_capacity.visit_capacity%type,
        nCreateUser staff.staff_id%type,
        sIsSuccessful out varchar2,
        sMsg out varchar2
    );
    
    procedure get_client_handicap(
        nConfigID in aa_config_client_handicap.aa_config_client_handicap_id%type,
        sType out aa_config_client_handicap.handicap_type%type,
        nHandicap out aa_config_client_handicap.handicap_pcnt%type
    );
    
    procedure update_client_handicap(
        nConfigID in aa_config_client_handicap.aa_config_client_handicap_id%type,
        sType in aa_config_client_handicap.handicap_type%type,
        nHandicap in aa_config_client_handicap.handicap_pcnt%type
    );
    
    procedure get_special_handicap(
        nConfigID in aa_config_special_handicap.aa_config_special_handicap_id%type,
        sPlatform out platform.platform_id%type,
        nSpecial out aa_config_special_handicap.specialty_id%type,
        nHandicap out aa_config_special_handicap.handicap_pcnt%type
    );
    
    procedure update_special_handicap(
        nConfigID in aa_config_special_handicap.aa_config_special_handicap_id%type,
        nSpecial in aa_config_special_handicap.specialty_id%type,
        nHandicap in aa_config_special_handicap.handicap_pcnt%type
    );

    procedure add_allocation(
        nStaffID in analyst_allocation.staff_id%type,
        nClientID in analyst_allocation.client_id%type,
        nWork in analyst_allocation.work_pcnt%type,
        sPrim in analyst_allocation.primary_site%type,
        nVis in analyst_allocation.visit_pcnt%type,
        nCreateUser IN staff.staff_id%type,
        sIsSuccessful out varchar2,
        sMsg out varchar2
    );
    
    procedure update_allocation(
        nStaffID in analyst_allocation.staff_id%type,
        nClientID in analyst_allocation.client_id%type,
        nWork in analyst_allocation.work_pcnt%type,
        sPrim in analyst_allocation.primary_site%type,
        nVis in analyst_allocation.visit_pcnt%type,
        nCreateUser IN staff.staff_id%type,
        sIsSuccessful out varchar2,
        sMsg out varchar2
    );
    
    procedure remove_site(
        nStaffID staff.staff_id%type,
        nClientID client.client_id%type,
        nCreateUser IN staff.staff_id%type,
        sIsSuccessful out varchar2,
        sMsg out varchar2
    );
    
END;
/

GRANT EXECUTE ON allocation TO rcm
/

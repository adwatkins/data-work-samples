CREATE OR REPLACE 
PACKAGE apex_security
is
    
    procedure LogApexError(
      sProcedure varchar2,
      nErrorCode number,
      sErrMsg varchar2,
      nStaffID number);
      
      
     procedure LogApexError(
      sProcedure varchar2,
      nErrorCode number,
      sErrMsg varchar2,
      sUserID varchar2);
    
    
    procedure GetStaffForUser(
        sUserID in staff.user_id%type,
        nStaffID out staff.staff_id%type,
        sIsSuccessful out varchar2,
        sErrorMsg out varchar2);
        
        
    procedure GetAllAppAccessForStaff(
      nStaffID in staff.staff_id%type,
      sDebug out varchar2,
      sIFUAudits out varchar2,
      sIFUAuditsConfig out varchar2,
      sStaffingMain out varchar2,
      sStaffingAdmin out varchar2,
      sClientMain out varchar2,
      sClientAdmin out varchar2,
      sSurveyContact out varchar2,
      sEraMain out varchar2,
      sEraAdmin out varchar2,
      sClientBPOConfig out varchar2,
      sPPMain out varchar2,
      sPPAdmin out varchar2,
      sPPUser out varchar2,
      sAAMain out varchar2,
      sAAAdmin out varchar2);
      
    procedure GetAllAppAccessForStaff(
      nStaffID in staff.staff_id%type,
      sDebug out varchar2,
      sIFUAudits out varchar2,
      sIFUAuditsConfig out varchar2,
      sStaffingMain out varchar2,
      sStaffingAdmin out varchar2,
      sClientMain out varchar2,
      sClientAdmin out varchar2,
      sSurveyContact out varchar2,
      sEraMain out varchar2,
      sEraAdmin out varchar2,
      sTrendDenial out varchar2,
      sClientBPOConfig out varchar2,
      sPPMain out varchar2,
      sPPAdmin out varchar2,
      sPPUser out varchar2,
      sAAMain out varchar2,
      sAAAdmin out varchar2);
        
end apex_security;
/

GRANT EXECUTE ON apex_security TO rcm
/
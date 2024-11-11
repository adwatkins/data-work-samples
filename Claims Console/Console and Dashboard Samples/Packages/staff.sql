CREATE OR REPLACE 
PACKAGE staff_master
  IS

    PROCEDURE CREUPDATE
    (
      myFNAME IN staff.first_name%type,
      myLNAME IN staff.last_name%type,
      myPNAME IN staff.preferred_name%type,
      fmrNAME IN staff.former_name%type,
      myADPID IN staff.adp_staff_id%type,
      jobTitle IN staff_title.staff_title_desc%type,
      dateHired IN staff.date_hired%type,
      dateTermed IN staff.date_termed%type,
      myCampus IN campus.campus_name%type,
      myPlat IN platform.platform_name%type,
      isTermed IN varchar2,
      termReason IN varchar2,
      myManager IN varchar2,
      createBy IN staff.modify_user%type--,
    );   

    PROCEDURE GET_NAME(
    uID IN staff.staff_id%type,
    fName OUT staff.first_name%type,
    pName OUT staff.preferred_name%type,
    lName OUT staff.last_name%type
    );

    PROCEDURE UPDATE_NAME(
    sID staff.staff_id%type,
    fName staff.first_name%type,
    pName staff.preferred_name%type,
    lName staff.last_name%type
    );

END STAFF_MASTER;
/
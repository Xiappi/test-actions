/************************************************************/
/*                                                          */
/* SCRIPT NAME: 070808GG1/210527ro01                        */
/* MKS #: 8740                                              */
/* JIRA #: AIS-35661                                        */
/* DESCRIPTION:                                             */
/*     Change Data type of                                  */
/*     location.protection_Class                            */
/*                                                          */
/************************************************************/
/* CONNECT "localhost:c:\ais32\data\ins.ib" USER "SYSDBA" PASSWORD "masterkey"; */
SET TERM ^;

/* THIS IS A HOLDER, SO THAT IT DOES NOT ATTEMPT TO RUN THE STANDARD VERSION */

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("210527ro01", "Change Data type of location.protection_Class", "2021-MAY-27")^

SET TERM ;^
COMMIT WORK;

/************************************************************/
/*                                                          */
/* SCRIPT NAME: 201222TN1                                   */
/* MKS #: BCSB-1324                                         */
/* DESCRIPTION:                                             */
/*     update company name                                  */
/*                                                          */
/************************************************************/
/* CONNECT "" USER "" PASSWORD ""; */
SET TERM ^;

update address a
set a.last_name = 'Argus Insurance Company (Europe) Limited'
where a.adtype = 'CO'^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("201222TN1", "update company name", "12/22/2020")^
SET TERM ;^
COMMIT WORK;

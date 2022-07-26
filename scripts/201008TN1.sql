/************************************************************/
/*                                                          */
/* SCRIPT NAME: 201008TN1                                   */
/* MKS #: BCSB-752                                          */
/* DESCRIPTION:                                             */
/*     change city label                                    */
/*                                                          */
/************************************************************/
/* CONNECT "" USER "" PASSWORD ""; */
SET TERM ^;

update location_properties
set city_caption = 'Town/City'^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("201008TN1", "change city label", "10/08/2020")^
SET TERM ;^
COMMIT WORK;

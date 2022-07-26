/************************************************************/
/*                                                          */
/* SCRIPT NAME: 200720TN3                                   */
/* MKS #: BCSB-222                                          */
/* DESCRIPTION:                                             */
/*     add UW right to group                                */
/*                                                          */
/************************************************************/
/* CONNECT "" USER "" PASSWORD ""; */
SET TERM ^;

update ref_group_master rm
set rm.user_right = 'UW'
where rm.group_code = 'UWONLY'^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("200720TN3", "add UW right to group", "07/20/2020")^
SET TERM ;^
COMMIT WORK;

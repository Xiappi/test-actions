/************************************************************/
/*                                                          */
/* SCRIPT NAME: 210126al01                                  */
/* MKS #:  BCSB-1484                                          */
/* DESCRIPTION:                                             */
/*     Add text base mtc request                       */
/*                                                          */
/************************************************************/
/* CONNECT "" USER "" PASSWORD ""; */
SET TERM ^;

INSERT INTO TASK_ACTIVITY (ACTIVITY_ID, TASK_TITLE, DEFAULT_NUMBER_OF_DAYS_DUE, TASK_MESSAGE,
     ACTIVITY_NAME, WEB_LINK, NOTIFY_AGENT, NOTIFY_CREATOR, CATEGORY_NAME)
VALUES (gen_id(gen_activity_id,1), 'Policy Change Request', 5, 'A Policy Change Request form has been submitted that needs your attention.',
     'TEXTMTC', '/Policy/MidTermChange?pno={PNO}&amp;seq={SEQ}', 1, 1, 'TASKMTC')^

COMMIT^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("210126al01", "BSCB-1484 add text based mtc request", "2021-JAN-26")^

SET TERM ;^

COMMIT WORK;


/************************************************************/
/*                                                          */
/* SCRIPT NAME: 200113TN1                                   */
/* MKS #: AIS-31856                                         */
/* DESCRIPTION:                                             */
/*     add bill_method  to adhoc                            */
/*                                                          */
/************************************************************/
/* CONNECT "" USER "" PASSWORD ""; */
SET TERM ^;

update adhoc_sql
set sql_statement = 'select
     Policy_Id, Policy_No, Batch_No, Geniuspolicynumber, P_State, Statedesc, P_Line, Linedesc,
     Statusdesc, Agentfirstname, Agentlastname, Agencyfirstname, Agencylastname, Ph_Last_Name, Ph_First_Name,
     Inceptiondate, P_Startdate, policy_end_date, Effective_Date, Accounting_Date, Cancel_Date, pay_plan, Class, Subclass,
     Premiumtype, Premium, Commission, Geniuspremium, bill_method,
    (select sysdate from policy_audit pa where pa.batch_no = sps_activity_withclass.batch_no) Posting_Date
  From Sps_Activity_Withclass ("3", :Dt_Fromdate, :Dt_Todate, "Y", "Y", "Y", "Y", "Y", "N", "N", "N", "N", "XX", "AG", "XX")'
where name = 'Policy Activity with Class by Posting Date'^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("200113TN1", "add bill_method  to adhoc", "01/13/2020")^
SET TERM ;^
COMMIT WORK;

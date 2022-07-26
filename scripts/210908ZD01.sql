set term !;

create procedure temp_pre_questionnaire
as
    declare variable var_qid   integer;
	declare variable var_quid  integer;
begin
	
	/* Add new Questionnaire */
	var_qid = gen_id(questionnaire_id_gen, 1);
	INSERT INTO QUESTIONNAIRE
		values (:var_qid, "XX", "HR", "PREQUAL", "01.01.2001", "31.12.9999", "A",	"Clients/ArgusMT/Scripts/Questionnaire/PrequalQuestionnaire_HR_XX_v1.js");

	/* Add new Questions */
	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 '<p><b>Have you, or any person to be insured:</b></p>', 
		 'SECTION', NULL, 
		 NULL, 'TRUE', 'FALSE', 'HAVE_YOU_SECTION', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 1);
	
	var_quid = gen_id (question_id_gen, 1);
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'PREQUAL', 
		 'Previously held insurance for any of the covers to which this proposal relates at these premises or elsewhere?', 
		 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
		 NULL, 'TRUE', 'Q', 'PREV_INSURANCE', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 2);
		
	var_quid = gen_id (question_id_gen, 1);	
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'PREQUAL', 
		 'Please select name of Insurers', 
		 'LIST', '[{"Selected": true, "Text": "-- Select --", "Value": ""},{"Selected": false, "Text": "Argoglobal Se", "Value": "Argoglobal Se"},{"Selected": false, "Text": "Atlas Insurance PCC Ltd", "Value": "Atlas Insurance PCC Ltd"},{"Selected": false, "Text": "Axeria Insurance Limited", "Value": "Axeria Insurance Limited"},{"Selected": false, "Text": "Bavaria Reinsurance Malta Limited", "Value": "Bavaria Reinsurance Malta Limited"},{"Selected": false, "Text": "Building Block Insurance Pcc Limited", "Value": "Building Block Insurance Pcc Limited"},{"Selected": false, "Text": "Citadel Insurance plc", "Value": "Citadel Insurance plc"},{"Selected": false, "Text": "Collinson Insurance Solutions", "Value": "Collinson Insurance Solutions"},{"Selected": false, "Text": "DARAG Group Ltd", "Value": "DARAG Group Ltd"},{"Selected": false, "Text": "Elmo Insurance Ltd", "Value": "Elmo Insurance Ltd"},{"Selected": false, "Text": "Eucare Insurance PCC Ltd", "Value": "Eucare Insurance PCC Ltd"},{"Selected": false, "Text": "Exchange Re SCC", "Value": "Exchange Re SCC"},{"Selected": false, "Text": "Fortegra Europe Insurance Company", "Value": "Fortegra Europe Insurance Company"},{"Selected": false, "Text": "Fresenius Medical Care Global Insurance Ltd.", "Value": "Fresenius Medical Care Global Insurance Ltd."},{"Selected": false, "Text": "GasanMamo Insurance Ltd", "Value": "GasanMamo Insurance Ltd"},{"Selected": false, "Text": "Globalcapital Financial Management Limited", "Value": "Globalcapital Financial Management Limited"},{"Selected": false, "Text": "Highdome Pcc Limited", "Value": "Highdome Pcc Limited"},{"Selected": false, "Text": "HSBC Life Assurance (Malta) Ltd", "Value": "HSBC Life Assurance (Malta) Ltd"},{"Selected": false, "Text": "London & Leith Insurance PCC", "Value": "London & Leith Insurance PCC"},{"Selected": false, "Text": "MAPFRE Middlesea plc", "Value": "MAPFRE Middlesea plc"},{"Selected": false, "Text": "Mapfre Msv Life P.L.C.", "Value": "Mapfre Msv Life P.L.C."},{"Selected": false, "Text": "Munich Re of Malta p.l.c.", "Value": "Munich Re of Malta p.l.c."},{"Selected": false, "Text": "Nissan International Insurance Ltd", "Value": "Nissan International Insurance Ltd"},{"Selected": false, "Text": "Oney Insurance (Pcc) Limited", "Value": "Oney Insurance (Pcc) Limited"},{"Selected": false, "Text": "Premium Insurance Company Limited", "Value": "Premium Insurance Company Limited"},{"Selected": false, "Text": "Starr Europe Insurance Ltd", "Value": "Starr Europe Insurance Ltd"},{"Selected": false, "Text": "Tangiers Group", "Value": "Tangiers Group"}]', 
		 NULL, 'FALSE', 'Q', 'PREV_INSURANCE_NAME', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 3);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Policy Number', 
		 'TEXT', NULL, 
		 NULL, 'FALSE', 'FALSE', 'PREV_POLICY_NO', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 4);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Ever had a proposal for insurance declined, renewal refused, cover terminated, increased premium required or special conditions imposed by an insurer?', 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
		 NULL, 'TRUE', 'Q', 'DECLINED_INSURANCE', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 5);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Please explain', 
		 'MEMO', NULL, 
		 NULL, 'FALSE', 'Q', 'DECLINED_INSURANCE_YES', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 6);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Ever been convicted or charged (but not yet tried) with a criminal offence other than a motoring offence?', 
		 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
		 NULL, 'TRUE', 'Q', 'CRIMINAL_OFFENCE', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 7);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Please explain', 
		 'MEMO', NULL, 
		 NULL, 'FALSE', 'Q', 'CRIMINAL_OFFENCE_YES', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 8);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Ever been declared bankrupt or are the subject of any current bankruptcy proceedings or any voluntary or mandatory insolvency or winding up procedures?',
		 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
		 NULL, 'TRUE', 'Q', 'BANKRUPT', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 9);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Please explain', 
		 'MEMO', NULL, 
		 NULL, 'FALSE', 'Q', 'BANKRUPT_YES', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 10);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Had within the last five years any losses whether insured or not or had any claims made against you (in this or any existing or previous business)?', 
		 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
		 NULL, 'TRUE', 'Q', 'LOSSES', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 11);

	var_quid = gen_id (question_id_gen, 1);			  
	INSERT INTO QUESTION
		 VALUES (:var_quid, 'PREQUAL', 
		 'Please provide details, including date, type of claim, circumstances, amount paid, and post loss action taken', 
		 'MEMO', NULL, 
		 NULL, 'FALSE', 'Q', 'LOSSES_YES', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 12);
	
	

end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210908ZD01", "MHM-980 HR questionnaire", "2021-SEP-08");
commit work;
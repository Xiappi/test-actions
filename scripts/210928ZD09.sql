set term !;

create procedure temp_app_questionnaire
as
    declare variable var_qid   integer;
	declare variable var_quid  integer;
begin
	
	/* Add new Questionnaire */
	var_qid = gen_id(questionnaire_id_gen, 1);
	INSERT INTO QUESTIONNAIRE
		values (:var_qid, "XX", "MY", "APPLICATION", "01.01.2001", "31.12.9999", "A", "Clients/ArgusMT/Scripts/Questionnaire/ApplicationQuestionnaire_MY_XX_v1.js");

	/* Add new Questions */
	var_quid = gen_id (question_id_gen, 1);
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'APPLICATION', 
				 'Do you or any other person(s) possess a valid driving licence to drive the vehicle in question?', 
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
				 NULL, 'TRUE', 'A', 'VALID_LICENSE_MY', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 1);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'APPLICATION',
                 'Please explain.',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'VALID_LICENSE_NO_MY', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 2);
	
	var_quid = gen_id (question_id_gen, 1);
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'APPLICATION', 
				 '<b><p>Do you or any other person(s) who will be driving:</b></p>', 
				 'SECTION', null, 
				 NULL, 'TRUE', 'FALSE', 'WHO_WILL_DRIVE_MY', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 3);
		 
	var_quid = gen_id (question_id_gen, 1);
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'APPLICATION', 
				 'Suffer from Diabetes, Epilepsy, a heart condition or any disease or infirmity which could affect your/their ability to drive?', 
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
				 NULL, 'TRUE', 'A', 'CONDITION_MY', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 4);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'APPLICATION',
                 'Please explain.',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'CONDITION_YES_MY', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 5);
		 
	var_quid = gen_id (question_id_gen, 1);
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'APPLICATION', 
				 'Need to undergo regular check-ups in relation to eyesight?', 
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
				 NULL, 'TRUE', 'A', 'EYESIGHT_MY', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 6);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'APPLICATION',
                 'Please explain.',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'EYESIGHT_YES_MY', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 7);
		 
	var_quid = gen_id (question_id_gen, 1);
	INSERT INTO QUESTION 
		 VALUES (:var_quid, 'APPLICATION', 
				 'Have any penalty points on driving licence?', 
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', 
				 NULL, 'TRUE', 'A', 'PENALTY_MY', '', NULL, NULL);
	insert into questionnaire_question
         values (:var_qid, :var_quid, 8);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'APPLICATION',
                 'Please explain.',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'PENALTY_YES_MY', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 9);

end!

commit!
execute procedure temp_app_questionnaire!
commit!
drop procedure temp_app_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210928ZD09", "MHM-151 MY app questionnaire", "2021-SEP-28");
commit work;
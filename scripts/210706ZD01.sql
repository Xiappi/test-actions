set term !;

create procedure temp_dwel_questionnaire
as
    declare variable var_qid   integer;
    declare variable var_quid  integer;
begin

	/* Added new app questionnaire */
	var_qid = gen_id (questionnaire_id_gen, 1);
	insert into questionnaire
	     values(:var_qid, "XX", "HX", "DWELLING", "2001-01-01", "9999-12-31", "A", 
		        "Clients/ArgusMT/Scripts/Questionnaire/DwellingQuestionnaire_HX_XX_v1.js");
				
	/* Add to Dwellings */
	update ref_table 
	   set questionnaire_id = :var_qid 
	 where line = "HX" 
	   and ref_code = "FORM";
	   

	/* Add Questions */	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Is this property occupied during the week?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'OCCUPIED_WEEK', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 1);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'OCCUPIED_WEEK_NO', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 2);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Is this property in a good state of repair?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'GOOD_STATE', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 3);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'GOOD_STATE_NO', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 4);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Is this property exposed to damage by storm or flood?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'FLOOD_DAMAGE', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 5);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'FLOOD_DAMAGE_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 6);	 
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Is this property left unoccupied for more than 90 consecutive days?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'UNOCCUPIED', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 7);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'UNOCCUPIED_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 8);	
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Is this property undergoing renovation or refurbishment?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'RENOVATIONS', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 9);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'RENOVATIONS_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 10);	
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'If renovations are being undertaken by contractors, please note that this policy excludes loss, damage or liability arising out of the activities of contractors. Please provide full details of the schedule of works to be undertaken.',
                 'INFO', null,
                 null, 'FALSE', 'FALSE', 'RENOVATIONS_YES_INFO', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 11);	
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Is this property in an area free from flooding in the last 10 years?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'FLOOD_FREE', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 12);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'FLOOD_FREE_NO', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 13);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 '<p><b>In respect of subsidence, heave or landslip, is the property to be insured:</b></p>',
                 'SECTION', null,
                 null, 'TRUE', 'FALSE', 'IN_RESPECT_SECTION', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 14);	 
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Showing any signs of damage (such as cracks inside or outside)?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'SIGNS_DAMAGE', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 15);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'SIGNS_DAMAGE_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 16);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Showing any signs of movement or been the subject of structural repairs at any time?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'SIGNS_MOVEMENT', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 17);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'SIGNS_MOVEMENT_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 18);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'The subject of a valuation or survey report which mentioned settlement or movement of buildings or recommends further investigation?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'SURVEY_REPORT', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 19);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'SURVEY_REPORT_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 20);	
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please supply a copy of the report',
                 'INFO', null,
                 null, 'FALSE', 'FALSE', 'SURVEY_REPORT_COPY', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 21);
	
end!

commit!
execute procedure temp_dwel_questionnaire!
commit!
drop procedure temp_dwel_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210706ZD01", "MHM-237 Added HX dwel questionnaire", "2021-JUL-06");
commit work;
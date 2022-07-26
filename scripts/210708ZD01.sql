set term !;

create procedure temp_pre_questionnaire
as
    declare variable var_qid   integer;
    declare variable var_quid  integer;
begin
    /* Grab the ID of the existing questionnaires */
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'HX'
      into :var_qid;
	   
	/* Move every question except the first one up one */
	update questionnaire_question 
	   set question_order = question_order + 1 
	 where questionnaire_id = :var_qid
	   and question_order > 1;
	   
	/* Move the last two questions up one more time */
	update questionnaire_question 
	   set question_order = question_order + 5 
	 where questionnaire_id = :var_qid
	   and question_order > 12;
	   
	/* Add in paragraph sections */
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 '<p><b>Have you, or any person to be insured</b></p>',
                 'SECTION', null,
                 null, 'TRUE', 'FALSE', 'HAVE_YOU_SECTION', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 1);	
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 '<p><b>Has your home ever been</b></p>',
                 'SECTION', null,
                 null, 'TRUE', 'FALSE', 'HAS_YOUR_SECTION', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 13);	

	/* Add in missing questions */
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Damaged by storm and/or flood?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'STORM', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 14);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'STORM_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 15);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Subject to a break-in (or attempted break-in by burglars)?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'A', 'BREAKIN', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 16);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Please explain',
                 'MEMO', null,
                 null, 'FALSE', 'A', 'BREAKIN_YES', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 17);

	/* Fix wording of questions */
	update question q
	   set q.TEXT = "Ever had a proposal for insurance declined, renewal refused, cover terminated, increased premium required or special conditions imposed by an insurer?"
	 where q.NAME = "DECLINED_INSURANCE";
	
	update question q
	   set q.TEXT = "Suffered any loss, damage, injury or liability in the last 5 years (whether insured or not) from any of the events to be insured by this policy?"
	 where q.NAME = "SUFFERED_LOSS";
	 
	update question q
	   set q.TEXT = "Ever been convicted of, or cautioned for (or charged but not yet tried with) any criminal offence (other than motoring offences)?"
	 where q.NAME = "CONVICTED";
	 
	/* Fix required "Name of other insurer" to be in quote */
	update question q
	   set q.REQUIRED = "Q"
	 where q.NAME = "PREV_INSURANCE_OTHER";
	
end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210708ZD01", "MHM-505 Update HX Questionnaire", "2021-JUL-08");
commit work;
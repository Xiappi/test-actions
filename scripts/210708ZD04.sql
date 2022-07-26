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
       and line = 'PC'
      into :var_qid;
	   
	/* Move every question up one */
	update questionnaire_question 
	   set question_order = question_order + 1
	 where questionnaire_id = :var_qid;
	   
	/* Add in paragraph sections */
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 '<p><b>Have you, or any person to be insured</b></p>',
                 'SECTION', null,
                 null, 'TRUE', 'FALSE', 'HAVE_YOU_SECTION', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 1);
end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210708ZD04", "MHM-505 Update PC Questionnaire", "2021-JUL-08");
commit work;
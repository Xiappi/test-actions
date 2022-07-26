set term !;

create procedure temp_pre_questionnaire
as
    declare variable var_qid   integer;
	declare variable var_quid  integer;
begin
	  
	select id
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'HX'
      into :var_qid;
	  
	/* Fix this question's order position first */
	update questionnaire_question 
	   set question_order = 2
	 where questionnaire_id = :var_qid
	   and question_id = 151;
	  
	/* Move every question up Two */
	update questionnaire_question 
	   set question_order = question_order + 2
	 where questionnaire_id = :var_qid
	   and question_order > 1;
	   
	/* Add in paragraph sections */
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Is this a second home?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'FALSE', 'Q', 'SECOND_HOME', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 2);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Is this property rented out?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'FALSE', 'Q', 'RENTED_HOME', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 3);
	
end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210903ZD01", "MHM-915 Premenant Residence", "2021-SEP-03");
commit work;
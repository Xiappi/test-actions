set term !;

create procedure temp_dwel_questionnaire
as
    declare variable var_qid   integer;
	declare variable var_quid  integer;
begin
	  
	select id
      from questionnaire 
     where category = 'DWELLING'
       and line = 'HX'
      into :var_qid;
	  
	/* Move every question up one */
	update questionnaire_question 
	   set question_order = question_order + 1
	 where questionnaire_id = :var_qid
	   and question_order > 13;
	   
	/* Add in paragraph sections */
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Date survey conducted',
                 'DATE', null,
                 null, 'TRUE', 'FALSE', 'SURVEY_CONDUCTED', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 14);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'DWELLING',
                 'Please attach a survey form.',
                 'INFO', null,
                 null, 'TRUE', 'FALSE', 'ATTACH_SURVEY', '', null, null);
    insert into questionnaire_question
         values (:var_qid, :var_quid, 15);
	
end!

commit!
execute procedure temp_dwel_questionnaire!
commit!
drop procedure temp_dwel_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210817ZD01", "MHM-765 Add Survey question", "2021-AUG-17");
commit work;
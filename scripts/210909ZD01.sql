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
	   and question_order > 14;
	   
	/* Fix this question's order position */
	update questionnaire_question 
	   set question_order = 15
	 where questionnaire_id = :var_qid
	   and question_id = 166;
	   
	
end!

commit!
execute procedure temp_dwel_questionnaire!
commit!
drop procedure temp_dwel_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210909ZD01", "MHM-998 Correct HX dwell order", "2021-SEP-09");
commit work;
set term !;

create procedure temp_pre_questionnaire
as
    declare variable var_qid   integer;
	declare variable var_quid  integer;
begin

	select ID
	  from questionnaire
	 where line = "HX"
	   and category = "PREQUAL"
	  into :var_qid;

	update question
       set answer_type = "MEMO"
     where (name = "DECLINED_INSURANCE_YES"
        OR name = "SUFFERED_LOSS_YES"
        OR name = "CONVICTED_YES"
        OR name = "STORM_YES"
        OR name = "MATERIAL_FACT_YES")
       AND (id in (select question_id
                    from questionnaire_question 
                   where questionnaire_id = :var_qid));

end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210929ZD01", "MHM-1094 Updated small text boxes", "2021-SEP-29");
commit work;
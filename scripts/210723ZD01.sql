set term !;

create procedure temp_pre_questionnaire
as
    declare variable var_rpid  integer;
    declare variable var_spid  integer;
    declare variable var_opid  integer;
    declare variable var_hxid  integer;
    declare variable var_quid  integer;
begin
    /* Grab the ID of the existing questionnaires */
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'RP'
      into :var_rpid;
	  
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'SP'
      into :var_spid;
	  
	select id
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'OP'
      into :var_opid;
	  
	select id
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'HX'
      into :var_hxid;
	  
	/* Change all 'Have you" sections first */
	update question q
	   set q.text = '<p><b>Have you, or any person to be insured:</b></p>'
	 where q.name = 'HAVE_YOU_SECTION';
	 
	/* Change SME text and give unique name */
	update question q
       set q.text = "Name of the other Insurer"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "PREV_INSURANCE_OTHER"
                      and qq.questionnaire_id = :var_opid);
	
	update question q
       set q.text = "Name of the other Insurer"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "PREV_INSURANCE_OTHER"
                      and qq.questionnaire_id = :var_rpid);
			
	update question q
       set q.text = "Name of the other Insurer"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "PREV_INSURANCE_OTHER"
                      and qq.questionnaire_id = :var_spid);
					  
	update question q
       set q.text = "Name of the other Insurer"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "PREV_INSURANCE_OTHER"
                      and qq.questionnaire_id = :var_hxid);
	
end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210723ZD01", "GSHM-158 Update other insurer name", "2021-JUL-23");
commit work;
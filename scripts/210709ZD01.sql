set term !;

create procedure temp_pre_questionnaire
as
    declare variable var_rpid  integer;
    declare variable var_spid  integer;
    declare variable var_opid  integer;
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
	  
	/* Change all 'Have you" sections first */
	update question q
	   set q.text = '<p><b>Have you, or any person to be insured:</b></p>'
	 where q.name = 'HAVE_YOU_SECTION';
	 
	/* Change SME text and give unique name */
	update question q
       set q.text = "<p><b>Have you or any of your partners or directors either personally or in connection with any business in which you have been involved:</b></p>", 
	       q.name = "HAVE_YOU_SECTION_SME"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "HAVE_YOU_SECTION"
                      and qq.questionnaire_id = :var_opid);
	
	update question q
       set q.text = "<p><b>Have you or any of your partners or directors either personally or in connection with any business in which you have been involved:</b></p>", 
	       q.name = "HAVE_YOU_SECTION_SME"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "HAVE_YOU_SECTION"
                      and qq.questionnaire_id = :var_rpid);
			
	update question q
       set q.text = "<p><b>Have you or any of your partners or directors either personally or in connection with any business in which you have been involved:</b></p>", 
	       q.name = "HAVE_YOU_SECTION_SME"
     where q.id = (select qq.question_id
                     from question q inner join questionnaire_question qq
                       on qq.question_id = q.id
                    where q.name = "HAVE_YOU_SECTION"
                      and qq.questionnaire_id = :var_spid);
	
end!

commit!
execute procedure temp_pre_questionnaire!
commit!
drop procedure temp_pre_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210709ZD01", "MHM-523 Update SME Questionnaire head", "2021-JUL-09");
commit work;
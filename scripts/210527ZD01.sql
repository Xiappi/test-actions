set term !;

create procedure temp_app_questionnaire
as
    declare variable var_rpqid   integer;
    declare variable var_spqid   integer;
    declare variable var_opqid   integer;
    declare variable var_hxqid   integer;
    declare variable var_quid    integer;
begin
    /* Grab the ID of the existing questionnaires */
    select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'RP'
      into :var_rpqid;
	  
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'SP'
      into :var_spqid;
	  
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'OP'
      into :var_opqid;
	  
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'HX'
      into :var_hxqid;
	  
	update question q
       set q.ANSWER_LIST = '[{"Selected": true, "Text": "-- Select --", "Value": ""},{"Selected": false, "Text": "Argoglobal Se", "Value": "Argoglobal Se"},{"Selected": false, "Text": "Atlas Insurance PCC Ltd", "Value": "Atlas Insurance PCC Ltd"},{"Selected": false, "Text": "Axeria Insurance Limited", "Value": "Axeria Insurance Limited"},{"Selected": false, "Text": "Bavaria Reinsurance Malta Limited", "Value": "Bavaria Reinsurance Malta Limited"},{"Selected": false, "Text": "Building Block Insurance Pcc Limited", "Value": "Building Block Insurance Pcc Limited"},{"Selected": false, "Text": "Citadel Insurance plc", "Value": "Citadel Insurance plc"},{"Selected": false, "Text": "Collinson Insurance Solutions", "Value": "Collinson Insurance Solutions"},{"Selected": false, "Text": "DARAG Group Ltd", "Value": "DARAG Group Ltd"},{"Selected": false, "Text": "Elmo Insurance Ltd", "Value": "Elmo Insurance Ltd"},{"Selected": false, "Text": "Eucare Insurance PCC Ltd", "Value": "Eucare Insurance PCC Ltd"},{"Selected": false, "Text": "Exchange Re SCC", "Value": "Exchange Re SCC"},{"Selected": false, "Text": "Fortegra Europe Insurance Company", "Value": "Fortegra Europe Insurance Company"},{"Selected": false, "Text": "Fresenius Medical Care Global Insurance Ltd.", "Value": "Fresenius Medical Care Global Insurance Ltd."},{"Selected": false, "Text": "GasanMamo Insurance Ltd", "Value": "GasanMamo Insurance Ltd"},{"Selected": false, "Text": "Globalcapital Financial Management Limited", "Value": "Globalcapital Financial Management Limited"},{"Selected": false, "Text": "Highdome Pcc Limited", "Value": "Highdome Pcc Limited"},{"Selected": false, "Text": "HSBC Life Assurance (Malta) Ltd", "Value": "HSBC Life Assurance (Malta) Ltd"},{"Selected": false, "Text": "London & Leith Insurance PCC", "Value": "London & Leith Insurance PCC"},{"Selected": false, "Text": "MAPFRE Middlesea plc", "Value": "MAPFRE Middlesea plc"},{"Selected": false, "Text": "Mapfre Msv Life P.L.C.", "Value": "Mapfre Msv Life P.L.C."},{"Selected": false, "Text": "Munich Re of Malta p.l.c.", "Value": "Munich Re of Malta p.l.c."},{"Selected": false, "Text": "Nissan International Insurance Ltd", "Value": "Nissan International Insurance Ltd"},{"Selected": false, "Text": "Oney Insurance (Pcc) Limited", "Value": "Oney Insurance (Pcc) Limited"},{"Selected": false, "Text": "Premium Insurance Company Limited", "Value": "Premium Insurance Company Limited"},{"Selected": false, "Text": "Starr Europe Insurance Ltd", "Value": "Starr Europe Insurance Ltd"},{"Selected": false, "Text": "Tangiers Group", "Value": "Tangiers Group"},{"Selected": false, "Text": "Other", "Value": "OTHER"}]'
     where q.NAME = 'PREV_INSURANCE_NAME';
	 
	/* Update Question orders to make room for the other question */
	update questionnaire_question 
	   set question_order = question_order + 1 
	 where questionnaire_id = :var_rpqid
	   and question_order > 2;
	  
	update questionnaire_question 
	   set question_order = question_order + 1 
	 where questionnaire_id = :var_spqid
	   and question_order > 2;
	 
	update questionnaire_question 
	   set question_order = question_order + 1 
	 where questionnaire_id = :var_opqid
	   and question_order > 2;
	 
	update questionnaire_question 
	   set question_order = question_order + 1 
	 where questionnaire_id = :var_hxqid
	   and question_order > 2;
	  

	/* Insert new general questions into the questionnaire */		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'APPLICATION',
                 'Name of other insurer:',
                 'TEXT', null,
                 null, 'FALSE', 'A', 'PREV_INSURANCE_OTHER', '', null, null);
    insert into questionnaire_question
         values (:var_rpqid, :var_quid, 3);
	insert into questionnaire_question
         values (:var_spqid, :var_quid, 3);
	insert into questionnaire_question
         values (:var_opqid, :var_quid, 3);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 3);
	
end!

commit!
execute procedure temp_app_questionnaire!
commit!
drop procedure temp_app_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210527ZD01", "MHM-186 Added Other insurer to prequal", "2021-MAY-27");
commit work;
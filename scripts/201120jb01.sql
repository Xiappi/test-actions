set term !;

create procedure temp_app_questionnaire
as
	declare variable effdate date;
	declare variable appqid  integer;
	declare variable quid    integer;
begin
    select min(effective_date)
      from rate_book
      into :effdate;

    appqid = gen_id(questionnaire_id_gen, 1);
    insert into questionnaire
         values (:appqid, 'XX', 'SP', 'APPLICATION', :effdate, '12/31/9999', 'A',
                 'Clients/ArgusMT/Scripts/Questionnaire/ApplicationQuestionnaire_SP_XX_v1.js');

    quid = gen_id (question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION',
				 'Are all your final exit doors protected with adequate deadlocks and are all accessible windows fitted with window locks?',
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
				 null, 'TRUE', 'A', 'LOCKS', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 1);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Please explain', 'MEMO', null, null, 'FALSE', 'A', 'LOCKS_NO', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 2);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION',
				 'Do you have any form of intruder alarm or fire alarm fitted, if so are they in working order and regularly maintained?',
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
				 null, 'TRUE', 'A', 'ALARMS', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 3);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Please explain', 'MEMO', null, null, 'FALSE', 'A', 'ALARMS_YES', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 4);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Is any work undertaken away from the premises?', 'BUTTON',
				 '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
				 null, 'TRUE', 'A', 'WORK_OFF_PREM', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 5);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Please explain', 'MEMO', null, null, 'FALSE', 'A', 'WORK_OFF_PREM_YES', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 6);

	appqid = gen_id(questionnaire_id_gen, 1);
	insert into questionnaire
		 values (:appqid, 'XX', 'OP', 'APPLICATION', :effdate, '12/31/9999', 'A',
				 'Clients/ArgusMT/Scripts/Questionnaire/ApplicationQuestionnaire_OP_XX_v1.js');
				 
	quid = gen_id (question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION',
				 'Are all your final exit doors protected with adequate deadlocks and are all accessible windows fitted with window locks?',
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
				 null, 'TRUE', 'A', 'LOCKS', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 1);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Please explain', 'MEMO', null, null, 'FALSE', 'A', 'LOCKS_NO', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 2);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION',
				 'Do you have any form of intruder alarm or fire alarm fitted, if so are they in working order and regularly maintained?',
				 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
				 null, 'TRUE', 'A', 'ALARMS', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 3);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Please explain', 'MEMO', null, null, 'FALSE', 'A', 'ALARMS_YES', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 4);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Is any work undertaken away from the premises?', 'BUTTON',
				 '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
				 null, 'TRUE', 'A', 'WORK_OFF_PREM', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 5);

	quid = gen_id(question_id_gen, 1);
	insert into question
		 values (:quid, 'APPLICATION', 'Please explain', 'MEMO', null, null, 'FALSE', 'A', 'WORK_OFF_PREM_YES', '', null, null);
	insert into questionnaire_question
         values (:appqid, :quid, 6);
end!

commit!
execute procedure temp_app_questionnaire!
commit!
drop procedure temp_app_questionnaire!
commit!

set term;!

insert into applied_scripts (name, description, script_date)
     values ("201120jb01", "BCSB-1235 Add SP and OP app questionnaires", "2020-NOV-20");
commit work;
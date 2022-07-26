insert into questionnaire 
values (gen_id(questionnaire_id_gen, 1), 'XX', 'RP', 'APPLICATION', '01/01/1996', '12/31/9999', 'A', 'Clients/ArgusMT/Scripts/Questionnaire/ApplicationQuestionnaire_RP_XX_v1.js');


insert into question 
values (
    gen_id(question_id_gen, 1),
    'APPLICATION',
    'Are all your final exit doors protected with adequate deadlocks and are all accessible windows fitted with window locks?',
    'BUTTON',
    '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
    null,
    'TRUE',
    'A',
    'LOCKS',
    '',
    null,
    null
);


insert into question 
values (
    gen_id(question_id_gen, 1),
    'APPLICATION',
    'Please explain',
    'MEMO',
    null,
    null,
    'FALSE',
    'A',
    'LOCKS_NO',
    '',
    null,
    null
);


insert into question 
values (
    gen_id(question_id_gen, 1),
    'APPLICATION',
    'Do you have any form of intruder alarm or fire alarm fitted, if so are they in working order and regularly maintained?',
    'BUTTON',
    '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
    null,
    'TRUE',
    'A',
    'ALARMS',
    '',
    null,
    null
);

insert into question 
values (
    gen_id(question_id_gen, 1),
    'APPLICATION',
    'Please explain',
    'MEMO',
    null,
    null,
    'FALSE',
    'A',
    'ALARMS_YES',
    '',
    null,
    null
);


insert into question 
values (
    gen_id(question_id_gen, 1),
    'APPLICATION',
    'Is any work undertaken away from the premises?',
    'BUTTON',
    '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
    null,
    'TRUE',
    'A',
    'WORK_OFF_PREM',
    '',
    null,
    null
);

insert into question 
values (
    gen_id(question_id_gen, 1),
    'APPLICATION',
    'Please explain',
    'MEMO',
    null,
    null,
    'FALSE',
    'A',
    'WORK_OFF_PREM_YES',
    '',
    null,
    null
);

commit;

insert into questionnaire_question
values (2,12,1);

insert into questionnaire_question
values (2,13,2);

insert into questionnaire_question
values (2,14,3);

insert into questionnaire_question
values (2,15,4);

insert into questionnaire_question
values (2,16,5);

insert into questionnaire_question
values (2,17,6);

commit;

insert into applied_scripts (name, description, script_date)
     values ('200922CW02', 'BCSB-546 - Update Malta RP app questionnaire', '2020-September-22');

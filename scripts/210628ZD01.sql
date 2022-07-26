set term !;

create procedure temp_app_questionnaire
as
    declare variable var_hxqid integer;
    declare variable var_quid  integer;
begin
    /* Grab the ID of the existing questionnaires */
	select id 
      from questionnaire 
     where category = 'PREQUAL'
       and line = 'HX'
      into :var_hxqid;
	 
	/* Remove the other questions */
	delete from questionnaire_question
	 where questionnaire_id = :var_hxqid
	   and question_order > 4;
	 
	delete from question
	 where id = 55;
	 
	delete from question
	 where id = 56;
	 
	delete from question
	 where id = 57;
	 
	delete from question
	 where id = 58;
	 
	delete from question
	 where id = 59;
	 
	delete from question
	 where id = 60;
	 
	delete from question
	 where id = 61;
	 
	delete from question
	 where id = 62;

	/* Move the remaining questions up one */
	update questionnaire_question 
	   set question_order = question_order + 1 
	 where questionnaire_id = :var_hxqid;
	
	/* Insert new questions into the questionnaire */		
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Is this property your permanent residence?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'Q', 'PERMENANT_RESIDENCE', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 1);

	/* The pre-existing questions take up 2, 3, 4 and 5 */
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Have you, or any person to be insured ever had a proposal for insurance declined, renewal refused, cover terminated, increased premium required or special conditions imposed by an insurer?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'Q', 'DECLINED_INSURANCE', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 6);
		 	 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Please explain.',
                 'TEXT', null,
                 null, 'FALSE', 'Q', 'DECLINED_INSURANCE_YES', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 7);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Have you, or any person to be insured suffered any loss, damage, injury or liability in the last 5 years (whether insured or not) from any of the events to be insured by this policy?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'Q', 'SUFFERED_LOSS', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 8);
		 	 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Please explain.',
                 'TEXT', null,
                 null, 'FALSE', 'Q', 'SUFFERED_LOSS_YES', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 9);
		 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Have you, or any person to be insured ever been convicted of, or cautioned for (or charged but not yet tried with) any criminal offence (other than motoring offences)?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'Q', 'CONVICTED', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 10);
		 	 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Please explain.',
                 'TEXT', null,
                 null, 'FALSE', 'Q', 'CONVICTED_YES', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 11);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 '<hr>',
                 'INFO', null,
                 null, 'TRUE', 'FALSE', 'PAGE_BREAK', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 12);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Is the property located in any of the following areas?',
                 'LIST', "[{'Selected': true, 'Text': '-- Select --', 'Value': '' }, {'Selected': false, 'Text': 'Balzan (whole locality)', 'Value': 'BALZAN' }, {'Selected': false, 'Text': 'Valley Road / Triq Il-Wied at Birkirkara / B\'Kara and Msida', 'Value': 'VALLEY_ROAD' }, {'Selected': false, 'Text': 'The Strand / Triq Ix-Xatt at Ta\' Xbiex and Gzira', 'Value': 'STRAND' }, {'Selected': false, 'Text': 'Spinola Bay area i.e. St. George\'s Road / Triq San Gorg and George Borg Olivier Street / Troq Gorg Borg Olivier at St. Julians / San Giljan', 'Value': 'SPINOLA' }, {'Selected': false, 'Text': 'Triq ix-Xatt and Triq iz-Zonqor / Zonqor Road at Marsaskala / M\'Skala', 'Value': 'TRIQ_IX' }, {'Selected': false, 'Text': 'St George\'s Street / Triq San Gorg at Birzebbugia / B\'Bugia', 'Value': 'ST_GEORGE' }, {'Selected': false, 'Text': 'Xatt is-Sajjieda at Marsaxlokk / M\'Xlokk', 'Value': 'XATT_IS' }, {'Selected': false, 'Text': 'Xatt il-Pwales / Triq il-Pwales / Pwales Road at Xemxija forming part of San Pawl il-Bahar / St. Paul\'s Bay ', 'Value': 'XATT_IL' }, {'Selected': true, 'Text': 'None', 'Value': 'NONE' }]",
                 null, 'TRUE', 'Q', 'LOCATED', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 13);
	
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Is there any detail or material fact which you feel we should be made aware of?',
                 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]',
                 null, 'TRUE', 'Q', 'MATERIAL_FACT', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 14);
		 	 
	var_quid = gen_id (question_id_gen, 1);
    insert into question
         values (:var_quid, 'PREQUAL',
                 'Please explain.',
                 'TEXT', null,
                 null, 'FALSE', 'Q', 'MATERIAL_FACT_YES', '', null, null);
	insert into questionnaire_question
         values (:var_hxqid, :var_quid, 15);
end!

commit!
execute procedure temp_app_questionnaire!
commit!
drop procedure temp_app_questionnaire!
commit!

set term;!

commit;

insert into applied_scripts (name, description, script_date)
     values ("210628ZD01", "MHM-447 New HX questionnaire", "2021-JUN-28");
commit work;
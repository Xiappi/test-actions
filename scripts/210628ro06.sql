set term ^;
create procedure temp_mf_prequal
as
declare variable qid integer;
declare variable uid integer;
declare variable effdate date;

begin
  qid = gen_id(questionnaire_id_gen, 1);
  select min(effective_date) from rate_book into :effdate;

  insert into questionnaire values(:qid, 'XX', 'MF', 'PREQUAL', :effdate, '31-DEC-9999', 'A', 'Clients/ArgusMT/Scripts/Questionnaire/PrequalQuestionnaire_MF_XX_v1.js');
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Previously held insurance for any of the covers to which this proposal relates at these premises or elsewhere?', 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', null, 'TRUE', 'Q', 'PREV_INSURANCE', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 1);

  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Please select name of Insurers ', 'LIST', '[{"Selected": true, "Text": "-- Select --", "Value": ""},{"Selected": false, "Text": "Argoglobal Se", "Value": "Argoglobal Se"},{"Selected": false, "Text": "Atlas Insurance PCC Ltd", "Value": "Atlas Insurance PCC Ltd"},{"Selected": false, "Text": "Axeria Insurance Limited", "Value": "Axeria Insurance Limited"},{"Selected": false, "Text": "Bavaria Reinsurance Malta Limited", "Value": "Bavaria Reinsurance Malta Limited"},{"Selected": false, "Text": "Building Block Insurance Pcc Limited", "Value": "Building Block Insurance Pcc Limited"},{"Selected": false, "Text": "Citadel Insurance plc", "Value": "Citadel Insurance plc"},{"Selected": false, "Text": "Collinson Insurance Solutions", "Value": "Collinson Insurance Solutions"},{"Selected": false, "Text": "DARAG Group Ltd", "Value": "DARAG Group Ltd"},{"Selected": false, "Text": "Elmo Insurance Ltd", "Value": "Elmo Insurance Ltd"},{"Selected": false, "Text": "Eucare Insurance PCC Ltd", "Value": "Eucare Insurance PCC Ltd"},{"Selected": false, "Text": "Exchange Re SCC", "Value": "Exchange Re SCC"},{"Selected": false, "Text": "Fortegra Europe Insurance Company", "Value": "Fortegra Europe Insurance Company"},{"Selected": false, "Text": "Fresenius Medical Care Global Insurance Ltd.", "Value": "Fresenius Medical Care Global Insurance Ltd."},{"Selected": false, "Text": "GasanMamo Insurance Ltd", "Value": "GasanMamo Insurance Ltd"},{"Selected": false, "Text": "Globalcapital Financial Management Limited", "Value": "Globalcapital Financial Management Limited"},{"Selected": false, "Text": "Highdome Pcc Limited", "Value": "Highdome Pcc Limited"},{"Selected": false, "Text": "HSBC Life Assurance (Malta) Ltd", "Value": "HSBC Life Assurance (Malta) Ltd"},{"Selected": false, "Text": "London & Leith Insurance PCC", "Value": "London & Leith Insurance PCC"},{"Selected": false, "Text": "MAPFRE Middlesea plc", "Value": "MAPFRE Middlesea plc"},{"Selected": false, "Text": "Mapfre Msv Life P.L.C.", "Value": "Mapfre Msv Life P.L.C."},{"Selected": false, "Text": "Munich Re of Malta p.l.c.", "Value": "Munich Re of Malta p.l.c."},{"Selected": false, "Text": "Nissan International Insurance Ltd", "Value": "Nissan International Insurance Ltd"},{"Selected": false, "Text": "Oney Insurance (Pcc) Limited", "Value": "Oney Insurance (Pcc) Limited"},{"Selected": false, "Text": "Premium Insurance Company Limited", "Value": "Premium Insurance Company Limited"},{"Selected": false, "Text": "Starr Europe Insurance Ltd", "Value": "Starr Europe Insurance Ltd"},{"Selected": false, "Text": "Tangiers Group", "Value": "Tangiers Group"}]', null, 'FALSE', 'Q', 'PREV_INSURANCE_NAME', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 2);

  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', "Policy Number", 'TEXT', null, null, 'FALSE', 'Q', 'PREV_POLICY_NO', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 3);

  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Held any insurances (in respect of the covers to which this Proposal relates) which have subsequently been declined, terminated, refused renewal, or accepted subject to special terms?', 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', null, 'TRUE', 'Q', 'DECLINED_INSURANCE', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 4);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Please explain', 'MEMO', null, null, 'FALSE', 'Q', 'DECLINED_INSURANCE_YES', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 5);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Ever been convicted or charged (but not yet tried) with a criminal offence other than a motoring offence?', 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', null, 'TRUE', 'Q', 'CRIMINAL_OFFENCE', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 6);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Please explain', 'MEMO', null, null, 'FALSE', 'Q', 'CRIMINAL_OFFENCE_YES', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 7);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Ever been declared bankrupt or are the subject of any current bankruptcy proceedings or any voluntary or mandatory insolvency or winding up procedures?', 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', null, 'TRUE', 'Q', 'BANKRUPT', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 8);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Please explain', 'MEMO', null, null, 'FALSE', 'Q', 'BANKRUPT_YES', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 9);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Had within the last five years any losses whether insured or not or had any claims made against you (in this or any existing or previous business)?', 'BUTTON', '[{"Selected": false, "Text": "Yes", "Value": "Y" }, {"Selected": false, "Text": "No", "Value": "N"}]', null, 'TRUE', 'Q', 'LOSSES', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 10);
  
  uid = gen_id(question_id_gen, 1);
  insert into question values(:uid, 'PREQUAL', 'Please provide details, including date, type of claim, circumstances, amount paid, and post loss action taken', 'MEMO', null, null, 'FALSE', 'Q', 'LOSSES_YES', '', null, null);
  insert into questionnaire_question values(:qid, :uid, 11);
end^

commit^

execute procedure temp_mf_prequal^

commit^

drop procedure temp_mf_prequal^

commit^

insert into applied_scripts(name, description, script_date)
values ("210628ro06", "MHM-470 Add ArgusMT MF prequal questionnaire", "2021-JUN-28")^
set term ;^
commit work;

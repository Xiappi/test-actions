update questionnaire q
   set q.JAVASCRIPT_REF_RULES = "Clients/ArgusMT/Scripts/Questionnaire/PrequalQuestionnaire_HX_XX_v1.js"
 where q.category = 'PREQUAL'
   and q.line = 'HX'
   and q.state = 'XX';

commit;

insert into applied_scripts (name, description, script_date)
     values ("210506ZD01", "MHM-140 Changes JS path for Prequal", "2021-MAY-05");
commit work;
update question q
   set q.text = "<p><b>Has your home ever been:</b></p>"
 where q.name = "HAS_YOUR_SECTION";
 
insert into applied_scripts (name, description, script_date)
     values ("210709ZD02", "MHM-523 Update 'Have you' header", "2021-JUL-09");
commit work;
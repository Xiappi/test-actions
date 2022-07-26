update question q
   set q.CODE = 'PREQUAL'
 where q.NAME = 'PREV_INSURANCE_OTHER';
	 
insert into applied_scripts (name, description, script_date)
     values ("210625ZD01", "MHM-444 Fixed other insurer code", "2021-JUN-25");
commit work;
update question q
   set q.REQUIRED = "FALSE"
 where q.name = 'PREV_POLICY_NO';

commit;

insert into applied_scripts (name, description, script_date)
     values ("210705ZD01", "MHM-479 Made prev policy not required", "2021-JUL-05");
commit work;
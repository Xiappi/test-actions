update rule_authorization_limits
   set to_limit = 999999999
 where to_limit is null;

insert into applied_scripts(name, description, script_date)
     values ("210707ML00", "MHM-488 - update to_limit where is null", "2021-JUL-07");
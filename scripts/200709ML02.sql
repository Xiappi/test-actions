SET term ^;

/* THE STANDARD VERSION OF THIS SCRIPT UPDATES A COLUMN THAT IS ALREADY UP-TO-DATE FOR THIS CLIENT */

insert into applied_scripts (name, description, script_date)
values ("200709ML02", "BCSB-162 - initialize policy.policy_end_date", "2020-JUL-9")^
    
SET TERM;^

COMMIT WORK;


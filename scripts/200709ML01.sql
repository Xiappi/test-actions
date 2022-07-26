SET term ^;

/* THE STANDARD VERSION OF THIS SCRIPT ADDS A COLUMN THAT AREADY EXISTS FOR THIS CLIENT */

insert into applied_scripts (name, description, script_date)
values ("200709ML01", "BCSB-162 - add column 'policy_end_date' to policy table", "2020-JUL-9")^
    
SET TERM;^

COMMIT WORK;


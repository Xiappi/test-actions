set term ^;

/* this procedure should have been deleted */
drop procedure tmp_clone_rules^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201215ML000", "RT-379 - deleted tmp proc that was left behind", "2020-DEC-17");
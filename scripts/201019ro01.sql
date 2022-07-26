set term ^;
                      
update rule_details set rule_active = 0 where name = "BusinessInterruption"^

commit work^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201019ro01", "BCSB-834 - MEF rule for Biz Interruption", "2020-10-19");

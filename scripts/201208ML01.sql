set term ^;

update county
   set field_default = 1
 where state = 'MT'
   and line in ('RP', 'OP', 'SP')
   and effective_date <= 'NOW'
   and expired_date > 'NOW'
   and county_desc = 'Malta'^   

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201208ML01", "BCSB-1321 - default county for SME lines", "2020-DEC-08");
set term ^;

update ref_table
   set farm_type = '|NOADD|NODELETE|'
 where ref_code = 'LINEMODULE'
   and line in ('RP', 'OP', 'SP')
   and ref_key = 'F'
   and 'today' between effective_date and expired_date^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201120AO01', 'BCSB-1207 - ArgusMT cant add or delete FN', '2020-NOV-20');
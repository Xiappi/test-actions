set term !;

update custom_source_code
   set name = 'LocationAtLeastOne_ArgusMT'
 where name = 'LocationAtLeastOne'!

set term ;!

insert into applied_scripts (name, description, script_date)
     values ('201120jb02', 'BCSB-946 fix duplicate rule names', '2020-NOV-20');
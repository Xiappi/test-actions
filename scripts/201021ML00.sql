set term ^;

update rule_details
set name = 'OriginalOnly_ArgusMT'
where name = 'OriginalOnly'^

update custom_source_code
set name = 'OriginalOnly_ArgusMT'
where name = 'OriginalOnly'^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('201021ML00', 'RT-161 - fixing duplicate rule names', '2020-Sept-21');
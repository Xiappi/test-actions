set term ^;
                      
update notification_categories nc
set nc.description = 'Policy Schedule'
where nc.name = 'DECPG'^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210112DC01", "BCSB-1481 - change policy declaration to policy schedule", "2021-Jan-12");
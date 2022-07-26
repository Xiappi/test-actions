set term ^;

update company_config_values
set config_value = 'NO'
where config_key = 'SECONDARYENABLED'^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210818AM02', 'MHM-284 - co-applicant option malta default', '2021-August-18');

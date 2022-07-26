set term ^;
                      
update company_config_sections
set description = 'Agent/Broker'
where description = 'Agent'^

update company_config_sections
set hint = 'Set the permitted date range for cancellations, for users with the Agent/Broker identity.'
where hint = 'Set the permitted date range for cancellations, for users with the Agent identity.'^

update company_config_sections
set hint = 'Set the permitted date range for mid-term changes, for users with the Agent/Broker identity.'
where hint = 'Set the permitted date range for mid-term changes, for users with the Agent identity.'^

update company_config_sections
set hint = 'Set the permitted date range for reinstatements, for users with the Agent/Broker identity.'
where hint = 'Set the permitted date range for reinstatements, for users with the Agent identity.'^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201020DC01", "BCSB-714 - add broker/brokerage word to agent/agency labels", "2020-Oct-20");

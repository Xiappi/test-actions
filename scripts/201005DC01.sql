set term ^;

update ais_security
set description = 'Agent/Broker'
where right_key = 'AG'^

update ais_security_modules
set description = 'Agency/Brokerage Management Permissions'
where module = 'ACYMANAGE'^

update ais_security
set description = 'Agency/Brokerage Manager'
where right_key = 'ACYMGR'^

update ais_security
set description = 'Agency/Brokerage Manager (Delete Documents)'
where right_key = 'ACMGRDOCDL'^

update ais_security
set description = 'Agency/Brokerage Manager (Read only)'
where right_key = 'ACYMGRVIEW'^

update ais_security
set description = 'Agent/Broker Reports'
where right_key = 'AGREPORT'^

update ais_security
set description = 'Change Agent/Broker'
where right_key = 'CHANGAGENT'^

update ref_table rt
set rt.ref_desc = 'Agency/Brokerage'
where rt.ref_code = 'ADTYPE'
and rt.effective_date <= 'NOW'
and rt.expired_date >= 'NOW'
and rt.ref_key = 'AC'^

update ref_table rt
set rt.ref_desc = 'Agent/Broker'
where rt.ref_code = 'ADTYPE'
and rt.effective_date <= 'NOW'
and rt.expired_date >= 'NOW'
and rt.ref_key = 'AG'^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201005DC01", "BCSB-561 - add broker/brokerage word to agent/agency labels", "2020-Oct-05");
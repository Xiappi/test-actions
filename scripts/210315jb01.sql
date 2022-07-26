set term ^;

create procedure tmp_update_auth_limit
as
    declare variable var_auth_limit_id integer;
    declare variable var_detail_id     integer;
    declare variable var_security_id   integer;
    declare variable var_activity_id   integer;
begin
	for select ral.auth_limit_id
      from rule_details rd
      join custom_source_code csc
                 on csc.code_id = rd.code_id
      join rule_authorization_limits ral
                 on ral.rule_detail_id = rd.rule_detail_id
      join rule_authorization_limits_identity rali
                 on rali.auth_limit_id = ral.auth_limit_id
      join ais_security s
                 on s.id = rali.security_id
     where csc.name = 'AuthorizationLimitBuildingsRent'
       and s.right_key in ('UW', 'UWSR', 'UWMGR', 'MGMTSR')
      into :var_auth_limit_id
do
begin
    update rule_authorization_limits
       set from_limit = 100001
     where auth_limit_id = :var_auth_limit_id;
end
end^

execute procedure tmp_update_auth_limit^

commit work^

drop procedure tmp_update_auth_limit^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210315jb01", "BCSB-1826 Update buildings rent auth limit", "2021-MAR-15");
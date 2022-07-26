set term ^;

create procedure tmp_new_security_right(in_right_key varchar(10), in_right_description varchar(50))
as
    declare variable var_module_id integer;
begin
    select id
      from ais_security_modules
     where module = 'IDENTITY'
      rows 1
      into :var_module_id;

    insert into ais_security(module_id, id, right_key, description)
         values (:var_module_id, gen_id(AIS_SECURITY_GEN, 1), :in_right_key, :in_right_description);
end^

commit work^

execute procedure tmp_new_security_right('UWMGR', 'Underwriting Manager')^

commit work^

drop procedure tmp_new_security_right^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201118ML02", "created underwriting manager security right", "2020-NOV-18");
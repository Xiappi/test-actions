set term ^;

create procedure tmp_add_ag_workflow_200
as
    declare variable var_workflow_level_id integer;
    declare variable var_security_id       integer;
begin
    select wl.workflow_level_id
      from workflow_master wm
      join workflow_levels wl on wl.workflow_id = wm.workflow_id
     where wl.workflow_level = 200
       and wm.name = 'APPLICATION' rows 1
      into :var_workflow_level_id;

    select s.id
      from ais_security s
     where s.right_key = 'AG' rows 1
      into :var_security_id;

    if(:var_workflow_level_id is not null and :var_security_id is not null) then
    begin
        insert into workflow_levels_identity (workflow_level_id, security_id)
             values (:var_workflow_level_id, :var_security_id);
    end
end^

commit work^

execute procedure tmp_add_ag_workflow_200^

commit work^

drop procedure tmp_add_ag_workflow_200^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210624ML01", "MHM-425 - add AG to workflow level 200", "2021-JUN-24");
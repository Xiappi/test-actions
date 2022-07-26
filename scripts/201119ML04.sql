set term ^;

create procedure tmp_add_uwmgr_right_to_tasks
as
    declare variable var_exists             smallint;
    declare variable var_right_id           integer;
    declare variable var_activity_id        integer;
    declare variable var_security_level_key varchar(10);
begin
    var_exists = 0;

    select id
      from ais_security
     where right_key = 'UWMGR' rows 1
      into :var_right_id;

    for select ta.activity_id,
               tar.security_level_key
          from task_activity ta
          join rule_unauthorized_task_link rutl
                     on rutl.activity_id = ta.activity_id
          join task_activity_rights tar
                     on tar.activity_id = ta.activity_id
          join ais_security s
                     on s.id = tar.security_key_id
         where s.right_key = 'UWSR'
          into :var_activity_id,
               :var_security_level_key
    do
    begin
        select 1
          from task_activity_rights
         where activity_id = :var_activity_id
           and security_level_key = :var_security_level_key
           and security_key_id = :var_right_id
          into :var_exists;

        if(:var_exists = 0) then
        begin
            insert into task_activity_rights (activity_id, security_key_id, security_level_key)
                 values (:var_activity_id, :var_right_id, :var_security_level_key);
        end
    end
end^

delete from task_activity_rights
where activity_id is null^

execute procedure tmp_add_uwmgr_right_to_tasks^

commit work^

drop procedure tmp_add_uwmgr_right_to_tasks^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201119ML04", "RT-178 - fixed UWMGR task rights", "2020-NOV-19");
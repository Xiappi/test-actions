set term ^;

create procedure tmp_insert_missing_task_identities (
    in_right_key varchar(10))
as
    declare variable var_current_activity_id integer;
    declare variable var_current_level_key   varchar(10);

    declare variable var_uwsr_security_id    integer;
    declare variable var_target_security_id  integer;
    declare variable var_mgmtsr_security_id  integer;
begin
    select id
      from ais_security
     where right_key = 'UWSR' rows 1
      into :var_uwsr_security_id;

    select id
      from ais_security
     where right_key = :in_right_key rows 1
      into :var_target_security_id;

    for select tar.activity_id,
               tar.security_level_key
          from task_activity_rights tar
         group by tar.activity_id, tar.security_key_id, tar.security_level_key
         having tar.security_key_id = :var_uwsr_security_id and tar.security_level_key = 'VIEW' and (select count(*)
                                                                                                       from task_activity_rights tar2
                                                                                                      where tar2.activity_id = tar.activity_id
                                                                                                        and tar2.security_level_key = tar.security_level_key
                                                                                                        and tar2.security_key_id = :var_target_security_id) = 0  
          into :var_current_activity_id,
               :var_current_level_key
    do
    begin
        insert into task_activity_rights (
                     activity_id, security_key_id, security_level_key)
             values (:var_current_activity_id, :var_target_security_id, :var_current_level_key);
    end
end^ 

create procedure tmp_insert_missing_workflow_identities (
    in_right_key varchar(10))
as
    declare variable var_current_workflow_level_id integer;
    declare variable var_current_security_id       integer;
    declare variable var_exists                    smallint;
    declare variable var_uwsr_security_id          integer;
    declare variable var_target_security_id        integer;
    declare variable var_mgmtsr_security_id        integer;
begin
    select id
      from ais_security
     where right_key = 'UWSR' rows 1
      into :var_uwsr_security_id;

    select id
      from ais_security
     where right_key = :in_right_key rows 1
      into :var_target_security_id;

    for select workflow_level_id,
               security_id
          from workflow_levels_identity
         where security_id = :var_uwsr_security_id
          into :var_current_workflow_level_id,
               :var_current_security_id
    do
    begin
        var_exists = 0;

        select 1
          from workflow_levels_identity
         where workflow_level_id = :var_current_workflow_level_id
           and security_id = :var_target_security_id rows 1
          into :var_exists;

        if (:var_exists <> 1) then
        begin
            insert into workflow_levels_identity (workflow_level_id, security_id)
                 values (:var_current_workflow_level_id, :var_target_security_id);
        end
    end
end^

execute procedure tmp_insert_missing_task_identities('UWMGR')^
execute procedure tmp_insert_missing_task_identities('MGMTSR')^

execute procedure tmp_insert_missing_workflow_identities('UWMGR')^
execute procedure tmp_insert_missing_workflow_identities('MGMTSR')^

commit work^

drop procedure tmp_insert_missing_task_identities^
drop procedure tmp_insert_missing_workflow_identities^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201127ML03", "RT-348 - insert missing identities into workflow_identity", "2020-NOV-26");
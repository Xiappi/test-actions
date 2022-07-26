set term ^;

update task_activity
   set task_message = 'A transaction has been submitted that requires review for the following reasons: {REASONS}'
 where activity_name = 'TASKAPP'^

delete from workflow_rules_link del
      where exists(select 1
                     from workflow_master wm
                     join workflow_levels wl
                                on wl.workflow_id = wm.workflow_id
                     join workflow_rules_link wrl
                                on wrl.workflow_level_id = wl.workflow_level_id
                     join rule_categories rc
                                on rc.rule_category_id = wrl.rule_category_id
                    where rc.rule_code = 'UNDERWRITING'
                      and wl.workflow_level > 100
                      and del.workflow_rules_link_id = wrl.workflow_rules_link_id)^

create procedure tmp_fix_task_permissions (
    in_activity_name varchar(20))
as
    declare variable var_ag_id       integer;
    declare variable var_right_id    integer;
    declare variable var_activity_id integer;
begin
    select id
      from ais_security
     where right_key = 'AG' rows 1
      into :var_ag_id;

    select activity_id
      from task_activity
     where activity_name = :in_activity_name rows 1
      into :var_activity_id;

    delete from task_activity_rights
     where activity_id = :var_activity_id
       and security_key_id = :var_ag_id
       and security_level_key = 'EDIT';

    for select id
          from ais_security
         where right_key in ('UW', 'UWSR', 'UWMGR', 'MGMTSR')
          into :var_right_id
    do
    begin
        insert into task_activity_rights (activity_id, security_key_id, security_level_key)
             values (:var_activity_id, :var_right_id, 'VIEW');

        insert into task_activity_rights (activity_id, security_key_id, security_level_key)
             values (:var_activity_id, :var_right_id, 'EDIT');
    end
end^

execute procedure tmp_fix_task_permissions('TASKAPP')^
execute procedure tmp_fix_task_permissions('TASKMTC')^
execute procedure tmp_fix_task_permissions('TASKRENEW')^

commit work^

drop procedure tmp_fix_task_permissions^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210208ML02", "BCSB-1551 - updated task review (application) message", "2021-FEB-08");
set term ^;

create procedure tmp_task_notifs (
    in_activity_name varchar(50),
    in_security_key  varchar(10),
    in_level         varchar(10))
as
    declare variable var_activity_id integer;
    declare variable var_security_id integer;
begin
    select activity_id
      from task_activity
     where activity_name = :in_activity_name rows 1
      into :var_activity_id;

    select id
      from ais_security
     where right_key = :in_security_key rows 1
      into :var_security_id;

    insert into task_activity_rights (activity_id, security_level_key, security_key_id)
         values (:var_activity_id, :in_level, :var_security_id);
end^

/* uwmgr notifications */
execute procedure tmp_task_notifs('TEXTMTC', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('TEXTMTC', 'UW', 'EDIT')^

create procedure tmp_task_group 
as
    declare variable var_activity_id integer;
    declare variable var_group_id integer;
begin
    select activity_id
      from task_activity
     where activity_name = "TEXTMTC" rows 1
      into :var_activity_id;

    select task_group_id
      from task_activity_groups
    where task_group_name = "TASKMTC" rows 1
      into :var_group_id;

    insert into TASK_ACTIVITY_GROUPS_LINK(id, task_group_id, activity_id)
         values (gen_id(GEN_TASK_GROUP_LINK_ID,1), :var_group_id, :var_activity_id);
end^

execute procedure tmp_task_group^

commit^

drop procedure tmp_task_notifs^
drop procedure tmp_task_group^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("210126AL02", "BCSB-1484 - inserting text mtr request", "2021-JAN-26");

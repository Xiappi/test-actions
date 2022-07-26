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
execute procedure tmp_task_notifs('GLASS_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('GLASS_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('PUBLICLIABILITY_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('MONEYLOCKEDSAFE_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('PRODUCTSLIABILITY_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('MONEYINTRANSIT_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('MONEYINTRANSIT_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('GOODSINTRANSIT_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('DETERIORATIONOFSTOCK_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('DETERIORATIONOFSTOCK_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('MACHINERY_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('MACHINERY_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('THEFTFIRST_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('THEFTFIRST_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('THEFTFULL_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('THEFTFULL_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('PERSONALACCIDENT_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('PERSONALACCIDENT_UWSR', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('ALLRISKS_UW', 'UWMGR', 'EDIT')^
execute procedure tmp_task_notifs('ALLRISKS_UW', 'UWSR', 'EDIT')^
execute procedure tmp_task_notifs('ALLRISKS_UWSR', 'UWMGR', 'EDIT')^


commit work^

drop procedure tmp_task_notifs^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201217ML03", "BCSB-1417 - inserting missing task permissions", "2020-DEC-17");
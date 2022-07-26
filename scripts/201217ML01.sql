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
execute procedure tmp_task_notifs('PUBLICLIABILITY_UWMGR', 'UWMGR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('MONEYINTRANSIT_UWMGR', 'UWMGR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('FIRE_UWMGR', 'UWMGR', 'EMAIL_NEW')^

/* mgmtsr notifications */
execute procedure tmp_task_notifs('EMPLOYERLIABILITY_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('EMPLOYERLIABILITYAGGREGATE_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('PUBLICLIABILITY_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('PRODUCTSLIABILITY_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('PERSONALACCIDENT_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('GLASS_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('MONEYINTRANSIT_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('MONEYLOCKEDSAFE_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('GOODSINTRANSIT_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('ALLRISKS_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('FIRE_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^
execute procedure tmp_task_notifs('TERRORISM_MGMTSR', 'MGMTSR', 'EMAIL_NEW')^

commit work^

drop procedure tmp_task_notifs^

set term ;^

insert into applied_scripts(name, description, script_date)
     values ("201217ML01", "BCSB-1417 - inserting notify on create/complete", "2020-DEC-17");
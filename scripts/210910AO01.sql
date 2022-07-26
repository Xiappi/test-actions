set term ^;

create procedure temp_configure_task_acitivity_rights (
    in_activity_name      varchar(50),
    in_right_key          varchar(10),
    in_security_level_key varchar(10))
as
    declare variable var_task_activity_id integer;
    declare variable var_ais_security_id  integer;
begin
   select ta.activity_id
    from task_activity ta
   where ta.activity_name = :in_activity_name
    into :var_task_activity_id;

   select asec.id
    from ais_security asec
   where asec.right_key = :in_right_key
    into :var_ais_security_id;

   insert into task_activity_rights(activity_id, security_key_id, security_level_key)
          values (:var_task_activity_id, :var_ais_security_id, :in_security_level_key);

  suspend;
end^

/* Add rights to the new task activity */
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'AG', 'VIEW')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'UW', 'VIEW')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'UWSR', 'VIEW')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'MGMTSR', 'VIEW')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'UWMGR', 'VIEW')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'UW', 'EDIT')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'UWSR', 'EDIT')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'MGMTSR', 'EDIT')^
execute procedure temp_configure_task_acitivity_rights('CAUTIONLIST', 'UWMGR', 'EDIT')^

drop procedure temp_configure_task_acitivity_rights^

set term ;^

insert into applied_scripts (name, description, script_date)
     values ('210910AO01', 'MHM-365 - caution list task rights', '2021-SEP-10');
SET TERM ^;

create procedure temp_create_view_activity_right (in_activity_name varchar(25), in_view_right_key varchar(10))
as
    declare variable var_task_id            integer;
    declare variable var_view_right_id      integer;
begin
    select activity_id
      from task_activity
     where activity_name = :in_activity_name
      into :var_task_id;

      select asec.id
      from ais_security asec
     where asec.right_key = :in_view_right_key
      into :var_view_right_id;

    /* insert VIEW permissions */
    if(:var_view_right_id is not null) then
    begin
        insert into task_activity_rights (activity_id, security_level_key, security_key_id)
             values (:var_task_id, 'VIEW', :var_view_right_id);
    end
end^

create procedure temp_create_edit_activity_right (in_activity_name varchar(25), in_edit_right_key varchar(10))
as
    declare variable var_task_id            integer;
    declare variable var_edit_right_id      integer;
begin
    select activity_id
      from task_activity
     where activity_name = :in_activity_name
      into :var_task_id;

      select asec.id
      from ais_security asec
     where asec.right_key = :in_edit_right_key
      into :var_edit_right_id;

    /* insert EDIT permissions */
    if(:var_edit_right_id is not null) then
    begin
        insert into task_activity_rights (activity_id, security_level_key, security_key_id)
             values (:var_task_id, 'EDIT', :var_edit_right_id);
    end
end^

commit^

create procedure temp_create_activity_rights
as 
  declare variable var_view_right_id integer;
  declare variable var_edit_right_id integer;
begin
  execute procedure temp_create_view_activity_right('GLASS_10K', 'AG');
  execute procedure temp_create_view_activity_right('GLASS_10K', 'UW');
  execute procedure temp_create_view_activity_right('GLASS_10K', 'UWSR');
  execute procedure temp_create_view_activity_right('GLASS_10K', 'MGMTSR');  
  execute procedure temp_create_edit_activity_right('GLASS_10K', 'UW');
  execute procedure temp_create_edit_activity_right('GLASS_10K', 'UWSR');
  execute procedure temp_create_edit_activity_right('GLASS_10K', 'MGMTSR');

  execute procedure temp_create_view_activity_right('GLASS_25K', 'UW');
  execute procedure temp_create_view_activity_right('GLASS_25K', 'UWSR');
  execute procedure temp_create_view_activity_right('GLASS_25K', 'MGMTSR');  
  execute procedure temp_create_edit_activity_right('GLASS_25K', 'UWSR');
  execute procedure temp_create_edit_activity_right('GLASS_25K', 'MGMTSR');

  execute procedure temp_create_view_activity_right('GLASS_175K', 'UWSR');
  execute procedure temp_create_view_activity_right('GLASS_175K', 'MGMTSR');  
  execute procedure temp_create_edit_activity_right('GLASS_175K', 'MGMTSR');
end^

commit^

execute procedure temp_create_activity_rights^

commit^

drop procedure temp_create_activity_rights^
drop procedure temp_create_view_activity_right^
drop procedure temp_create_edit_activity_right^

commit^

INSERT INTO applied_scripts(NAME, DESCRIPTION, SCRIPT_DATE)
VALUES ("200918ML04", "create glass task rights", "09-21-2020")^

SET TERM ;^
COMMIT WORK;
